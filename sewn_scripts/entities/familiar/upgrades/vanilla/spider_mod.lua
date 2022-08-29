local Random = require("sewn_scripts.helpers.random")
local Globals = require("sewn_scripts.core.globals")
local Enums = require("sewn_scripts.core.enums")

local SpiderMod = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.SPIDER_MOD, CollectibleType.COLLECTIBLE_SPIDER_MOD)

-- Sewn_API:AddFamiliarDescription(
--     FamiliarVariant.SPIDER_MOD,
--     "Spawns eggs which apply a random effect to enemies which walk over them#Eggs last 20 seconds",
--     "Higher chance to spawn eggs#At the end of rooms, eggs spawn blue spiders", nil, "Spider Mod"
-- )
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.SPIDER_MOD,
    "行走时有几率生成一个蜘蛛卵，敌人经过蜘蛛卵时随机获得debuff #蜘蛛卵持续20秒",
    "有更高的概率生成蜘蛛卵 #清理房间后，蜘蛛卵将会生成蓝蜘蛛", nil, "蜘蛛模组","zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.SPIDER_MOD,
    "Оставляет яйца за собой, которые, как и он сам, накладывают случайный эффект на врагов при контакте#Яйца пропадают через 20 секунд",
    "{{ArrowUp}} Шанс оставить яйца +#При завершении комнаты яйца спавнят синих пауков", nil, "Паучий Мод", "ru"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.SPIDER_MOD,
    "Pond des œufs qui appliquent un effet aléatoire aux ennemis qui marchent dessus#Les œufs ont une durée de 20 secondes",
    "Augmente les chances de pondre un œuf#Quand une salle est terminée, les œufs éclosent en araignées bleues", nil, "Roboraignée", "fr"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.SPIDER_MOD,
    "Spawnea huevos que aplican efectos aleatorios a enemigos que pasan sobre ellos#Los huevos duran 20 segundos",
    "Alta probabilidad de spawnear huevos#Al final de las habitaciiones, los huevos spawnean arañas azules", nil, "Mod Araña", "spa"
)

SpiderMod.Stats = {
    EggCooldownMin = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 45,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 30
    },
    EggCooldownMax = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 90,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 60
    },
    EggSpawnChance = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 60,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 70
    },
    MinEggDistance = 50,
    EggTimeout = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 20,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 30
    },
    SpawnSpidersChance = 50,
    SpawnSpidersMax = 2,
    SpawnSpidersMin = 0
}

local function IsCloseToEgg(position, range)
    local eggs = Isaac.FindByType(EntityType.ENTITY_EFFECT, Enums.EffectVariant.SPIDER_MOD_EGG, -1, false, false)
    for _, egg in ipairs(eggs) do
        if egg.Position:DistanceSquared(position) < range ^ 2 then
            return true
        end
    end
    return false
end

local function TrySpawnEgg(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    if Random:CheckRoll(SpiderMod.Stats.EggSpawnChance[level], familiar:GetDropRNG()) then
        if IsCloseToEgg(familiar.Position, SpiderMod.Stats.MinEggDistance) then
            return
        end
        
        familiar:GetSprite():Play("Appear", false)
        local egg = Isaac.Spawn(EntityType.ENTITY_EFFECT, Enums.EffectVariant.SPIDER_MOD_EGG, 0, familiar.Position, Globals.V0, familiar):ToEffect()
        
        egg.Timeout = SpiderMod.Stats.EggTimeout[level] * 30
    end
end

function SpiderMod:OnFamiliarUpgrade(familiar, isPermanentUpgrade)
    local fData = familiar:GetData()
    fData.Sewn_spiderMod_eggCooldown = 0
    
end
function SpiderMod:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    if Globals.Room:IsClear() then
        return
    end

    if fData.Sewn_spiderMod_eggCooldown == 0 then
        TrySpawnEgg(familiar)
        fData.Sewn_spiderMod_eggCooldown = familiar:GetDropRNG():RandomInt(SpiderMod.Stats.EggCooldownMax[level] - SpiderMod.Stats.EggCooldownMin[level]) + SpiderMod.Stats.EggCooldownMin[level]
    elseif fData.Sewn_spiderMod_eggCooldown > 0 then
        fData.Sewn_spiderMod_eggCooldown = fData.Sewn_spiderMod_eggCooldown - 1
    end
end
function SpiderMod:OnFamiliarCleanRoom(familiar)
    local eggs = Isaac.FindByType(EntityType.ENTITY_EFFECT, Enums.EffectVariant.SPIDER_MOD_EGG, -1, false, false)
    for _, egg in pairs(eggs) do
        egg = egg:ToEffect()
        if Random:CheckRoll(SpiderMod.Stats.SpawnSpidersChance) then
            local nbSpiders = familiar:GetDropRNG():RandomInt(SpiderMod.Stats.SpawnSpidersMax - SpiderMod.Stats.SpawnSpidersMin) + SpiderMod.Stats.SpawnSpidersMin
            for i = 1, nbSpiders do
                local velocity = Vector(0, 0)
                local force = 30
                velocity.X = math.random() + math.random(force * 2) - force
                velocity.Y = math.random() + math.random(force * 2) - force
                familiar.Player:ThrowBlueSpider(egg.Position, velocity + egg.Position)
            end
        end
        egg.Timeout = 0
    end
end


Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, SpiderMod.OnFamiliarUpgrade, FamiliarVariant.SPIDER_MOD)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, SpiderMod.OnFamiliarUpdate, FamiliarVariant.SPIDER_MOD)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_CLEAN_ROOM, SpiderMod.OnFamiliarCleanRoom, FamiliarVariant.SPIDER_MOD, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)