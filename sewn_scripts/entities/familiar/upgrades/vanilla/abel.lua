local Debug = require("sewn_scripts.debug.debug")

local Abel = { }

Abel.Stats = {
    RangeBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 4.5,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 5
    },
    Range = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = -0.08,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = -0.08
    },
    DamageMultiplier = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.25
    },
    TearBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 3
    },
    ShotSpeedBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1.9,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.9
    },
    UniqueTearStat = {
        Range = -0.1,
        DamageMultiplier = 2,
        ScaleMultiplier = 1.15
    },
}

if REPENTANCE then
    Abel.Stats.TearFlagsBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = TearFlags.TEAR_BOOMERANG | TearFlags.TEAR_SPECTRAL,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = TearFlags.TEAR_BOOMERANG | TearFlags.TEAR_SPECTRAL | TearFlags.TEAR_PIERCING
    }
else
    Abel.Stats.TearFlagsBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = TearFlags.TEAR_BOMBERANG | TearFlags.TEAR_SPECTRAL,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = TearFlags.TEAR_BOMBERANG | TearFlags.TEAR_SPECTRAL | TearFlags.TEAR_PIERCING
    }
end

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.ABEL, CollectibleType.COLLECTIBLE_ABEL)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.ABEL,
    "While the player fires tears in the direction of the prism, it gets closer to the player#Tears which pass through it turn spectral",
    "Move even closer to the player#Tears which goes through it gain homing", nil, "Abel"
)

function Abel:OnFireTear(familiar, tear)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    tear.TearFlags = tear.TearFlags | Abel.Stats.TearFlagsBonus[level]
    tear.Velocity = tear.Velocity * Abel.Stats.ShotSpeedBonus[level]

    tear:ChangeVariant(TearVariant.CUPID_BLUE)

    if Sewn_API:IsUltra(fData) and (fData.Sewn_abel_uniqueTear == nil or fData.Sewn_abel_uniqueTear:Exists() == false) then
        tear.FallingAcceleration = Abel.Stats.UniqueTearStat.Range
        tear.CollisionDamage = tear.CollisionDamage * Abel.Stats.UniqueTearStat.DamageMultiplier
        tear.Scale = tear.Scale * Abel.Stats.UniqueTearStat.DamageMultiplier

        tear:ChangeVariant(TearVariant.CUPID_BLOOD)

        fData.Sewn_abel_uniqueTear = tear
    else
        tear.FallingAcceleration = Abel.Stats.Range[level]
        tear.CollisionDamage = tear.CollisionDamage * Abel.Stats.DamageMultiplier[level]
    end

    familiar.FireCooldown = familiar.FireCooldown - Abel.Stats.TearBonus[level]
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, Abel.OnFireTear, FamiliarVariant.ABEL)