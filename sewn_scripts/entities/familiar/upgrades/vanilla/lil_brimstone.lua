local LilBrimstone = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.LIL_BRIMSTONE, CollectibleType.COLLECTIBLE_LIL_BRIMSTONE)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.LIL_BRIMSTONE,
    "{{ArrowUp}} Damage Up",
    "{{ArrowUp}} Slight Damage Up#Laser lasts longer#Charges quicker", nil, "Lil Brimstone"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.LIL_BRIMSTONE,
    "{{ArrowUp}} 攻击提升",
    "{{ArrowUp}} 攻击大幅提升 #硫磺火持续更长时间 #蓄力更快", nil, "硫磺火宝宝","zh_cn"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.LIL_BRIMSTONE,
    "Damage Up (x1.5)",
    "Laser lasts longer (x1.3)#Slight Damage Up (x1.6)#Charges quicker"
)
LilBrimstone.Stats = {
    DamageBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1.5,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.6,
    },
    LaserTimeout = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.3,
    }
}

function LilBrimstone:OnFamiliarFireLaser(familiar, laser)
    local level = Sewn_API:GetLevel(familiar:GetData())
    laser.CollisionDamage = laser.CollisionDamage * LilBrimstone.Stats.DamageBonus[level]
    laser:SetTimeout(math.floor(laser.Timeout * LilBrimstone.Stats.LaserTimeout[level]))
end

function LilBrimstone:Charging(familiar, sprite)
    if familiar.FrameCount % 4 == 0 then
        familiar.FireCooldown = familiar.FireCooldown - 1
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_LASER, LilBrimstone.OnFamiliarFireLaser, FamiliarVariant.LIL_BRIMSTONE)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_PLAY_ANIM, LilBrimstone.Charging, FamiliarVariant.LIL_BRIMSTONE, nil, "FloatChargeUp", "FloatChargeDown", "FloatChargeSide", "ChargeUp", "ChargeDown", "ChargeSide")