local Enums = require("sewn_scripts.core.enums")
local Random = require("sewn_scripts.helpers.random")

local CubeBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.CUBE_BABY, CollectibleType.COLLECTIBLE_CUBE_BABY)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.CUBE_BABY,
    "Gains a freezing aura. Enemies which stay too long in the aura will take damage until they are completely frozen",
    "Spawns creep when moved around#The faster it moves, the more it spawns creep", nil, "Cube Baby"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.CUBE_BABY,
    "具有一圈冰冻光环，敌人在其中停留一定时间将会直接冰冻",
    "在移动路径上留下一道可造成伤害的水迹 #移动越快，留下的水迹越多", nil, "冰块宝宝","zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.CUBE_BABY,
    "Получает замораживающую ауру. Враги, находясь в ауре слишком долго, будут получать урон, пока не заморозятся (умрут)",
    "Оставляет лужи при перемещении. Чем быстрее он перемещается, тем больше оставляет луж", nil, "Малыш в Кубе", "ru"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.CUBE_BABY,
    "Obtient une aura gelée. Les ennemis qui restent trop longtemps dans l'aura subissent des dégâts jusqu'à être complètement gelés",
    "Répand une trainée derrière lui lorsqu'il est poussé#Répand davantage selon sa vitesse#", nil, "Bébé Glaçon", "fr"
)

CubeBaby.Stats = {
    CreepSpawnRate = 50,
    CreepCooldown = 0,
    CreepDamage = 1.5,
    MaxSpeed = 500,
}

local function SpawnCreep(familiar)
    local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL, 0, familiar.Position, Vector.Zero, familiar):ToEffect()
    creep.CollisionDamage = CubeBaby.Stats.CreepDamage
    creep:Update()
end

function CubeBaby:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()

    if fData.Sewn_cubeBaby_aura == nil or not fData.Sewn_cubeBaby_aura:Exists() then
        fData.Sewn_cubeBaby_aura = Isaac.Spawn(EntityType.ENTITY_EFFECT, Enums.EffectVariant.CUBE_BABY_AURA, 0, familiar.Position, Vector.Zero, familiar):ToEffect()
    end
    
    -- Follow Cube Baby
    fData.Sewn_cubeBaby_aura.Position = familiar.Position
    fData.Sewn_cubeBaby_aura.Velocity = familiar.Velocity
end

function CubeBaby:OnFamiliarUpdate_Ultra(familiar)
    local fData = familiar:GetData()

    if fData.Sewn_cubeBaby_creepCooldown == 0 then
        local speed = math.ceil(familiar.Velocity:LengthSquared())
        if speed > CubeBaby.Stats.MaxSpeed - 1 then speed = CubeBaby.Stats.MaxSpeed - 1 end
        if familiar:GetDropRNG():RandomInt(CubeBaby.Stats.MaxSpeed - speed) < CubeBaby.Stats.CreepSpawnRate then
            SpawnCreep(familiar)
        end
        fData.Sewn_cubeBaby_creepCooldown = CubeBaby.Stats.CreepCooldown
    elseif fData.Sewn_cubeBaby_creepCooldown > 0 then
        fData.Sewn_cubeBaby_creepCooldown = fData.Sewn_cubeBaby_creepCooldown - 1
    end
end

function CubeBaby:RemoveAura(familiar)
    local fData = familiar:GetData()

    if fData.Sewn_cubeBaby_aura ~= nil then
        fData.Sewn_cubeBaby_aura:Remove()
        fData.Sewn_cubeBaby_aura = nil
    end
end

function CubeBaby:OnFamiliarUpgraded(familiar)
    local fData = familiar:GetData()

    fData.Sewn_cubeBaby_creepCooldown = 0
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, CubeBaby.OnFamiliarUpdate, FamiliarVariant.CUBE_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, CubeBaby.OnFamiliarUpdate_Ultra, FamiliarVariant.CUBE_BABY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, CubeBaby.OnFamiliarUpgraded, FamiliarVariant.CUBE_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.PRE_ADD_FAMILIAR_IN_SEWING_MACHINE, CubeBaby.RemoveAura, FamiliarVariant.CUBE_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_LOSE_UPGRADE, CubeBaby.RemoveAura, FamiliarVariant.CUBE_BABY)