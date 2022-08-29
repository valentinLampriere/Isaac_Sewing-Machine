if not REPENTANCE then
    return
end

local ShootTearsCircular = require("sewn_scripts.helpers.shoot_tears_circular")
local Globals = require("sewn_scripts.core.globals")
local FamiliarFollowTrail = require("sewn_scripts.helpers.familiar_follow_trail")

local IsaacsHeart = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.ISAACS_HEART, CollectibleType.COLLECTIBLE_ISAACS_HEART)

-- Sewn_API:AddFamiliarDescription(
--     FamiliarVariant.ISAACS_HEART,
--     "{{ArrowUp}} Decreases charge time#Moves closer to the player when the player isn't firing",
--     "{{ArrowUp}} Decreases charge time#When fully charged, if an enemy or projectile gets too close it automatically activates its fully charged effect#When this activates, it will go on a brief cooldown before being able to charge again", nil, "Isaac's Heart"
-- )
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.ISAACS_HEART,
    "角色在不攻击的时候，心脏与角色距离更近 #蓄力时间变短",
    "当蓄力满时，若有敌人或者弹幕距离心脏很近，心脏将自动释放充能弹开敌人与弹幕（该能力有cd）#蓄力时间大幅变短", nil, "以撒的心脏","zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.ISAACS_HEART,
    "Движется ближе к айзеку когда он не стреляет#Зарядка занимает меньше времени",
    "Когда враг или снаряд подходит слишком близко, если сердце полностью заряжено, оно автоматически срабатывает#Когда срабатывает, будет небольшая задержка перед следующим срабатыванием#Зарядка занимает меньше времени", nil, "Сердце Айзека", "ru"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.ISAACS_HEART,
    "{{ArrowUp}} Réduit le temps de chargement#Ne pas tirer rapproche le cœur plus près d'Isaac",
    "{{ArrowUp}} Réduit le temps de chargement#Repousse automatiquement les tirs et les ennemis trop proche quand il est complètement chargé, puis doit se recharger", nil, "Cœur d'Isaac", "fr"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.ISAACS_HEART,
	"Se acerca a Isaac cuando no dispara#Reduce el tiempo de carga",
    "Al cargarse del todo, si un enemigo o proyectil se acerca mucho se activa automáticamente#Al activarse, deberá reposar momentaneamente antes de cargar denuevo#Reduce el tiempo de carga", nil, "Corazón De Isaac", "spa"
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
    if familiar.Player:GetShootingInput():LengthSquared() == 0 then
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