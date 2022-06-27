local BurstTears = require("sewn_scripts.helpers.burst_tears")
local IsSpawnedBy = require("sewn_scripts.helpers.is_spawned_by")

local HeadlessBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.HEADLESS_BABY, CollectibleType.COLLECTIBLE_HEADLESS_BABY)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.HEADLESS_BABY,
    "{{ArrowUp}} Creep Damage Up#{{ArrowUp}} Creep Size Up",
    "{{ArrowUp}} Creep Damage Up#Fires burst of tears while isaac is firing", nil, "Headless Baby"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.HEADLESS_BABY,
    "产生范围更大的血迹 #{{ArrowUp}} 血迹伤害提升",
    "额外发射向上的爆裂眼泪 #{{ArrowUp}} 血迹伤害大幅提升", nil, "无头宝宝","zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.HEADLESS_BABY,
    "{{ArrowUp}} Урон лужи +#{{ArrowUp}} Размер лужи +",
    "{{ArrowUp}} Урон лужи +#Стреляет кучей слёз когда игрок стреляет", nil, "Безголовый Малыш", "ru"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.HEADLESS_BABY,
    "{{ArrowUp}} Dégâts de la trainée de sang#{{ArrowUp}} Taille de la trainée de sang",
    "{{ArrowUp}} Dégâts de la trainée de sang#Projette un tas de larmes quand Isaac tire", nil, "Bébé Décapité", "fr"
)

HeadlessBaby.Stats = {
    CreepDamageMultiplier = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1.4,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.8
    },
    CreepScale = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1.5,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.75
    },
    FireCooldown = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 45
    }
}

function HeadlessBaby:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()
    local creeps = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, -1, false, true)
    for _, creep in ipairs(creeps) do
        local eData = creep:GetData()
        creep = creep:ToEffect()
        if eData.Sewn_headlessBaby_creepInit == nil and IsSpawnedBy(creep, familiar) then
            local level = Sewn_API:GetLevel(fData)
            creep.Size = creep.Size * HeadlessBaby.Stats.CreepScale[level]
            creep.SpriteScale = creep.SpriteScale * HeadlessBaby.Stats.CreepScale[level]
            eData.Sewn_headlessBaby_creepInit = true
            creep.CollisionDamage = creep.CollisionDamage * HeadlessBaby.Stats.CreepDamageMultiplier[level]
        end
    end
end
function HeadlessBaby:OnFamiliarUpdate_Ultra(familiar)
    if familiar.FireCooldown <= 0 then
        if familiar.Player:GetShootingInput():LengthSquared() > 0 then
            local nbTears = familiar:GetDropRNG():RandomInt(8) + 5
            BurstTears(familiar, nbTears, nil, nil, true, TearVariant.BLOOD)
            familiar.FireCooldown = HeadlessBaby.Stats.FireCooldown[Sewn_API.Enums.FamiliarLevel.ULTRA]
        end
    else
        familiar.FireCooldown = familiar.FireCooldown - 1
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, HeadlessBaby.OnFamiliarUpdate, FamiliarVariant.HEADLESS_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, HeadlessBaby.OnFamiliarUpdate_Ultra, FamiliarVariant.HEADLESS_BABY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)