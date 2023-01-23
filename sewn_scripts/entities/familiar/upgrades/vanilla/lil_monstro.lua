local Random = require("sewn_scripts.helpers.random")

local LilMonstro = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.LIL_MONSTRO, CollectibleType.COLLECTIBLE_LIL_MONSTRO)

LilMonstro.Stats = {
    ToothChance = 15,
    AdditionalTearChance = 25,
    KingBabyAdditionalTearsCountMax = 5,
    KingBabyAdditionalTearsCountMin = 2,
    KingBabyAdditionalTearDamage = 2
}

function LilMonstro:OnFamiliarFireTear_Ultra(familiar, tear)
    if Random:CheckRoll(LilMonstro.Stats.AdditionalTearChance, familiar:GetDropRNG()) then
        local velocity = Vector(math.random() - 0.5, math.random() - 0.5) + tear.Velocity
        
        local newTear = Isaac.Spawn(EntityType.ENTITY_TEAR, tear.Variant, tear.SubType, familiar.Position, velocity, familiar):ToTear()
        
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

local function FireUltraBabyAdditionnalTear(tear, spawner)
    --local velocity = tear.Velocity:Rotated(isLeftTear == true and 10 or -10)
    local velocity = Vector(math.random() - 0.5, math.random() - 0.5) + tear.Velocity * 0.8
    local newTear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLOOD, 0, tear.Position, velocity, spawner):ToTear()
    local rng = spawner:GetDropRNG()
    newTear.Scale = rng:RandomFloat() * (0.9 - 0.70) + 0.70
    newTear.FallingAcceleration = 0.5
    newTear.FallingSpeed = -rng:RandomFloat() * (15 - 3) + 3
    newTear.CollisionDamage = LilMonstro.Stats.KingBabyAdditionalTearDamage
    return newTear
end

function LilMonstro:OnUltraKingBabyShootTear(familiar, kingBaby, tear, npc)
    local rng = kingBaby:GetDropRNG()
    local count = rng:RandomInt(LilMonstro.Stats.KingBabyAdditionalTearsCountMax + 1) + LilMonstro.Stats.KingBabyAdditionalTearsCountMin
    for i = 1, count do
        FireUltraBabyAdditionnalTear(tear, kingBaby)
    end
end


Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, LilMonstro.OnFamiliarFireTear_Ultra, FamiliarVariant.LIL_MONSTRO, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, LilMonstro.OnFamiliarFireTear, FamiliarVariant.LIL_MONSTRO)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_ULTRA_KING_BABY_SHOOT_TEAR, LilMonstro.OnUltraKingBabyShootTear, FamiliarVariant.LIL_MONSTRO)