if not REPENTANCE then
    return
end

local ShootTearsCircular = require("sewn_scripts.helpers.shoot_tears_circular")
local Globals = require("sewn_scripts.core.globals")
local FamiliarFollowTrail = require("sewn_scripts.helpers.familiar_follow_trail")

local IsaacsHeart = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.ISAACS_HEART, CollectibleType.COLLECTIBLE_ISAACS_HEART)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.ISAACS_HEART,
    "Move closer to the player when the player isn't firing#Decrease charge time",
    "When fully charged, if an enemy or projectile gets too close it automatically activates it's fully charged effect#When this activates, it will go on a brief cooldown before being able to charge again#Decrease charge time"
)

IsaacsHeart.Stats = {
    FireRateBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 8,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 16
    },
    PanicRadius = 35,
    PanicCooldown = 30,
}

function IsaacsHeart:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()
    if familiar.Player:GetShootingInput():Length() == 0 then
        FamiliarFollowTrail(familiar, familiar.Player.Position, true)
    end
    if familiar.FireCooldown > 0 and familiar.FireCooldown < 30 then
        if familiar.FireCooldown % 30 < IsaacsHeart.Stats.FireRateBonus[Sewn_API:GetLevel(fData)] then
            familiar.FireCooldown = familiar.FireCooldown + 1
        end
    end
end

function IsaacsHeart:OnFamiliarUpdate_Ultra(familiar)
    if familiar.FireCooldown >= 30 then
        local npc_bullet = Isaac.FindInRadius(familiar.Position, IsaacsHeart.Stats.PanicRadius, EntityPartition.ENEMY | EntityPartition.BULLET)
        if #npc_bullet > 0 then
            ShootTearsCircular(familiar, 9, TearVariant.BLOOD, nil, 7, 8)
            
            local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, familiar.Position, Globals.V0, familiar):ToEffect()
            creep.Timeout = -1

            Globals.Game:ButterBeanFart(familiar.Position, 100, familiar.Player, false)
            
            familiar.FireCooldown = - IsaacsHeart.Stats.PanicCooldown

            familiar:GetSprite():Play("ChargeAttack", false)
        end
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, IsaacsHeart.OnFamiliarUpdate, FamiliarVariant.ISAACS_HEART)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, IsaacsHeart.OnFamiliarUpdate_Ultra, FamiliarVariant.ISAACS_HEART, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)