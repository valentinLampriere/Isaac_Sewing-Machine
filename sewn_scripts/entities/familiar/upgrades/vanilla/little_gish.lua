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
    "{{ArrowUp}} Slight Tears Up#Tears create a puddle of slowing creep on hit",
    "{{ArrowUp}} Damage Up#{{ArrowUp}} Tears Up#{{ArrowUp}} Creep Size Up", nil, "Little Gish"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.LITTLE_GISH,
    "眼泪在击中时将会额外生成一滩减速液体 #{{ArrowUp}} 射速略微提升",
    "生成更大范围的减速液体 #{{ArrowUp}} 射速提升#{{ArrowUp}} 攻击提升", nil, "吉什宝宝","zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.LITTLE_GISH,
    "{{ArrowUp}} Малая скорострельность +#Слёзы оставляют черную лужицу",
    "{{ArrowUp}} Скорострельность +#{{ArrowUp}} Урон +#{{ArrowUp}} Размер лужи +", nil, "Маленький Гиш", "ru"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.LITTLE_GISH,
    "{{ArrowUp}} Léger Débit#Ses larmes répandent une flaque collante au contact",
    "{{ArrowUp}} Dégâts#{{ArrowUp}} Débit#{{ArrowUp}} Taille des flaques", nil, "P'tit Gish", "fr"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.LITTLE_GISH,
    "TLas lágrimas crean lagos de creep cuando dan a algo#{{ArrowUp}} + Lágrimas ligeramente",
    "Creep más grande#{{ArrowUp}} + Lágrimas##{{ArrowUp}} + Daño", nil, "Pequeño Gish", "spa"
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