local Globals = require("sewn_scripts.core.globals")

local SissyLonglegs = { }

SissyLonglegs.Stats = {
    BlueSpiderCharmDurationMax = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 120,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 150
    },
    BlueSpiderCharmDurationMin = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 30,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 60
    },
    BlueSpidersFlatDamage = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 3,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 5
    },
    SpawnCooldownMax = 300,
    SpawnCooldownMin = 150,
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.SISSY_LONGLEGS, CollectibleType.COLLECTIBLE_SISSY_LONGLEGS)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.SISSY_LONGLEGS,
    "Sissy's spiders apply charm when they hit an enemy#When they hit an enemy, they deal an additional flat damage",
    "Spawn additioanl spiders#Increase charm duration and additional flat damage for blue spiders", nil, "Sissy Longlegs"
)

function SissyLonglegs:OnBlueSpiderHit(familiar, npc, amount, flags, source, countdown)
    local fData = familiar:GetData()
    if fData.Sewn_sissyLonglegs_sissyParent ~= nil then
        local sissy = fData.Sewn_sissyLonglegs_sissyParent.Ref
        local level = Sewn_API:GetLevel(sissy:GetData())
        local duration = familiar:GetDropRNG():RandomInt( SissyLonglegs.Stats.BlueSpiderCharmDurationMax[level] - SissyLonglegs.Stats.BlueSpiderCharmDurationMin[level] ) + SissyLonglegs.Stats.BlueSpiderCharmDurationMin[level]
        if REPENTANCE then
            npc:AddCharmed(EntityRef(familiar), duration)
        else
            npc:AddCharmed(duration)
        end
        npc:TakeDamage(SissyLonglegs.Stats.BlueSpidersFlatDamage[level], DamageFlag.DAMAGE_CLONES, EntityRef(familiar), countdown)
    end
end

function SissyLonglegs:OnSpawn(familiar, sprite)
    if sprite:IsEventTriggered("Spawn") then
        local fData = familiar:GetData()
        local blueSpiders = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_SPIDER, -1, false, false)
        for _, fam in ipairs(blueSpiders) do
            if (fam.Position - familiar.Position):LengthSquared() <= (fam.Size + familiar.Size)^2 and fam.FrameCount == 0 then
                fam:GetData().Sewn_sissyLonglegs_sissyParent = EntityPtr(familiar)
            end
        end
        fData.Sewn_sissyLonglegs_cooldownSpawn = familiar:GetDropRNG():RandomInt( SissyLonglegs.Stats.SpawnCooldownMax - SissyLonglegs.Stats.SpawnCooldownMin ) + SissyLonglegs.Stats.SpawnCooldownMin
    end
end

function SissyLonglegs:OnUpdate(familiar)
    local fData = familiar:GetData()

    if Globals.Room:IsClear() then
        if fData.Sewn_sissyLonglegs_cooldownSpawn <= 0 then
            local sprite = familiar:GetSprite()
            sprite:Play("Spawn", true)
            fData.Sewn_sissyLonglegs_cooldownSpawn = familiar:GetDropRNG():RandomInt( SissyLonglegs.Stats.SpawnCooldownMax - SissyLonglegs.Stats.SpawnCooldownMin ) + SissyLonglegs.Stats.SpawnCooldownMin
        else
            fData.Sewn_sissyLonglegs_cooldownSpawn = fData.Sewn_sissyLonglegs_cooldownSpawn - 1
        end
    end
end

function SissyLonglegs:OnInit(familiar)
    local fData = familiar:GetData()
    fData.Sewn_sissyLonglegs_cooldownSpawn = SissyLonglegs.Stats.SpawnCooldownMin
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_HIT_NPC, SissyLonglegs.OnBlueSpiderHit, FamiliarVariant.BLUE_SPIDER, Sewn_API.Enums.FamiliarLevelFlag.FLAG_NORMAL)

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_PLAY_ANIM, SissyLonglegs.OnSpawn, FamiliarVariant.SISSY_LONGLEGS, nil, "Spawn")

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_INIT, SissyLonglegs.OnInit, FamiliarVariant.SISSY_LONGLEGS, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, SissyLonglegs.OnInit, FamiliarVariant.SISSY_LONGLEGS, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, SissyLonglegs.OnUpdate, FamiliarVariant.SISSY_LONGLEGS, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)