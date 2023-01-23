local GhostBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.GHOST_BABY, CollectibleType.COLLECTIBLE_GHOST_BABY)

GhostBaby.Stats = {
    TearScale = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 2,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 3
    },
    TearDamage = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1.5,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 2.25
    }
}

function GhostBaby:OnFamiliarFireTear(familiar, tear)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    tear.TearFlags = tear.TearFlags | TearFlags.TEAR_PIERCING
    tear:ChangeVariant(TearVariant.PUPULA)

    tear.Scale = tear.Scale * GhostBaby.Stats.TearScale[level]
    tear.CollisionDamage = tear.CollisionDamage * GhostBaby.Stats.TearDamage[level]
end

function GhostBaby:OnUltraKingBabyFireTear(familiar, kingBaby, tear)
    tear.TearFlags = tear.TearFlags | TearFlags.TEAR_PIERCING
    if tear.Variant ~= TearVariant.CUPID_BLUE then
        tear:ChangeVariant(TearVariant.CUPID_BLUE)
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, GhostBaby.OnFamiliarFireTear, FamiliarVariant.GHOST_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_ULTRA_KING_BABY_FIRE_TEAR, GhostBaby.OnUltraKingBabyFireTear, FamiliarVariant.GHOST_BABY)