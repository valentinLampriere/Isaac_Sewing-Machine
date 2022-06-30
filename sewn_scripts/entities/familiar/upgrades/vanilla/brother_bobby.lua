local BrotherBobby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.BROTHER_BOBBY, CollectibleType.COLLECTIBLE_BROTHER_BOBBY)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BROTHER_BOBBY,
    "{{ArrowUp}} Tears Up",
    "{{ArrowUp}} Tears Up#{{ArrowUp}} Damage Up", nil, "Brother Bobby"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BROTHER_BOBBY,
    "{{ArrowUp}} 射速提升",
    "{{ArrowUp}} 射速提升#{{ArrowUp}} 攻击提升", nil, "波比兄弟","zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BROTHER_BOBBY,
    "{{ArrowUp}} Скорострельность +",
    "{{ArrowUp}} Скорострельность +#{{ArrowUp}} Урон +", nil, "Брат Бобби", "ru"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BROTHER_BOBBY,
    "{{ArrowUp}} Débit",
    "{{ArrowUp}} Débit#{{ArrowUp}} Dégâts", nil, "Frère Bobby", "fr"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BROTHER_BOBBY,
    "{{ArrowUp}} + Lágrimas",
    "{{ArrowUp}} + Lágrimas#{{ArrowUp}} + Daño", nil, "Hermano Bobby", "spa"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.BROTHER_BOBBY,
    "Tears Up (x1.33)",
    "Tears Up (x1.47)#Damage Up (x1.33)"
)

BrotherBobby.Stats = {
    TearRateBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 5,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 7
    },
    TearRateBonus_AB = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 10,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 18
    },
    DamageBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.33
    },
    TearScale = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.07
    }
}
function BrotherBobby:OnFireTear(familiar, tear)
    local fData = familiar:GetData()
    if REPENTANCE then
        familiar.FireCooldown = familiar.FireCooldown - BrotherBobby.Stats.TearRateBonus[Sewn_API:GetLevel(fData)]
    else
        familiar.FireCooldown = familiar.FireCooldown - BrotherBobby.Stats.TearRateBonus_AB[Sewn_API:GetLevel(fData)]
    end
    tear.CollisionDamage = tear.CollisionDamage * BrotherBobby.Stats.DamageBonus[Sewn_API:GetLevel(fData)]
    tear.Scale = tear.Scale * BrotherBobby.Stats.TearScale[Sewn_API:GetLevel(fData)]
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, BrotherBobby.OnFireTear, FamiliarVariant.BROTHER_BOBBY)