local Globals = require("sewn_scripts.core.globals")
local Delay = require("sewn_scripts.helpers.delay")
local CColor = require("sewn_scripts.helpers.ccolor")

local BurningFart = { }
BurningFart.SubType = 75
BurningFart.Gfx = "/gfx/effects/burning_fart.png"
BurningFart.Stats = {
    BurningDurationMin = 62,
    BurningDurationMax = 152
}

local function GetFart(subtype, frameCountMax)
    subtype = subtype or -1
    frameCountMax = frameCountMax or 0
    local farts = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.FART, subtype, false, false)

    for _, fart in ipairs(farts) do
        if fart.FrameCount <= frameCountMax then
            return fart:ToEffect()
        end
    end
end

local function GetNpcDependingOnPoison(position, isPoison)
    local npcs = Isaac.FindInRadius(position, 1000, EntityPartition.ENEMY)

    local foundNpcs = { }
    for _, npc in ipairs(npcs) do
        if npc:HasEntityFlags(EntityFlag.FLAG_POISON) == isPoison then
            table.insert(foundNpcs, npc)
        end
    end

    return foundNpcs
end

function BurningFart:EntityTakeDamage(entity, amount, flags, source, countdown)
    Delay:DelayFunction(function ()
        local fart = GetFart(nil, 1)
        
        if fart == nil then
            return
        end

        local eData = fart:GetData()
        if eData.Sewn_isBurningFart ~= true then
            return
        end

        entity:ClearEntityFlags(EntityFlag.FLAG_NO_STATUS_EFFECTS)

        local rng = fart:GetDropRNG()
        local duration = rng:RandomInt( BurningFart.Stats.BurningDurationMax - BurningFart.Stats.BurningDurationMin ) + BurningFart.Stats.BurningDurationMin
        entity:AddBurn(EntityRef(fart), duration, 1)
    end)
end

function BurningFart:EffectInit(effect)
    if effect.Variant ~= EffectVariant.FART or effect.SubType ~= BurningFart.SubType then
        return
    end

    local nonPoisonnedNPCs = GetNpcDependingOnPoison(effect.Position, false)

    for _, nonPoisonnedNPC in ipairs(nonPoisonnedNPCs) do
        nonPoisonnedNPC:AddEntityFlags(EntityFlag.FLAG_NO_STATUS_EFFECTS)
    end

    -- Create a normal fart
    Globals.Game:Fart(effect.Position, nil, effect.SpawnerEntity, nil, nil, CColor(1, 1, 1, 1))

    -- Get the spawned fart
    local fart = GetFart()
    if fart ~= nil then
        -- Tell the effect is is a burning fart
        local eData = fart:GetData()
        eData.Sewn_isBurningFart = true
        -- Change it sprite to the buring fart sprite
        local sprite = fart:GetSprite()
        sprite:ReplaceSpritesheet(0, BurningFart.Gfx)
        sprite:LoadGraphics()
    end
end

return BurningFart