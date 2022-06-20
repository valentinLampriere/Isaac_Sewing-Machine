local Random = require("sewn_scripts.helpers.random")

local LilMonstro = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.LIL_MONSTRO, CollectibleType.COLLECTIBLE_LIL_MONSTRO)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.LIL_MONSTRO,
    "Has a chance to fire a tooth#Teeth deal x3.2 normal damage",
    "Fires way more tears", nil, "Lil Monstro"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.LIL_MONSTRO,
    "每颗发射的眼泪有 15% 概率替换成牙齿 #牙齿造成 x3.2 伤害",
    "发射更多眼泪 #对于每颗眼泪来说有 25% 概率额外发生一颗眼泪", nil, "Lil Monstro","zh_cn"
)

LilMonstro.Stats = {
    ToothChance = 15,
    AdditionalTearChance = 25,
}

function LilMonstro:OnFamiliarFireTear_Ultra(familiar, tear)
    if Random:CheckRoll(LilMonstro.Stats.AdditionalTearChance, familiar:GetDropRNG()) then
        local velocity = Vector(math.random() - 0.5, math.random() - 0.5) + tear.Velocity
        
        local newTear = Isaac.Spawn(EntityType.ENTITY_TEAR, tear.Variant, tear.SubType, familiar.Position, velocity, familiar):ToTear()
        --sewnFamiliars:toBabyBenderTear(familiar, newTear)
        
        newTear.FallingSpeed = tear.FallingSpeed
        newTear.FallingAcceleration = tear.FallingAcceleration
        newTear.CollisionDamage = tear.CollisionDamage
        newTear.Parent = tear.Parent
    end
end
function LilMonstro:OnFamiliarFireTear(familiar, tear)
    if Random:CheckRoll(LilMonstro.Stats.ToothChance, familiar:GetDropRNG()) then
        if tear.Variant ~= TearVariant.TOOTH then
            tear:ChangeVariant(TearVariant.TOOTH)
        end
        tear.CollisionDamage = tear.CollisionDamage * 3.2
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, LilMonstro.OnFamiliarFireTear_Ultra, FamiliarVariant.LIL_MONSTRO, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, LilMonstro.OnFamiliarFireTear, FamiliarVariant.LIL_MONSTRO)
