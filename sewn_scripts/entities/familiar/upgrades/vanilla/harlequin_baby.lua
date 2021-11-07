local HarlequinBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.HARLEQUIN_BABY, CollectibleType.COLLECTIBLE_HARLEQUIN_BABY)

local isFirstTear = true
function HarlequinBaby:OnFamiliarFireTear(familiar, tear)
    local velocity
    if isFirstTear then
        velocity = tear.Velocity:Rotated(10)
    else
        velocity = tear.Velocity:Rotated(-10)
    end
    local newTear = Isaac.Spawn(EntityType.ENTITY_TEAR, tear.Variant, tear.SubType, familiar.Position, velocity, familiar):ToTear()
    --sewnFamiliars:toBabyBenderTear(familiar, newTear)
    newTear.Scale = tear.Scale
    newTear.CollisionDamage = tear.CollisionDamage
    isFirstTear = not isFirstTear
end
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, HarlequinBaby.OnFamiliarFireTear, FamiliarVariant.HARLEQUIN_BABY)