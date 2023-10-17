local BurstTears = require("sewn_scripts.helpers.burst_tears")
local IsSpawnedBy = require("sewn_scripts.helpers.is_spawned_by")

local JuicySack = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.JUICY_SACK, CollectibleType.COLLECTIBLE_JUICY_SACK)

JuicySack.Stats = {
    CreepScale = 1.5,
    EggTearsMin = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1
    },
    EggTearsMax = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 2,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 6
    },
    CooldownMin = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 30,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 20
    },
    CooldownMax = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 60,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 40
    }
}

local function TryToScaleCreepFrom(familiar)
    local creeps = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_WHITE, -1, false, false)
    for _, creep in ipairs(creeps) do
        local eData = creep:GetData()
        if IsSpawnedBy(creep, familiar) and eData.Sewn_juicySack_creepIsScaled == nil then
            creep.Size = creep.Size * JuicySack.Stats.CreepScale
            creep.SpriteScale = creep.SpriteScale * JuicySack.Stats.CreepScale
            eData.Sewn_juicySack_creepIsScaled = true
        end
    end
end

function JuicySack:OnFamiliarUpdate(familiar)
    TryToScaleCreepFrom(familiar)

    if familiar.FireCooldown == 0 then
        local fData = familiar:GetData()
        local level = Sewn_API:GetLevel(fData)
        local nbEggTear = familiar:GetDropRNG():RandomInt(JuicySack.Stats.EggTearsMax[level] - JuicySack.Stats.EggTearsMin[level]) + JuicySack.Stats.EggTearsMin[level]

        if familiar.Player:GetShootingInput():LengthSquared() > 0 then
            BurstTears(familiar, nbEggTear, nil, 4, false, TearVariant.EGG, TearFlags.TEAR_EGG)
            familiar.FireCooldown = familiar:GetDropRNG():RandomInt(JuicySack.Stats.CooldownMax[level] - JuicySack.Stats.CooldownMin[level]) + JuicySack.Stats.CooldownMin[level]
        end
    else
        familiar.FireCooldown = familiar.FireCooldown - 1
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, JuicySack.OnFamiliarUpdate, FamiliarVariant.JUICY_SACK)