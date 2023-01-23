local LilBrimstone = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.LIL_BRIMSTONE, CollectibleType.COLLECTIBLE_LIL_BRIMSTONE)

LilBrimstone.Stats = {
    DamageBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1.5,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.6,
    },
    LaserTimeout = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.3,
    },
    KingBabyTearDamageBonus = 1
}

function LilBrimstone:OnFamiliarFireLaser(familiar, laser)
    local level = Sewn_API:GetLevel(familiar:GetData())
    laser.CollisionDamage = laser.CollisionDamage * LilBrimstone.Stats.DamageBonus[level]
    laser:SetTimeout(math.floor(laser.Timeout * LilBrimstone.Stats.LaserTimeout[level]))
    Sewn_Debug:RenderColor(laser:GetColor())
end

function LilBrimstone:Charging(familiar, sprite)
    if familiar.FrameCount % 4 == 0 then
        familiar.FireCooldown = familiar.FireCooldown - 1
    end
end

function LilBrimstone:OnUltraKingBabyFireTear(familiar, kingBaby, tear)
    tear.CollisionDamage = tear.CollisionDamage + LilBrimstone.Stats.KingBabyTearDamageBonus
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_LASER, LilBrimstone.OnFamiliarFireLaser, FamiliarVariant.LIL_BRIMSTONE)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_PLAY_ANIM, LilBrimstone.Charging, FamiliarVariant.LIL_BRIMSTONE, nil, "FloatChargeUp", "FloatChargeDown", "FloatChargeSide", "ChargeUp", "ChargeDown", "ChargeSide")
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_ULTRA_KING_BABY_FIRE_TEAR, LilBrimstone.OnUltraKingBabyFireTear, FamiliarVariant.LIL_BRIMSTONE)