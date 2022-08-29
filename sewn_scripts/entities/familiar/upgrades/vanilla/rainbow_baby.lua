local CColor = require("sewn_scripts.helpers.ccolor")

local RainbowBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.RAINBOW_BABY, CollectibleType.COLLECTIBLE_RAINBOW_BABY)


RainbowBaby.Stats = {
    TearDamageMultiplier = 1.3,
    FireRateBonus = 7,
    UltraTearFlags = TearFlags.TEAR_HOMING | TearFlags.TEAR_SPECTRAL | TearFlags.TEAR_CHARM | TearFlags.TEAR_SLOW,
}

-- Sewn_API:AddFamiliarDescription(
--     FamiliarVariant.RAINBOW_BABY,
--     "{{ArrowUp}} Damage Up#{{ArrowUp}} Tears Up",
--     "Tears combine effects", nil, "Rainbow Baby"
-- )
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.RAINBOW_BABY,
    "{{ArrowUp}} 攻击提升#{{ArrowUp}} 射速提升",
    "原本随机的眼泪效果全部都会触发", nil, "彩虹宝宝","zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.RAINBOW_BABY,
    "{{ArrowUp}} Урон +#{{ArrowUp}} Скорострельность +",
    "Слёзы могут иметь больше одного эффекта", nil, "Радужный Малыш", "ru"
)
-- Sewn_API:AddFamiliarDescription(
--     FamiliarVariant.RAINBOW_BABY,
--     "{{ArrowUp}} Dégât#{{ArrowUp}} Débit",
--     "Les larmes combinent plusieurs effets", nil, "Bébé Arc-en-Ciel", "fr"
-- )
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.RAINBOW_BABY,
    "{{ArrowUp}} + Daño#{{ArrowUp}} + Lágrimas",
    "Las lágrimas combinan efectos", nil, "Bebé Arcoíris", "spa"
)

function RainbowBaby:TearInit(familiar, tear)
    tear.CollisionDamage = tear.CollisionDamage * RainbowBaby.Stats.TearDamageMultiplier
    familiar.FireCooldown = familiar.FireCooldown - RainbowBaby.Stats.FireRateBonus
end
function RainbowBaby:TearInit_Ultra(familiar, tear)
    tear.TearFlags = tear.TearFlags | RainbowBaby.Stats.UltraTearFlags
end
function RainbowBaby:TearUpdate_Ultra(familiar, tear)
    local color = tear:GetColor()
    local r = color.R - 0.1 > 0 and color.R - math.random() * 0.1 or 1
    local g = color.G - 0.1 > 0 and color.G - math.random() * 0.1 or 1
    local b = color.B - 0.1 > 0 and color.B - math.random() * 0.1 or 1
    tear:SetColor(CColor(r, g, b, color.A, color.RO, color.GO, color.BO), -1, 2, false, false)
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, RainbowBaby.TearInit_Ultra, FamiliarVariant.RAINBOW_BABY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_TEAR_UPDATE, RainbowBaby.TearUpdate_Ultra, FamiliarVariant.RAINBOW_BABY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, RainbowBaby.TearInit, FamiliarVariant.RAINBOW_BABY)