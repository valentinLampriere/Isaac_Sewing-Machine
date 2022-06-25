local Enums = require("sewn_scripts.core.enums")

local BloodshootEye = { }

BloodshootEye.Stats = {
    TearRotationOffset = 25,
    LaserTimeout = 1,
    LaserRadiusMultiplier = 0.01
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.BLOODSHOT_EYE, CollectibleType.COLLECTIBLE_BLOODSHOT_EYE)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BLOODSHOT_EYE,
    "Fires three tears at once",
    "Fires a blood laser instead of tears", nil, "Bloodshot Eye"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BLOODSHOT_EYE,
    "一次发射三颗眼泪",
    "攻击方式更改为发射小硫磺火", nil, "血丝眼", "zh_cn"
)

function BloodshootEye:OnFamiliarFireTear_Super(familiar, tear)
    local tData = tear:GetData()

    if tData.Sewn_bloodshotEye_additionalTear ~= true then
        for i = -1, 1, 2 do
            local velocity = tear.Velocity:Rotated(BloodshootEye.Stats.TearRotationOffset * i)
            local newTear = Isaac.Spawn(tear.Type, tear.Variant, tear.SubType, tear.Position, velocity, familiar):ToTear()
            newTear.CollisionDamage = tear.CollisionDamage
            newTear.FallingSpeed = tear.FallingSpeed
            newTear.Height = tear.Height
            newTear.Scale = tear.Scale
            newTear.TearFlags = tear.TearFlags
            --sewnFamiliars:toBabyBenderTear(bloodshotEye, addTear)
            newTear:GetData().Sewn_bloodshotEye_additionalTear = true
        end
    end
end
function BloodshootEye:OnFamiliarFireTear_Ultra(familiar, tear)
    local laser = EntityLaser.ShootAngle(Enums.LaserVariant.LASER_BRIMSTONE, familiar.Position, tear.Velocity:GetAngleDegrees(), BloodshootEye.Stats.LaserTimeout, Vector(0,-20), familiar):ToLaser()
    tear:Remove()
    laser.CollisionDamage = tear.CollisionDamage
    laser.Radius = laser.Radius * BloodshootEye.Stats.LaserRadiusMultiplier
end
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, BloodshootEye.OnFamiliarFireTear_Super, FamiliarVariant.BLOODSHOT_EYE, Sewn_API.Enums.FamiliarLevelFlag.FLAG_SUPER)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, BloodshootEye.OnFamiliarFireTear_Ultra, FamiliarVariant.BLOODSHOT_EYE, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)