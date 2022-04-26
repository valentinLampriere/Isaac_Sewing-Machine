local Delay = require("sewn_scripts.helpers.delay")

local PaschalCandle = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.PASCHAL_CANDLE, CollectibleType.COLLECTIBLE_PASCHAL_CANDLE)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.PASCHAL_CANDLE,
    "When the player takes damage, spreads flames around itself#The amount of flames depends on the size of the flame's candle",
    "Taking damage only reduces the flame's size by one step", nil, "Paschal Candle"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.PASCHAL_CANDLE,
    nil, nil,
    "The whole familiar mechanic have been rewrite for the ultra upgrade.#Each time the player clean a room, the stat in the Found HUD will get reset and the bonus will be applied resulting in a weird effect.#This is only a visual effect in the Found HUD."
)

PaschalCandle.Stats = {
    FlameDamageMultiplierMax = 1.5,
    FlameDamageMultiplierMin = 0.3,
    FlameVelocityMax = 6,
    FlameScale = 0.8,
    FlameDurationMax = 300,
    FlameDurationMin = 30,
}

-- Code given by AgentCucco
local function tearsUp(firedelay, val)
    local currentTears = 30 / (firedelay + 1)
    local newTears = currentTears + val
    return math.max((30 / newTears) - 1, -0.99)
end

local function ThrowFlame(familiar)
    local force = PaschalCandle.Stats.FlameVelocityMax
    local velocity = Vector(math.random(-force, force), math.random(-force, force))
    local flame = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HOT_BOMB_FIRE, 0, familiar.Position, velocity, familiar):ToEffect()
    
    local damageMultiplier = familiar:GetDropRNG():RandomFloat() * ( PaschalCandle.Stats.FlameDamageMultiplierMax - PaschalCandle.Stats.FlameDamageMultiplierMin ) + PaschalCandle.Stats.FlameDamageMultiplierMin
    
    flame.CollisionDamage = flame.CollisionDamage * damageMultiplier
    flame.Size = flame.Size * math.sqrt(damageMultiplier * PaschalCandle.Stats.FlameScale)
    flame.SpriteScale = flame.SpriteScale * math.sqrt(damageMultiplier * PaschalCandle.Stats.FlameScale)

    flame.Timeout = familiar:GetDropRNG():RandomInt( PaschalCandle.Stats.FlameDurationMax - PaschalCandle.Stats.FlameDurationMin ) + PaschalCandle.Stats.FlameDurationMin
end

function PaschalCandle:FamiliarUpgraded(familiar, isPermanentUpgrade)
    local fData = familiar:GetData()

    Sewn_API:AddCrownOffset(familiar, Vector(0, 7 ))

    fData.Sewn_paschalCandle_vanillaFlame = 1
end

function PaschalCandle:FamiliarUpdate_Super(familiar)
    local fData = familiar:GetData()
    local sprite = familiar:GetSprite()
    for i = 0, 6 do
        if sprite:IsPlaying("Idle"..i) then
            fData.Sewn_paschalCandle_vanillaFlame = i
            break
        end
    end
end
function PaschalCandle:PlayerTakeDamage(familiar, player, flag, source)
    local fData = familiar:GetData()

    local canFire = fData.Sewn_paschalCandle_vanillaFlame > 0
    local minFlame = math.floor(math.sqrt(10 * fData.Sewn_paschalCandle_vanillaFlame))
    local maxFlame = math.floor(math.sqrt(10 * fData.Sewn_paschalCandle_vanillaFlame) * 2.5)
   
    if canFire == true then
        local rollFlames = math.random(minFlame, maxFlame)
        for i = 0, rollFlames do
            Delay:DelayFunction(ThrowFlame, i * 2 + 1, false, familiar)
        end
    end
end

function PaschalCandle:FamiliarUpgraded_Ultra(familiar, isPermanentUpgrade)
    local fData = familiar:GetData()

    fData.Sewn_paschalCandle_currentFlameFrame = 0
    fData.Sewn_paschalCandle_currentFlame = 1
end
function PaschalCandle:FamiliarUpdate_Ultra(paschalCandle)
    local fData = paschalCandle:GetData()
    local sprite = paschalCandle:GetSprite()

    for i = 0, 6 do
        if sprite:IsPlaying("Idle"..i) then
            if fData.Sewn_paschalCandle_vanillaFlame < i and fData.Sewn_paschalCandle_currentFlame == fData.Sewn_paschalCandle_vanillaFlame then -- The flame as the normal status
                fData.Sewn_paschalCandle_currentFlame = i
            elseif fData.Sewn_paschalCandle_vanillaFlame < i and fData.Sewn_paschalCandle_currentFlame > fData.Sewn_paschalCandle_vanillaFlame then
                fData.Sewn_paschalCandle_currentFlame = fData.Sewn_paschalCandle_currentFlame + 1
            end
            fData.Sewn_paschalCandle_vanillaFlame = i
            break
        end
    end
    -- Override the candle animation
    sprite:Play("Idle" .. fData.Sewn_paschalCandle_currentFlame)
    fData.Sewn_paschalCandle_currentFlameFrame = fData.Sewn_paschalCandle_currentFlameFrame + 1
    if fData.Sewn_paschalCandle_currentFlameFrame > 39 then
        fData.Sewn_paschalCandle_currentFlameFrame = 0
    end
    sprite:SetFrame(fData.Sewn_paschalCandle_currentFlameFrame)
end
function PaschalCandle:EvaluateCache_Ultra(familiar, cacheFlag)
    local fData = familiar:GetData()

    Delay:DelayFunction(function ()
        if fData.Sewn_paschalCandle_currentFlame > fData.Sewn_paschalCandle_vanillaFlame then
            familiar.Player.MaxFireDelay = tearsUp(familiar.Player.MaxFireDelay, 0.4 * (fData.Sewn_paschalCandle_currentFlame - fData.Sewn_paschalCandle_vanillaFlame))
        end
    end, 1)
end
function PaschalCandle:PlayerTakeDamage_Ultra(familiar, player, flag, source)
    local fData = familiar:GetData()

    fData.Sewn_paschalCandle_currentFlame = fData.Sewn_paschalCandle_currentFlame - 1

    if fData.Sewn_paschalCandle_vanillaFlame == 0 then
        familiar.Player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
        familiar.Player:EvaluateItems()
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, PaschalCandle.FamiliarUpgraded, FamiliarVariant.PASCHAL_CANDLE)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, PaschalCandle.FamiliarUpdate_Super, FamiliarVariant.PASCHAL_CANDLE, Sewn_API.Enums.FamiliarLevelFlag.FLAG_SUPER)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_PLAYER_TAKE_DAMAGE, PaschalCandle.PlayerTakeDamage, FamiliarVariant.PASCHAL_CANDLE)

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, PaschalCandle.FamiliarUpgraded_Ultra, FamiliarVariant.PASCHAL_CANDLE, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, PaschalCandle.FamiliarUpdate_Ultra, FamiliarVariant.PASCHAL_CANDLE, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_PLAYER_TAKE_DAMAGE, PaschalCandle.PlayerTakeDamage_Ultra, FamiliarVariant.PASCHAL_CANDLE, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_EVALUATE_CACHE, PaschalCandle.EvaluateCache_Ultra, FamiliarVariant.PASCHAL_CANDLE, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA, CacheFlag.CACHE_FIREDELAY)