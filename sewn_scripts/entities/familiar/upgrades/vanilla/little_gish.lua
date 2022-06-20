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

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.LITTLE_GISH,
    "Tears create a puddle of creep on hit#{{ArrowUp}} Slight Tears Up",
    "Larger creep#{{ArrowUp}} Tears Up##{{ArrowUp}} Damage Up", nil, "Little Gish"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.LITTLE_GISH,
    "眼泪在击中时将会额外生成一滩减速液体 #{{ArrowUp}} 射速略微提升",
    "生成更大范围的液体 #{{ArrowUp}} 射速提升#{{ArrowUp}} 攻击提升", nil, "Little Gish","zh_cn"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.LITTLE_GISH,
    "Tears create a puddle of creep on hit#Slight Tears Up (x1.14)",
    "Larger creep#Tears Up (x1.43)#Damage Up (x1.3)"
)

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