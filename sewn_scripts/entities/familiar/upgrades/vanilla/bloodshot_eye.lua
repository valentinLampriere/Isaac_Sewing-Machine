local BloodshotEye = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.BLOODSHOT_EYE, CollectibleType.COLLECTIBLE_BLOODSHOT_EYE)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BLOODSHOT_EYE,
    "Hitting an enemy has a chance to fire a ring of tears#Killing an enemy has a chance to fire a ring of stronger tears#{{ArrowUp}} Range Up#{{ArrowDown}} Shot Speed Down#{{ArrowUp}} Damage Up",
    "Increase chances to fire a ring of tears when hitting/killing enemies#Tears from the ring can trigger another ring of tear causing a chain reaction#{{ArrowUp}} Damage Up"
)

BloodshotEye.Stats = {
    FireBulletHitChance = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 5,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 10
    },
    FireBulletKillChance = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 50,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 75
    }
}
