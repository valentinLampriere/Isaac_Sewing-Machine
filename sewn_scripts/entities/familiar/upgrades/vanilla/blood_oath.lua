local Delay = require("sewn_scripts.helpers.delay")
local Globals = require("sewn_scripts.core.globals")

local BloodOath = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.BLOOD_OATH, CollectibleType.COLLECTIBLE_BLOOD_OATH)

-- Sewn_API:AddFamiliarDescription(
--     FamiliarVariant.BLOOD_OATH,
--     "Spawns red creep#Creep rate and damage depends on the amount of half hearts {{HalfHeart}} removed",
--     "When it stabs, spawns random red hearts {{Heart}}", nil, "Blood Oath"
-- )
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BLOOD_OATH,
    "角色额外生成血迹，生成血迹的概率与伤害跟血誓抽掉的 {{Heart}} 红心成正比",
    "每层初始房间血誓对角色造成伤害时将额外掉落 {{Heart}} 红心", nil, "血誓", "zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BLOOD_OATH,
    "Оставляет красные лужи под собой#Частота и урон луж зависит от количества потраченных половин сердец {{HalfHeart}}",
    "Когда она срабатывает, спавнит разные красные сердца {{Heart}} неподалёку", nil, "Кровяная Клятва", "ru"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BLOOD_OATH,
    "Répand une traînée de sang derrière lui#Le taux d'apparition des trainées de sang et leur dégâts dépendent du nombre de demi-coeurs {{HalfHeart}} retirés",
    "Fait apparaitre des coeurs rouges {{Heart}} après avoir poignardé Isaac", nil, "Serment du Sang", "fr"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BLOOD_OATH,
    "Genera creep rojo#La cantidad y el daño del creep depende de la cantidad de mitades de corazón removidas",
    "Al clavar a Isaac, genera corazones rojos al azar", nil, "Juramento De Sangre", "spa"
)

BloodOath.Stats = {
    CreepCooldownDefaultMin = 35,
    CreepCooldownDefaultMax = 45,
    CreepCooldownHeartRemovedBonusFactor = 6.5,
    CreepCooldownMinCap = 2,
    CreepCooldownMax = 40,
    CreepScale = 0.75,
    CreepDamageFactor = 0.5,
}

function BloodOath:OnFamiliarInit(familiar)
    local fData = familiar:GetData()
    fData.Sewn_bloodOath_creepCooldown = BloodOath.Stats.CreepCooldownDefaultMin
    fData.Sewn_bloodOath_playerRemovedHealth = 0
end

local function SpawnCreep(familiar)
    local fData = familiar:GetData()
    local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, familiar.Position, Globals.V0, familiar)
    creep.CollisionDamage = math.sqrt(fData.Sewn_bloodOath_playerRemovedHealth) * BloodOath.Stats.CreepDamageFactor
    creep.Size = creep.Size * BloodOath.Stats.CreepScale
    creep.SpriteScale = creep.SpriteScale * BloodOath.Stats.CreepScale

    local r = familiar:GetDropRNG():RandomInt(BloodOath.Stats.CreepCooldownDefaultMax - BloodOath.Stats.CreepCooldownDefaultMin) + BloodOath.Stats.CreepCooldownDefaultMin
    local f = BloodOath.Stats.CreepCooldownHeartRemovedBonusFactor
    local x = fData.Sewn_bloodOath_playerRemovedHealth

    fData.Sewn_bloodOath_creepCooldown = r - math.floor(f * math.sqrt(x))
    if fData.Sewn_bloodOath_creepCooldown < BloodOath.Stats.CreepCooldownMinCap then
        fData.Sewn_bloodOath_creepCooldown = BloodOath.Stats.CreepCooldownMinCap
    end
end

local bloodOath_heartWeight = {
    3, -- HEART_FULL
    1, -- HEART_HALF
    5  -- HEART_DOUBLEPACK
}
local bloodOath_heartSubType = {
    1, -- HEART_FULL
    2, -- HEART_HALF
    5  -- HEART_DOUBLEPACK
}
local function SpawnHearts(familiar)
    local fData = familiar:GetData()
    local roll
    if fData.Sewn_bloodOath_playerRemovedHealth < 1 then
        return
    elseif fData.Sewn_bloodOath_playerRemovedHealth <= 4 then
        roll = math.random(fData.Sewn_bloodOath_playerRemovedHealth)
    else
        roll = math.random(fData.Sewn_bloodOath_playerRemovedHealth - 2) + 2
    end
    local heartsRemains = roll
    
    while heartsRemains > 0 do
        local rollHeart = math.random(1, 3)

        if heartsRemains - bloodOath_heartWeight[rollHeart] >= 0 then
            local velo = Vector(math.random(-5, 5), math.random(-5, 5))

            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, bloodOath_heartSubType[rollHeart], familiar.Position, velo, familiar)

            heartsRemains = heartsRemains - bloodOath_heartWeight[rollHeart]
        end
    end
end

function BloodOath:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()
    if fData.Sewn_bloodOath_playerRemovedHealth > 0 and fData.Sewn_bloodOath_creepCooldown == 0 then
        SpawnCreep(familiar)
    end
    if fData.Sewn_bloodOath_creepCooldown > 0 then
        fData.Sewn_bloodOath_creepCooldown = fData.Sewn_bloodOath_creepCooldown - 1
    end
end

function BloodOath:OnPlayStabAnim(familiar, sprite)
    local fData = familiar:GetData()
    if sprite:GetFrame() == 18 then
        fData.Sewn_bloodOath_playerHpBeforeStab = familiar.Player:GetHearts()
    elseif sprite:IsEventTriggered("Hit") then
        fData.Sewn_bloodOath_playerRemovedHealth = fData.Sewn_bloodOath_playerHpBeforeStab - familiar.Player:GetHearts()

        if Sewn_API:IsUltra(fData) then
            SpawnHearts(familiar)
        end
    end
end

function BloodOath:OnFamiliarNewLevel(familiar)
    local fData = familiar:GetData()
    fData.Sewn_bloodOath_playerRemovedHealth = 0
end


Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, BloodOath.OnFamiliarInit, FamiliarVariant.BLOOD_OATH)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_INIT, BloodOath.OnFamiliarInit, FamiliarVariant.BLOOD_OATH)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, BloodOath.OnFamiliarUpdate, FamiliarVariant.BLOOD_OATH)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_NEW_LEVEL, BloodOath.OnFamiliarNewLevel, FamiliarVariant.BLOOD_OATH)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_PLAY_ANIM, BloodOath.OnPlayStabAnim, FamiliarVariant.BLOOD_OATH, nil, "Stab")