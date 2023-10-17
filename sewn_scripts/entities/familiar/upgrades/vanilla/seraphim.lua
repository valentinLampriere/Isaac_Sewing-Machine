local Random = require("sewn_scripts.helpers.random")

local Seraphim = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.SERAPHIM, CollectibleType.COLLECTIBLE_SERAPHIM)

Seraphim.Stats = {
    TearRateBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 5
    },
    HolyLightChance = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 10,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 15
    },
    KingBabyHolyLightChance = {
        [Sewn_API.Enums.FamiliarLevel.NORMAL] = 10,
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 15,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 20,
    }
}

function Seraphim:OnFireTear(familiar, tear)
    local fData = familiar:GetData()
    familiar.FireCooldown = familiar.FireCooldown - Seraphim.Stats.TearRateBonus[Sewn_API:GetLevel(fData)]

    if Random:CheckRoll(Seraphim.Stats.HolyLightChance[Sewn_API:GetLevel(fData)], familiar:GetDropRNG()) then
        tear.TearFlags = tear.TearFlags | TearFlags.TEAR_LIGHT_FROM_HEAVEN
    end
end

function Seraphim:OnUltraKingBabyFireTear(familiar, kingBaby, tear)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    local rng = kingBaby:GetDropRNG()

    if Random:CheckRoll(Seraphim.Stats.KingBabyHolyLightChance[level], rng) then
        tear.TearFlags = tear.TearFlags | TearFlags.TEAR_LIGHT_FROM_HEAVEN
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, Seraphim.OnFireTear, FamiliarVariant.SERAPHIM)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_ULTRA_KING_BABY_FIRE_TEAR, Seraphim.OnUltraKingBabyFireTear, FamiliarVariant.SERAPHIM)