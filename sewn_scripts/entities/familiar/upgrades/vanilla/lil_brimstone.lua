local LilBrimstone = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.LIL_BRIMSTONE, CollectibleType.COLLECTIBLE_LIL_BRIMSTONE)

LilBrimstone.Stats = {
    DamageBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1.33,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.5,
    },
    LaserTimeout = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 2,
    }
}

function LilBrimstone:OnFamiliarFireLaser(familiar, laser)
    local level = Sewn_API:GetLevel(familiar:GetData())
    laser.CollisionDamage = laser.CollisionDamage * LilBrimstone.Stats.DamageBonus[level]
    laser:SetTimeout(laser.Timeout * LilBrimstone.Stats.LaserTimeout[level])
end

function LilBrimstone:OnFamiliarFireLaser_Ultra(familiar, laser)
    laser:SetTimeout(laser.Timeout * LilBrimstone.Stats.LaserTimeout)
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_LASER, LilBrimstone.OnFamiliarFireLaser, FamiliarVariant.LIL_BRIMSTONE)