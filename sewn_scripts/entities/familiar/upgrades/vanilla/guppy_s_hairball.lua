local Random = require("sewn_scripts.helpers.random")
local Globals = require("sewn_scripts.core.globals")

local GuppysHairball = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.GUPPYS_HAIRBALL, CollectibleType.COLLECTIBLE_GUPPYS_HAIRBALL)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.GUPPYS_HAIRBALL,
    "Start on the second size#Have a chance to spawn flies when it kills an enemy or when it blocks a projectile",
    "Start on the third size#Spawns more flies when it kills an enemy and when it blocks projectiles", nil, "Guppy's Hairball"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.GUPPYS_HAIRBALL,
    "每层初始时直接提升到第二形态的大小，击杀或阻挡弹幕时有概率生成蓝苍蝇",
    "每层初始时直接提升到第三形态的大小，击杀或阻挡弹幕时有概率生成更多蓝苍蝇", nil, "嗝屁猫的毛球","zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.GUPPYS_HAIRBALL,
    "Начинает со второй фазы#Получает шанс дать синюю муху когда он убивает врага или блокирует вражеский снаряд",
    "Начинает с третьей фазы#Спавнит больше мух когда он убивает врага или блокирует вражеский снаряд", nil, "Комок шерсти Гаппи", "ru"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.GUPPYS_HAIRBALL,
    "Passe immédiatement au deuxième stage#Tuer un ennemi ou bloquer un projectile peut invoquer des mouches bleues",
    "Passe immédiatement au troisième stage#Génère davantage de mouches bleues", nil, "Boule de Poils de Guppy", "fr"
)

GuppysHairball.Stats = {
    MinLevel = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 2
    },
    BlueFliesOnKillChance = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 60,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 90
    },
    BlueFliesAmountMin = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1
    },
    BlueFliesAmountMax = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 2,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 4
    }
}

local function SetMinLevel(familiar, currentLevel)
    local fData = familiar:GetData()
    currentLevel = currentLevel or Sewn_API:GetLevel(fData)

    local minLevel = GuppysHairball.Stats.MinLevel[currentLevel] or 0
    if familiar.SubType < minLevel then
        familiar.SubType = minLevel
    end
end

function GuppysHairball:OnNewRoom(familiar)
    SetMinLevel(familiar)
end
local function SpawnBlueFlies(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    local amountFiles = familiar:GetDropRNG():RandomInt( GuppysHairball.Stats.BlueFliesAmountMax[level] - GuppysHairball.Stats.BlueFliesAmountMin[level] ) + GuppysHairball.Stats.BlueFliesAmountMin[level]
    for i = 1, amountFiles do
        local velo = Vector(math.random(-25.0, 25.0), math.random(-25.0, 25.0))
        local player = familiar.Player or Isaac.GetPlayer(0)
        local blueFly = player:AddBlueFlies(1, familiar.Position, player)
        blueFly.Velocity = velo
    end
end
function GuppysHairball:OnKillNpc(familiar, npc)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    if Random:CheckRoll(GuppysHairball.Stats.BlueFliesOnKillChance[level], familiar:GetDropRNG()) then
        SpawnBlueFlies(familiar)
    end
end
function GuppysHairball:OnCollision(familiar, collider)
    if collider.Type == EntityType.ENTITY_PROJECTILE then
        local fData = familiar:GetData()
        local level = Sewn_API:GetLevel(fData)
        if Random:CheckRoll(GuppysHairball.Stats.BlueFliesOnKillChance[level], familiar:GetDropRNG()) then
            SpawnBlueFlies(familiar)
        end
    end
end
function GuppysHairball:PreAddInSewingMachine(familiar, machine)
    local mData = machine:GetData().SewingMachineData
    mData.Sewn_guppysHairball_subtype = familiar.SubType
end
function GuppysHairball:GetFromSewingMachine(familiar, player, machine, isUpgraded, newLevel)
    local mData = machine:GetData().SewingMachineData
    familiar.SubType = mData.Sewn_guppysHairball_subtype or 0
    SetMinLevel(familiar, newLevel)
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_NEW_ROOM, GuppysHairball.OnNewRoom, FamiliarVariant.GUPPYS_HAIRBALL)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_KILL_NPC, GuppysHairball.OnKillNpc, FamiliarVariant.GUPPYS_HAIRBALL)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.PRE_FAMILIAR_COLLISION, GuppysHairball.OnCollision, FamiliarVariant.GUPPYS_HAIRBALL)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.PRE_ADD_FAMILIAR_IN_SEWING_MACHINE, GuppysHairball.PreAddInSewingMachine, FamiliarVariant.GUPPYS_HAIRBALL)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_GET_FAMILIAR_FROM_SEWING_MACHINE, GuppysHairball.GetFromSewingMachine, FamiliarVariant.GUPPYS_HAIRBALL)