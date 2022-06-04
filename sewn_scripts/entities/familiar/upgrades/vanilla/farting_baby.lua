local Debug = require("sewn_scripts.debug.debug")
local Random = require("sewn_scripts.helpers.random")
local Globals = require("sewn_scripts.core.globals")
local BurningFart = require("sewn_scripts.entities.effects.burning_fart")
local HolyFart = require("sewn_scripts.entities.effects.holy_fart")

local FartingBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.FARTING_BABY, CollectibleType.COLLECTIBLE_FARTING_BABY)

FartingBaby.Stats = {
    FartCooldownMin = 300,
    FartCooldownMax = 1600,
    FartChanceOnHit = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 25,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 40
    },
    Range = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 100,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 150
    },
    AdditionalFartsChance = {
        [BurningFart.SubType] = 2300,
        [HolyFart.SubType] = 8
    }
}

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.FARTING_BABY,
    "{{ArrowUp}} Increase chances to fart when getting hit#Have a chance to fart every few seconds. The more it is close from enemies, the more it has a chance to fart.",
    "{{ArrowUp}} Increase chances to fart#Gain two additional farts (Burning and Holy).", nil, "Farting Baby"
)

local function SetCooldown(familiar)
    local fData = familiar:GetData()
    local rng = familiar:GetDropRNG()
    fData.Sewn_fartingBaby_fartCooldown = rng:RandomInt(FartingBaby.Stats.FartCooldownMax - FartingBaby.Stats.FartCooldownMin) + FartingBaby.Stats.FartCooldownMin
end

function FartingBaby:FamiliarInit(familiar)
    SetCooldown(familiar)
end

function FartingBaby:FamiliarUpdate(familiar)
    if Globals.Room:GetAliveEnemiesCount() == 0 then
        return
    end
    
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    Debug:RenderText(fData.Sewn_fartingBaby_fartCooldown, "Farting Baby cooldown", Debug.Color.Green)

    if fData.Sewn_fartingBaby_fartCooldown > 0 then
        local npcs = Isaac.FindInRadius(familiar.Position, FartingBaby.Stats.Range[level], EntityPartition.ENEMY)
        
        Debug:RenderText(#npcs ,"FartingBabyNPC count")

        fData.Sewn_fartingBaby_fartCooldown = fData.Sewn_fartingBaby_fartCooldown - 1 - #npcs
        return
    end

    local sprite = familiar:GetSprite()
    sprite:Play("Hit", false)
    
    SetCooldown(familiar)
end

function FartingBaby:FamiliarCollision(familiar, collider)
    if collider.Type ~= EntityType.ENTITY_PROJECTILE then
        return
    end

    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    if Random:CheckRoll(FartingBaby.Stats.FartChanceOnHit[level]) then
        local sprite = familiar:GetSprite()
        sprite:Play("Hit", false)

        familiar.Player:GetEffects():AddTrinketEffect(TrinketType.TRINKET_GIGANTE_BEAN, false)

        SetCooldown(familiar)

        collider:Die()

        return true
    end
end

function FartingBaby:FamiliarUpdateUltra(familiar)
    local sprite = familiar:GetSprite()
    if sprite:IsPlaying("Hit") and sprite:GetFrame() == 23 then
        for subType, chance in pairs(FartingBaby.Stats.AdditionalFartsChance) do
            if Random:CheckRoll(chance, familiar:GetDropRNG()) then
                sprite:Play("Idle", true)
                Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.FART, subType, familiar.Position, Globals.V0, familiar)
                return
            end
        end
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, FartingBaby.FamiliarInit, FamiliarVariant.FARTING_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_INIT, FartingBaby.FamiliarInit, FamiliarVariant.FARTING_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, FartingBaby.FamiliarUpdate, FamiliarVariant.FARTING_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, FartingBaby.FamiliarUpdateUltra, FamiliarVariant.FARTING_BABY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.PRE_FAMILIAR_COLLISION, FartingBaby.FamiliarCollision, FamiliarVariant.FARTING_BABY)