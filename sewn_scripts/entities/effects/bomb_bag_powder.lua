local Enums = require("sewn_scripts.core.enums")
local Globals = require("sewn_scripts.core.globals")
local Delay = require("sewn_scripts.helpers.delay")
local CColor = require("sewn_scripts.helpers.ccolor")

local BombBagPowder = { }

BombBagPowder.Stats = {
    ChainReactionDelay = 1,
    FlameTimeout = 90,
    PowderFlameCooldownMax = 60,
    PowderFlameCooldownMin = 30,
}

function BombBagPowder:EffectInit(effect)
    if effect.Variant ~= Enums.EffectVariant.BOMB_BAG_POWDER then
        return
    end
    local eData = effect:GetData()
    effect.RenderZOffset = -100
    eData.Sewn_bombBagPowder_flameCooldown = effect:GetDropRNG():RandomInt( BombBagPowder.Stats.PowderFlameCooldownMax - BombBagPowder.Stats.PowderFlameCooldownMin ) + BombBagPowder.Stats.PowderFlameCooldownMin
    eData.Sewn_bombBagPowder_chainReactionPowder = 1
end

local function PowderFadeOut(powder, a)
    local c = powder:GetColor()
    a = a or 1
    a = a - 0.1
    if a > 0 then
        powder:SetColor(CColor(c.R, c.G, c.B, a), -1, 1, false, false)
        Delay:DelayFunction(function ()
            PowderFadeOut(powder, a)
        end, 1)
    else
        powder:Remove()
    end
end

local function SpawnFlame(powder)
    local eData = powder:GetData()
    eData.Sewn_bombBagPowder_chainReactionPowder = eData.Sewn_bombBagPowder_chainReactionPowder or 1
    local flame = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HOT_BOMB_FIRE, 0, powder.Position, Globals.V0, powder):ToEffect()
    flame.Timeout = BombBagPowder.Stats.FlameTimeout
    local scaleFactor = 0.3 * math.log(eData.Sewn_bombBagPowder_chainReactionPowder, 10)
    local scale = 1 - scaleFactor
    flame.Scale = scale
    flame.CollisionDamage = flame.CollisionDamage - math.log(eData.Sewn_bombBagPowder_chainReactionPowder, 10)
    flame.SpriteScale = Vector(scale, scale)
end

local function Explode(powder)
    local eData = powder:GetData()
    powder:Remove()
    
    SpawnFlame(powder)

    Delay:DelayFunction(function ()
        local powders = Isaac.FindByType(EntityType.ENTITY_EFFECT, Enums.EffectVariant.BOMB_BAG_POWDER, -1, true, false)
        for _, _powder in ipairs(powders) do
            if (powder.Position - _powder.Position):LengthSquared() <= (powder.Size + _powder.Size) ^2 then
                local _eData = _powder:GetData()
                _eData.Sewn_bombBagPowder_chainReactionPowder = eData.Sewn_bombBagPowder_chainReactionPowder + 1
                Explode(_powder)
            end
        end
    end, BombBagPowder.Stats.ChainReactionDelay)
end

local function TouchFlame(position, size)
    -- Red Candle flame
    local redFlames = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.RED_CANDLE_FLAME, -1, true, false)
    for i, redFlame in ipairs(redFlames) do
        if (redFlame.Position - position):LengthSquared() <= (redFlame.Size + size) ^2 then
            return true
        end
    end
    -- Hot Bomb Fire
    local hotBombFires = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.HOT_BOMB_FIRE, -1, true, false)
    for i, hotBombFire in ipairs(hotBombFires) do
        if (hotBombFire.Position - position):LengthSquared() <= (hotBombFire.Size + size) ^2 then
            return true
        end
    end
    -- Flame Tear
    local fireTears = Isaac.FindByType(EntityType.ENTITY_TEAR, TearVariant.FIRE, -1, true, false)
    for i, fireTear in ipairs(fireTears) do
        if (fireTear.Position - position):LengthSquared() <= (fireTear.Size + size) ^2 then
            return true
        end
    end
    -- Fire Place
    local firePlaces = Isaac.FindByType(EntityType.ENTITY_FIREPLACE, -1, -1, true, false)
    for i, firePlace in ipairs(firePlaces) do
        if firePlace.HitPoints > 1 then
            if (firePlace.Position - position):LengthSquared() <= (firePlace.Size + size) ^2 then
                return true
            end
        end
    end
end

function BombBagPowder:EffectUpdate(effect)
    if effect.Variant ~= Enums.EffectVariant.BOMB_BAG_POWDER then
        return
    end

    if effect.Timeout == 1 then
        PowderFadeOut(effect)
    elseif effect.Timeout <= 0 then
        return
    end

    local bombExplosions = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.BOMB_EXPLOSION, -1, true, false)
    for _, explosion in ipairs(bombExplosions) do
        if (explosion.Position - effect.Position):LengthSquared() <= (explosion.Size * 1.5 + effect.Size) ^2 then
            Explode(effect)
            return
        end
    end

    local eData = effect:GetData()
    if TouchFlame(effect.Position, effect.Size) then
        eData.Sewn_bombBagPowder_flameCooldown = eData.Sewn_bombBagPowder_flameCooldown - 1
        if eData.Sewn_bombBagPowder_flameCooldown <= 0 then
            SpawnFlame(effect)
            effect:Remove()
        end
    end
end

return BombBagPowder