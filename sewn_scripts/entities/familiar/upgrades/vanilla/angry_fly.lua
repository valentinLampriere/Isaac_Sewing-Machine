local Globals = require("sewn_scripts.core.globals")

local AngryFly = { }

-- TODO : super: Increase Rage only when orbiting around the same enemy ?
AngryFly.Stats = {
    RageMaxLevel = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 8,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 10,
    },
    RageDamageBonusPerLevel = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0.35,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 0.4,
    },
    RageLevelFunction = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = function(rageCounter) return (rageCounter / (450 - AngryFly:GetStageLevel() * 5)) + 0.1 * AngryFly:GetStageLevel() end,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = function(rageCounter) return math.sqrt(rageCounter / (55 - AngryFly:GetStageLevel())) + 0.1 * AngryFly:GetStageLevel() end,
    },
    RageOnUpgradeFunction = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = function() return AngryFly:GetStageLevel() * 100 end,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = function() return AngryFly:GetStageLevel() * 100 end,
    },

    RageFlashBaseCooldown = 30 * 3, -- Base cooldown (based on level zero) for flash. Cooldown gets smaller for each level
    RageFlashMinCooldown = 5,

    RageDissipationFramePerHitFunction = { -- Each hit will dissipate the anger for X frames after the hit.
        [Sewn_API.Enums.FamiliarLevel.SUPER] = function(currentDissipationTime) return 30 * 2 ^ (-currentDissipationTime / 70) end,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = function(currentDissipationTime) return 20 * 2 ^ (-currentDissipationTime / 70) end,
    },
    RageDissipationPerFrameAfterHitFunction = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = function(frameAfterHit, rageLevel) return (rageLevel + 3) * (2.7 ^ (-0.2 * frameAfterHit)) + 1 end,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = function(frameAfterHit, rageLevel) return (rageLevel + 3) * (2.7 ^ (-0.15 * frameAfterHit)) + 1 end,
    }
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.ANGRY_FLY, CollectibleType.COLLECTIBLE_ANGRY_FLY)

local function GetRageLevel(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    local rageLevelRough = AngryFly.Stats.RageLevelFunction[level](fData.Sewn_angryFly_rageCounter)
    local intRageLevel = math.floor(rageLevelRough)
    return math.min(intRageLevel, AngryFly.Stats.RageMaxLevel[level])
end

function AngryFly:GetStageLevel()
    local level = Globals.Game:GetLevel()
    local stage = level:GetStage()

    if stage >= 10 then
        return 10
    end

    if stage >= LevelStage.STAGE4_3 then
        return stage - 1
    end

    return stage
end

function AngryFly:OnFamiliarInit(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    local initialRageCounter = fData.Sewn_angryFly_rageCounter or 0
    fData.Sewn_angryFly_rageCounter = math.max(initialRageCounter, AngryFly.Stats.RageOnUpgradeFunction[level]())
    fData.Sewn_angryFly_rageFlashCooldown = AngryFly.Stats.RageFlashBaseCooldown + AngryFly.Stats.RageFlashMinCooldown
    fData.Sewn_angryFly_rageDissipationLeft = 0 -- How much time (frame) left for rage dissipation
    fData.Sewn_angryFly_rageDissipationTime = 0 -- How long it is dissipating rage
end

local function HandleRageDissipation(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    local rageLevel = GetRageLevel(familiar)
    local rageToDecrease = AngryFly.Stats.RageDissipationPerFrameAfterHitFunction[level](fData.Sewn_angryFly_rageDissipationTime, rageLevel)

    for i = 1, rageToDecrease, 1 do
        if fData.Sewn_angryFly_rageCounter <= 0 then
            -- Already calm
            return
        end

        fData.Sewn_angryFly_rageCounter = fData.Sewn_angryFly_rageCounter - 1
    end

    fData.Sewn_angryFly_rageDissipationTime = fData.Sewn_angryFly_rageDissipationTime + 1
    fData.Sewn_angryFly_rageDissipationLeft = fData.Sewn_angryFly_rageDissipationLeft - 1
end

local function HandleRageGrow(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    fData.Sewn_angryFly_rageDissipationLeft = 0
    fData.Sewn_angryFly_rageDissipationTime = 0

    if Globals.Room:IsClear() == true and Globals.Room:IsAmbushActive() == false then
        return
    end

    local rageLevel = GetRageLevel(familiar)

    if rageLevel == AngryFly.Stats.RageMaxLevel[level] then
        return
    end

    fData.Sewn_angryFly_rageCounter = fData.Sewn_angryFly_rageCounter + 1
end

local function RenderRage(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    if fData.Sewn_angryFly_rageFlashCooldown > 0 then
        fData.Sewn_angryFly_rageFlashCooldown = fData.Sewn_angryFly_rageFlashCooldown - 1
        return
    end
    
    local rageLevel = GetRageLevel(familiar)
    if rageLevel == 0 then
        return
    end
    
    local color = familiar.Color
    color:SetOffset(0.7, 0.05, 0.05, 1)
    familiar:SetColor(color, 10, 2, true, false)

    local rageLevelMax = AngryFly.Stats.RageMaxLevel[level]
    local invRageLevel = (rageLevelMax - rageLevel) / rageLevelMax

    fData.Sewn_angryFly_rageFlashCooldown = math.max(invRageLevel * AngryFly.Stats.RageFlashBaseCooldown, AngryFly.Stats.RageFlashMinCooldown)
end

function AngryFly:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()

    if fData.Sewn_angryFly_rageDissipationLeft > 0 and fData.Sewn_angryFly_rageCounter > 0 then
        HandleRageDissipation(familiar)
    else
        HandleRageGrow(familiar)
    end

    RenderRage(familiar)
    
    fData.Sewn_angryFly_hasHitNpc = false
end

function AngryFly:OnFamiliarHitNpc(familiar, npc, damageAmount, damageFlags, entityRef, damageCountdown)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    local rageLevel = GetRageLevel(familiar)

    npc:TakeDamage(damageAmount + AngryFly.Stats.RageDamageBonusPerLevel[level] * rageLevel, damageFlags | DamageFlag.DAMAGE_CLONES, EntityRef(familiar), damageCountdown)

    fData.Sewn_angryFly_rageDissipationLeft = fData.Sewn_angryFly_rageDissipationLeft + AngryFly.Stats.RageDissipationFramePerHitFunction[level](fData.Sewn_angryFly_rageDissipationLeft)
    fData.Sewn_angryFly_rageDissipationTime = 0

    return false
end

function AngryFly:PreAddInSewingMachine(familiar, machine)
    local fData = familiar:GetData()
    local mData = machine:GetData().SewingMachineData

    mData.Sewn_angryFly_rage = fData.Sewn_angryFly_rageCounter
end

function AngryFly:GetFromSewingMachine(familiar, player, machine, isUpgraded, newLevel)
    local fData = familiar:GetData()
    local mData = machine:GetData().SewingMachineData

    fData.Sewn_angryFly_rageCounter = mData.Sewn_angryFly_rage or 0
end


Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_INIT, AngryFly.OnFamiliarInit, FamiliarVariant.ANGRY_FLY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, AngryFly.OnFamiliarInit, FamiliarVariant.ANGRY_FLY)

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.PRE_ADD_FAMILIAR_IN_SEWING_MACHINE, AngryFly.PreAddInSewingMachine, FamiliarVariant.ANGRY_FLY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_GET_FAMILIAR_FROM_SEWING_MACHINE, AngryFly.GetFromSewingMachine, FamiliarVariant.ANGRY_FLY)

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, AngryFly.OnFamiliarUpdate, FamiliarVariant.ANGRY_FLY)

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_HIT_NPC, AngryFly.OnFamiliarHitNpc, FamiliarVariant.ANGRY_FLY)