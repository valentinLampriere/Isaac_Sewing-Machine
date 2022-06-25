local Random = require("sewn_scripts.helpers.random")

local Seraphim = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.SERAPHIM, CollectibleType.COLLECTIBLE_SERAPHIM)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.SERAPHIM,
    "Has a chance to fire Holy Tears",
    "Higher chance to fire Holy Tears#{{ArrowUp}} Tears Up", nil, "Seraphim"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.SERAPHIM,
    "概率发射圣光眼泪",
    "更高概率发射圣光眼泪 #{{ArrowUp}} 射速提升", nil, "撒拉弗","zh_cn"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.SERAPHIM,
    "Have 10% chance to fire a Holy Tear#Holy Tear spawn a light beam on contact",
    "Have 15% chance to fire a Holy Tear#Tears Up (x1.24)"
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