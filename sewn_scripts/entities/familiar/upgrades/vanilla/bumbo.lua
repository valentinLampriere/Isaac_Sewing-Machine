local Bumbo = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.BUMBO, CollectibleType.COLLECTIBLE_BUMBO)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BUMBO,
    "Gains a random additional tear effect#Additional tear effect can't be Ipecac unless Ipecac is the base attack of the buddy",
    "Gains another random additional tear effect", nil, "Bumbo"
)

Bumbo.TilesType = {
    HEART = 0
}

Bumbo.Tiles = {

}

function Bumbo:OnFamiliarUpgraded(familiar, isPermanentUpgrade)
    local fData = familiar:GetData()
end

function Bumbo:OnFamiliarRender(familiar, offset)
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, Bumbo.OnFamiliarUpgraded, FamiliarVariant.BUMBO)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_RENDER, Bumbo.OnFamiliarRender, FamiliarVariant.BUMBO)