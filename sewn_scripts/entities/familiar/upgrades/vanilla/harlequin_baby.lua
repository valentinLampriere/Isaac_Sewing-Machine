local HarlequinBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.HARLEQUIN_BABY, CollectibleType.COLLECTIBLE_HARLEQUIN_BABY)

HarlequinBaby.Stats = {
    DamageBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.5
    },
    TearScale = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.25
    },
    KingBabyAdditionalTearDamage = 2.5
}

function HarlequinBaby:OnFamiliarUpgraded(familiar)
    local fData = familiar:GetData()
    fData.Sewn_harlequinBaby_isFirstTear = true
end
function HarlequinBaby:OnFamiliarFireTear(familiar, tear)
    local fData = familiar:GetData()
    local tData = tear:GetData()

    if tData.Sewn_isAdditionalHarlequinBaby == true then
        return
    end

    tear.CollisionDamage = tear.CollisionDamage * HarlequinBaby.Stats.DamageBonus[Sewn_API:GetLevel(fData)]
    tear.Scale = tear.Scale * HarlequinBaby.Stats.TearScale[Sewn_API:GetLevel(fData)]

    local velocity
    if fData.Sewn_harlequinBaby_isFirstTear then
        velocity = tear.Velocity:Rotated(10)
    else
        velocity = tear.Velocity:Rotated(-10)
    end
    local newTear = Isaac.Spawn(EntityType.ENTITY_TEAR, tear.Variant, tear.SubType, familiar.Position, velocity, familiar):ToTear()
    --sewnFamiliars:toBabyBenderTear(familiar, newTear)
    newTear.Scale = tear.Scale
    newTear.CollisionDamage = tear.CollisionDamage
    newTear:GetData().Sewn_isAdditionalHarlequinBaby = true
    fData.Sewn_harlequinBaby_isFirstTear = not fData.Sewn_harlequinBaby_isFirstTear
end

local function FireUltraBabyAdditionnalTear(tear, isLeftTear, spawner)
    local velocity = tear.Velocity:Rotated(isLeftTear == true and 10 or -10)
    local newTear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLOOD, 0, tear.Position, velocity, spawner):ToTear()
    newTear.Scale = 0.72
    tear.CollisionDamage = HarlequinBaby.Stats.KingBabyAdditionalTearDamage
    return newTear
end

function HarlequinBaby:OnUltraKingBabyShootTear(familiar, kingBaby, tear, npc)
    FireUltraBabyAdditionnalTear(tear, true, kingBaby)
    FireUltraBabyAdditionnalTear(tear, false, kingBaby)
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, HarlequinBaby.OnFamiliarUpgraded, FamiliarVariant.HARLEQUIN_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, HarlequinBaby.OnFamiliarFireTear, FamiliarVariant.HARLEQUIN_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_ULTRA_KING_BABY_SHOOT_TEAR, HarlequinBaby.OnUltraKingBabyShootTear, FamiliarVariant.HARLEQUIN_BABY)