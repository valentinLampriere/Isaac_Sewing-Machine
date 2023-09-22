local CColor = require("sewn_scripts.helpers.ccolor")

local SisterMaggy = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.SISTER_MAGGY, CollectibleType.COLLECTIBLE_SISTER_MAGGY)

SisterMaggy.Stats = {
    DamageBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1.33,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.66
    },
    DamageBonus_AB = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1.75,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 2
    },
    TearRateBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 6
    },
    TearRateBonus_AB = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 9
    },
    TearScale = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1.08,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.105
    },
    TearScale_AB = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1.11,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.2
    },
    KingBabyTearDamageBonus = {
        [Sewn_API.Enums.FamiliarLevel.NORMAL] = 1,
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1.2,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.3,
    }
}

function SisterMaggy:OnFamiliarFireTear(familiar, tear)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    if REPENTANCE then
        familiar.FireCooldown = familiar.FireCooldown - SisterMaggy.Stats.TearRateBonus[level]
        tear.CollisionDamage = tear.CollisionDamage * SisterMaggy.Stats.DamageBonus[level]
        tear.Scale = tear.Scale * SisterMaggy.Stats.TearScale[level]
    else
        familiar.FireCooldown = familiar.FireCooldown - SisterMaggy.Stats.TearRateBonus_AB[level]
        tear.CollisionDamage = tear.CollisionDamage * SisterMaggy.Stats.DamageBonus_AB[level]
        tear.Scale = tear.Scale * SisterMaggy.Stats.TearScale_AB[level]
    end
end

function SisterMaggy:OnUltraKingBabyFireTear(familiar, kingBaby, tear)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    local color = CColor(0.9, 0, 0)

    tear:SetColor(color, -1, 1, false, false)

    tear.CollisionDamage = tear.CollisionDamage + SisterMaggy.Stats.KingBabyTearDamageBonus[level]
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, SisterMaggy.OnFamiliarFireTear, FamiliarVariant.SISTER_MAGGY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_ULTRA_KING_BABY_FIRE_TEAR, SisterMaggy.OnUltraKingBabyFireTear, FamiliarVariant.SISTER_MAGGY)