local Random = require("sewn_scripts.helpers.random")

local LilMonstro = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.LIL_MONSTRO, CollectibleType.COLLECTIBLE_LIL_MONSTRO)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.LIL_MONSTRO,
    "Have a chance to fire a tooth#Tooth deal 3.2 normal damage",
    "Fire way more tears"
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
