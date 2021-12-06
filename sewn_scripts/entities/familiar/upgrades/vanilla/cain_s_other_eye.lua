local Delay = require("sewn_scripts.helpers.delay")
local Globals = require("sewn_scripts.core.globals")
local Enums = require("sewn_scripts.core.enums")

local CainsOtherEye = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.CAINS_OTHER_EYE, CollectibleType.COLLECTIBLE_CAINS_OTHER_EYE)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.CAINS_OTHER_EYE,
    "Fire 2 tears instead of one#Tears gain a Rubber Cement effect {{Collectible".. CollectibleType.COLLECTIBLE_RUBBER_CEMENT .."}} ",
    "Fire 4 tears#Range up", nil, "Cain's other Eye"
)

CainsOtherEye.Stats = {
    AdditionalTears = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 3
    },
    DelayBetweenTears = 2
}

local function FireTear(familiar, tear)
    local newTear = Isaac.Spawn(EntityType.ENTITY_TEAR, tear.Variant, tear.SubType, familiar.Position, tear.Velocity, familiar):ToTear()
    local tData = newTear:GetData()
    newTear.CollisionDamage = tear.CollisionDamage
    newTear.TearFlags = tear.TearFlags
    newTear.Scale = tear.Scale
    newTear.TearFlags = tear.TearFlags | TearFlags.TEAR_BOUNCE
    newTear.FallingAcceleration = -0.05
    
    tData.Sewn_cainsOtherEyeTear = true
end

function CainsOtherEye:FamiliarFireTear(familiar, tear)
    local tData = tear:GetData()
    if tData.Sewn_cainsOtherEyeTear == true then return end
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    
    tear.TearFlags = tear.TearFlags | TearFlags.TEAR_BOUNCE
    
    for i = 1, CainsOtherEye.Stats.AdditionalTears[level] do
        Delay:DelayFunction(FireTear, i * CainsOtherEye.Stats.DelayBetweenTears, true, familiar, tear)
    end
end

function CainsOtherEye:FamiliarFireTear_Ultra(familiar, tear)
    tear.FallingAcceleration = -0.05
end


Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, CainsOtherEye.FamiliarFireTear_Ultra, FamiliarVariant.CAINS_OTHER_EYE, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, CainsOtherEye.FamiliarFireTear, FamiliarVariant.CAINS_OTHER_EYE)