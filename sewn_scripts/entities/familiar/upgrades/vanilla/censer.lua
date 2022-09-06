local Censer = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.CENSER, CollectibleType.COLLECTIBLE_CENSER)

Censer.Stats = {
    RadiusRange = 145
}

local function ApplyStrongerGravity(bullet)
    local bData = bullet:GetData()

    if bData.Sewn_censer_hasStrongerGravity == true then
        return
    end

    bullet.FallingAccel = bullet.FallingAccel + 0.5
    bData.Sewn_censer_hasStrongerGravity = true
end

function Censer:OnUpdate(familiar)
    local bullets = Isaac.FindInRadius(familiar.Position, Censer.Stats.RadiusRange, EntityPartition.BULLET)
    for _, bullet in ipairs(bullets) do
        bullet = bullet:ToProjectile()
        ApplyStrongerGravity(bullet)
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, Censer.OnUpdate, FamiliarVariant.CENSER)