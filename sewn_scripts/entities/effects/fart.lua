local Globals = require("sewn_scripts.core.globals")
local Delay = require("sewn_scripts.helpers.delay")
local CColor = require("sewn_scripts.helpers.ccolor")

local Fart = { }

Fart.RegisteredFarts = { }

function Fart:RegisterFart(fart)
    if fart.SubType == nil then
        error("Can't register this fart effect")
        return
    end

    Fart.RegisteredFarts[fart.SubType] = fart
end

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

local function FindRegisteredFart(fart)
    fart = fart or GetFart(nil, 1)
        
    if fart == nil then
        return
    end

    for subtype, _fart in pairs(Fart.RegisteredFarts) do
        local eData = fart:GetData()
        if eData["Sewn_isFart"..subtype] == true then
            return fart, _fart
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

local function IsRegisteredFart(effect)
    for subtype, fart in pairs(Fart.RegisteredFarts) do
        if effect.SubType == subtype then
            return true
        end
    end
    return false
end

function Fart:EntityTakeDamage(entity, amount, flags, source, countdown)
    Delay:DelayFunction(function ()
        local fart, _fart = FindRegisteredFart()

        if fart == nil then
            return
        end

        entity:ClearEntityFlags(EntityFlag.FLAG_NO_STATUS_EFFECTS)

        if _fart.OnEntityTakeFartDamage ~= nil then
            _fart:OnEntityTakeFartDamage(entity, amount, flags, fart, countdown)
        end
    end)
end

function Fart:EffectInit(effect)
    if effect.Variant ~= EffectVariant.FART then
        return
    end

    if IsRegisteredFart(effect) == false then
        return
    end

    local _fart = Fart.RegisteredFarts[effect.SubType]

    local nonPoisonnedNPCs = GetNpcDependingOnPoison(effect.Position, false)

    for _, nonPoisonnedNPC in ipairs(nonPoisonnedNPCs) do
        nonPoisonnedNPC:AddEntityFlags(EntityFlag.FLAG_NO_STATUS_EFFECTS)
    end

    -- Create a normal fart
    Globals.Game:Fart(effect.Position, nil, effect.SpawnerEntity, nil, nil, CColor(1, 1, 1, 1))

    -- Get the spawned fart
    local fart = GetFart()
    if fart ~= nil then
        fart.SpawnerEntity = effect.SpawnerEntity
        fart.SpawnerType = effect.SpawnerType
        fart.SpawnerVariant = effect.SpawnerVariant

        -- Tell the effect is is a unique fart
        local eData = fart:GetData()
        eData["Sewn_isFart"..effect.SubType] = true

        if _fart.Gfx ~= nil then
            -- Change it sprite to the registerd fart sprite
            local sprite = fart:GetSprite()
            sprite:ReplaceSpritesheet(0, _fart.Gfx)
            sprite:LoadGraphics()
        end

        if _fart.OnFartInit ~= nil then
            _fart:OnFartInit(fart)
        end
    end
end

-- function Fart:EffectUpdate(effect)
--     if effect.Variant ~= EffectVariant.FART then
--         return
--     end

--     local fart, _fart = FindRegisteredFart(effect)

--     if fart ~= nil then
--         if _fart.OnFartUpdate ~= nil then
--             _fart:OnFartUpdate(fart)
--         end
--     end
-- end

return Fart