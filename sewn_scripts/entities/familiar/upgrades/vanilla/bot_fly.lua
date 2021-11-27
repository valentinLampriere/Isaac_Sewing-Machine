local Delay = require("sewn_scripts.helpers.delay")
local Enums = require("sewn_scripts.core.enums")
local FindCloserNpc = require("sewn_scripts.helpers.find_closer_npc")

local BotFly = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.BOT_FLY, CollectibleType.COLLECTIBLE_BOT_FLY)


BotFly.Stats = {
    ShotSpeedMultiplier = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1.2,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.3
    },
    SizeMultiplier = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1.2,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.35
    },
    RangeMultiplier = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 2,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 3
    },
    AdditionalTearFlags = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = TearFlags.TEAR_PIERCING
    },
    MaxLaserLength = 200,
    TearCooldownMax = 300,
    TearCooldownMin = 120,
    TearCooldownTimeAfterNormalTear = 50,
    TearVelocity = 14
}

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BOT_FLY,
    "When it fire a tear, a laser connect the tear to the familiar#The laser deal contact damage and block shots#{{ArrowUp}} Stats up (Range, Shot Speed, Tear Size)",
    "{{ArrowUp}} Stats Up#Gain piercing tears#Rarely attack enemies", nil, "Bot Fly"
)

function BotFly:OnUpgraded(familiar, isPermanentUpgrade)
    local fData = familiar:GetData()
    fData.Sewn_botFly_tearCooldown = BotFly.Stats.TearCooldownMin
end
function BotFly:OnUpdate(familiar)
    local fData = familiar:GetData()

    if fData.Sewn_botFly_tearCooldown == 0 then
        local npc = FindCloserNpc(familiar.Position)
        if npc == nil then
            fData.Sewn_botFly_tearCooldown = 5
            return
        end
        
        local direction = (npc.Position - familiar.Position):Normalized()
        local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.LOST_CONTACT, 0, familiar.Position, direction * BotFly.Stats.TearVelocity, familiar):ToTear()
        tear.CollisionDamage = 8
        tear.TearFlags = tear.TearFlags | TearFlags.TEAR_HOMING | TearFlags.TEAR_SHIELDED

        tear:GetData().Sewn_botFly_isAdditionalTear = true

        fData.Sewn_botFly_tearCooldown = familiar:GetDropRNG():RandomInt( BotFly.Stats.TearCooldownMax - BotFly.Stats.TearCooldownMin ) + BotFly.Stats.TearCooldownMin
    elseif fData.Sewn_botFly_tearCooldown > 0 then
        fData.Sewn_botFly_tearCooldown = fData.Sewn_botFly_tearCooldown - 1
    end
end
function BotFly:TearInit(familiar, tear)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    tear.Scale = tear.Scale * BotFly.Stats.SizeMultiplier[level]
    tear.Velocity = tear.Velocity * BotFly.Stats.ShotSpeedMultiplier[level]
    tear.FallingAcceleration = 0.02 + -0.02 * BotFly.Stats.RangeMultiplier[level]
    tear.TearFlags = tear.TearFlags | BotFly.Stats.AdditionalTearFlags[level]

    local angle = math.atan(tear.Position.Y - familiar.Position.Y, tear.Position.X - familiar.Position.X) * 180 / math.pi;
    if fData.Sewn_botFly_laser ~= nil then
        fData.Sewn_botFly_laser:Remove()
    end
    fData.Sewn_botFly_laser = EntityLaser.ShootAngle(Enums.LaserVariant.LASER_ELECTRIC, familiar.Position, angle, -1, Vector(0, -15), familiar)
    fData.Sewn_botFly_laser.TearFlags = TearFlags.TEAR_SHIELDED
    fData.Sewn_botFly_targetedTear = tear

    if tear:GetData().Sewn_botFly_isAdditionalTear and Sewn_API:IsUltra(fData) then
        fData.Sewn_botFly_tearCooldown = fData.Sewn_botFly_tearCooldown + BotFly.Stats.TearCooldownTimeAfterNormalTear
    end
end
function BotFly:TearUpdate(familiar, tear)
    local fData = familiar:GetData()
    if fData.Sewn_botFly_targetedTear ~= nil and GetPtrHash(fData.Sewn_botFly_targetedTear) == GetPtrHash(tear) then
        local angle = math.atan(tear.Position.Y - familiar.Position.Y, tear.Position.X - familiar.Position.X) * 180 / math.pi;
        fData.Sewn_botFly_laser.Angle = angle
        local laserLength = (tear.Position - familiar.Position):Length()
        fData.Sewn_botFly_laser:SetMaxDistance(laserLength)

        if laserLength > BotFly.Stats.MaxLaserLength then
            fData.Sewn_botFly_laser:Remove()
            fData.Sewn_botFly_laser = nil
            fData.Sewn_botFly_targetedTear = nil
        else
            Delay:DelayFunction(function ()
                if tear:Exists() == false then
                    fData.Sewn_botFly_laser:Remove()
                    fData.Sewn_botFly_laser = nil
                    fData.Sewn_botFly_targetedTear = nil
                end
            end, 1)
        end
    end
end
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, BotFly.OnUpgraded, FamiliarVariant.BOT_FLY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, BotFly.OnUpdate, FamiliarVariant.BOT_FLY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_TEAR_UPDATE, BotFly.TearUpdate, FamiliarVariant.BOT_FLY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, BotFly.TearInit, FamiliarVariant.BOT_FLY)