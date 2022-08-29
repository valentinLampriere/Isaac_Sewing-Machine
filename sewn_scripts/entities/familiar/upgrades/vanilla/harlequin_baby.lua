local HarlequinBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.HARLEQUIN_BABY, CollectibleType.COLLECTIBLE_HARLEQUIN_BABY)

-- Sewn_API:AddFamiliarDescription(
--     FamiliarVariant.HARLEQUIN_BABY,
--     "Fire an additional shot on each side",
--     "{{ArrowUp}} Damage Up", nil, "Harlequin Baby"
-- )
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.HARLEQUIN_BABY,
    "向两边额外发射一颗眼泪",
    "{{ArrowUp}} 攻击提升", nil, "小丑宝宝","zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.HARLEQUIN_BABY,
    "Стреляет дополнительной слезой с каждой стороны",
    "{{ArrowUp}} Урон +", nil, "Малыш Арлекин", "ru"
)
-- Sewn_API:AddFamiliarDescription(
--     FamiliarVariant.HARLEQUIN_BABY,
--     "Tire deux larmes supplémentaires",
--     "{{ArrowUp}} Dégâts", nil, "Bébé Arlequin", "fr"
-- )
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.HARLEQUIN_BABY,
    "Dispara una lágrima extra a cada lado",
    "{{ArrowUp}} + Daño", nil, "Bebé Arlequín", "spa"
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
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, HarlequinBaby.OnFamiliarUpgraded, FamiliarVariant.HARLEQUIN_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, HarlequinBaby.OnFamiliarFireTear, FamiliarVariant.HARLEQUIN_BABY)