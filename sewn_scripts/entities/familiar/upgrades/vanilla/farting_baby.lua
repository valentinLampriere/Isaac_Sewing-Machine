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
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 33,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 45
    },
    Range = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 100,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 150
    },
    AdditionalFartsChance = {
        [BurningFart.SubType] = 28,
        [HolyFart.SubType] = 12
    }
}

local function SetCooldown(familiar)
    local fData = familiar:GetData()
    local rng = familiar:GetDropRNG()
    fData.Sewn_fartingBaby_fartCooldown = rng:RandomInt(FartingBaby.Stats.FartCooldownMax - FartingBaby.Stats.FartCooldownMin) + FartingBaby.Stats.FartCooldownMin
end

function FartingBaby:FamiliarInit(familiar)
    SetCooldown(familiar)
end

function FartingBaby:FamiliarUpdate(familiar)
    local fData = familiar:GetData()

    local sprite = familiar:GetSprite()
    if Sewn_API:IsUltra(fData) and sprite:IsPlaying("Hit") then
        if sprite:GetFrame() == 23 then
            for subType, chance in pairs(FartingBaby.Stats.AdditionalFartsChance) do
                if Random:CheckRoll(chance, familiar:GetDropRNG()) then
                    sprite:Play("Idle", true)
                    Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.FART, subType, familiar.Position, Globals.V0, familiar)
                    return
                end
            end
        end

        return
    end

    if Globals.Room:GetAliveEnemiesCount() == 0 then
        return
    end
    
    local level = Sewn_API:GetLevel(fData)

    if fData.Sewn_fartingBaby_fartCooldown > 0 then
        local npcs = Isaac.FindInRadius(familiar.Position, FartingBaby.Stats.Range[level], EntityPartition.ENEMY)

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

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, FartingBaby.FamiliarInit, FamiliarVariant.FARTING_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_INIT, FartingBaby.FamiliarInit, FamiliarVariant.FARTING_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, FartingBaby.FamiliarUpdate, FamiliarVariant.FARTING_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.PRE_FAMILIAR_COLLISION, FartingBaby.FamiliarCollision, FamiliarVariant.FARTING_BABY)