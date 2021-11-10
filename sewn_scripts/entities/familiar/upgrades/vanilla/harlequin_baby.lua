local HarlequinBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.HARLEQUIN_BABY, CollectibleType.COLLECTIBLE_HARLEQUIN_BABY)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.HARLEQUIN_BABY,
    "Fire an additional shot on each sides",
    "{{ArrowUp}} Damage Up"
)

HarlequinBaby.Stats = {
    DamageBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.5
    },
    TearScale = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.25
    }
}

local isFirstTear = true
function HarlequinBaby:OnFamiliarFireTear(familiar, tear)
    local fData = familiar:GetData()

    tear.CollisionDamage = tear.CollisionDamage * HarlequinBaby.Stats.DamageBonus[Sewn_API:GetLevel(fData)]
    tear.Scale = tear.Scale * HarlequinBaby.Stats.TearScale[Sewn_API:GetLevel(fData)]

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