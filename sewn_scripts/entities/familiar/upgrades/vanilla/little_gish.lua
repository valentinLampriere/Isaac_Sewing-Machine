local Globals = require("sewn_scripts.core.globals")
local Delay = require("sewn_scripts.helpers.delay")

local LittleGish = { }

LittleGish.Stats = {
    DamageBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.3
    },
    TearRateBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 3,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 9
    },
    CreepSize = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1.2,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 2
    }
}
Sewn_API:MakeFamiliarAvailable(FamiliarVariant.LITTLE_GISH, CollectibleType.COLLECTIBLE_LITTLE_GISH)

function LittleGish:OnFamiliarTearUpdate(familiar, tear)
    local fData = familiar:GetData()
    Delay:DelayFunction(function(_tear)
        if not _tear:Exists() then
            local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_BLACK, 0, _tear.Position, Globals.V0, familiar):ToEffect()
            creep.Size = creep.Size * LittleGish.Stats.CreepSize[Sewn_API:GetLevel(fData)]
            creep.SpriteScale = creep.SpriteScale * LittleGish.Stats.CreepSize[Sewn_API:GetLevel(fData)]
            creep:Update()
        end
    end, 1, true, tear)
end

function LittleGish:OnFireTear(familiar, tear)
    local fData = familiar:GetData()
    familiar.FireCooldown = familiar.FireCooldown - LittleGish.Stats.TearRateBonus[Sewn_API:GetLevel(fData)]
    tear.CollisionDamage = tear.CollisionDamage * LittleGish.Stats.DamageBonus[Sewn_API:GetLevel(fData)]
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_TEAR_UPDATE, LittleGish.OnFamiliarTearUpdate, FamiliarVariant.LITTLE_GISH)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, LittleGish.OnFireTear, FamiliarVariant.LITTLE_GISH)