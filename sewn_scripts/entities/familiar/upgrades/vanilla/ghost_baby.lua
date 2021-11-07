local GhostBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.GHOST_BABY, CollectibleType.COLLECTIBLE_GHOST_BABY)

function GhostBaby:OnFamiliarFireTear(familiar, tear)
    local fData = familiar:GetData()
    tear.TearFlags = tear.TearFlags | TearFlags.TEAR_PIERCING
    tear:ChangeVariant(TearVariant.PUPULA)

    if Sewn_API:IsSuper(fData, false) then
        tear.Scale = tear.Scale * 2
        tear.CollisionDamage = tear.CollisionDamage * 1.5
    else
        tear.Scale = tear.Scale * 3
        tear.CollisionDamage = tear.CollisionDamage * 2
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, GhostBaby.OnFamiliarFireTear, FamiliarVariant.GHOST_BABY)