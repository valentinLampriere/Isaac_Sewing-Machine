local GhostBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.GHOST_BABY, CollectibleType.COLLECTIBLE_GHOST_BABY)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.GHOST_BABY,
    "{{ArrowUp}} Damage Up#Gain piercing Pupula Duplex {{Collectible"..CollectibleType.COLLECTIBLE_PUPULA_DUPLEX.."}} tears",
    "{{ArrowUp}} Tear Size Up#{{ArrowUp}} Damage Up", nil, "Ghost Baby"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.GHOST_BABY,
    "眼泪可穿透敌人#{{ArrowUp}} 攻击提升",
    "眼泪大小更大 #{{ArrowUp}} 攻击提升", nil, "幽灵宝宝","zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.GHOST_BABY,
    "{{ArrowUp}} Урон +#Получает пронизывающие слёзы Двойного Зрачка {{Collectible"..CollectibleType.COLLECTIBLE_PUPULA_DUPLEX.."}}",
    "{{ArrowUp}} Урон +#{{ArrowUp}} Размер слёз +", nil, "Малыш Призрак", "ru"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.GHOST_BABY,
    "{{ArrowUp}} Dégâts#Ses larmes deviennent transperçantes et prennent l'apparence de \"Polycorie\" {{Collectible"..CollectibleType.COLLECTIBLE_PUPULA_DUPLEX.."}}",
    "{{ArrowUp}} Taille des larmes#{{ArrowUp}} Dégats", nil, "Bébé Fantôme", "fr"
)

GhostBaby.Stats = {
    TearScale = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 2,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 3
    },
    TearDamage = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1.5,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 2.25
    }
}

function GhostBaby:OnFamiliarFireTear(familiar, tear)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    tear.TearFlags = tear.TearFlags | TearFlags.TEAR_PIERCING
    tear:ChangeVariant(TearVariant.PUPULA)

    tear.Scale = tear.Scale * GhostBaby.Stats.TearScale[level]
    tear.CollisionDamage = tear.CollisionDamage * GhostBaby.Stats.TearDamage[level]
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, GhostBaby.OnFamiliarFireTear, FamiliarVariant.GHOST_BABY)