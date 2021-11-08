local Random = require("sewn_scripts.helpers.random")

local Seraphim = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.SERAPHIM, CollectibleType.COLLECTIBLE_SERAPHIM)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.SERAPHIM,
    "Have a chance to fire Holy Tears",
    "Higher chance to fire Holy Tears#{{ArrowUp}} Tears Up"
)

Seraphim.Stats = {
    TearRateBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 5
    },
    HolyLightChance = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 10,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 15
    }
}

function Seraphim:OnFireTear(familiar, tear)
    local fData = familiar:GetData()
    familiar.FireCooldown = familiar.FireCooldown - Seraphim.Stats.TearRateBonus[Sewn_API:GetLevel(fData)]

    if Random:CheckRoll(Seraphim.Stats.HolyLightChance[Sewn_API:GetLevel(fData)], familiar:GetDropRNG()) then
        tear.TearFlags = tear.TearFlags | TearFlags.TEAR_LIGHT_FROM_HEAVEN
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, Seraphim.OnFireTear, FamiliarVariant.SERAPHIM)