local SisterMaggy = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.SISTER_MAGGY, CollectibleType.COLLECTIBLE_SISTER_MAGGY)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.SISTER_MAGGY,
    "{{ArrowUp}} Damage Up",
    "{{ArrowUp}} Damage Up#{{ArrowUp}} Tears Up"
)

function SisterMaggy:OnFamiliarFireTear_Super(familiar, tear)
    if REPENTANCE then
        tear.CollisionDamage = tear.CollisionDamage * 1.33
        tear.Scale = tear.Scale * 1.08
    else
        tear.CollisionDamage = tear.CollisionDamage * 1.75
        tear.Scale = tear.Scale * 1.11
    end
end
function SisterMaggy:OnFamiliarFireTear_Ultra(familiar, tear)
    if REPENTANCE then
        familiar.FireCooldown = familiar.FireCooldown - 6
        tear.CollisionDamage = tear.CollisionDamage * 1.66
        tear.Scale = tear.Scale * 1.105
    else
        familiar.FireCooldown = familiar.FireCooldown - 9
        tear.CollisionDamage = tear.CollisionDamage * 2
        tear.Scale = tear.Scale * 1.2
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, SisterMaggy.OnFamiliarFireTear_Super, FamiliarVariant.SISTER_MAGGY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_SUPER)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, SisterMaggy.OnFamiliarFireTear_Ultra, FamiliarVariant.SISTER_MAGGY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)