local BrotherBobby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.BROTHER_BOBBY, CollectibleType.COLLECTIBLE_BROTHER_BOBBY)

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
    },
    KingBabyFireRateBonus = {
        [Sewn_API.Enums.FamiliarLevel.NORMAL] = 3,
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 4,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 5,
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

function BrotherBobby:OnUltraKingBabyFireTear(familiar, kingBaby, tear)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    kingBaby.FireCooldown = kingBaby.FireCooldown - BrotherBobby.Stats.KingBabyFireRateBonus[level]
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, BrotherBobby.OnFireTear, FamiliarVariant.BROTHER_BOBBY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_ULTRA_KING_BABY_FIRE_TEAR, BrotherBobby.OnUltraKingBabyFireTear, FamiliarVariant.BROTHER_BOBBY)