local BurstTears = require("sewn_scripts.helpers.burst_tears")
local IsSpawnedBy = require("sewn_scripts.helpers.is_spawned_by")

local JuicySack = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.JUICY_SACK, CollectibleType.COLLECTIBLE_JUICY_SACK)

-- Sewn_API:AddFamiliarDescription(
--     FamiliarVariant.JUICY_SACK,
--     "{{Arrow Up}} Creep Size Up#Fires egg tears (from Parasitoid {{Collectibe"..CollectibleType.COLLECTIBLE_PARASITOID.."}}) while isaac is firing",
--     "Fires more egg tears", nil, "Juicy Sack"
-- )
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.JUICY_SACK,
    "可发射蜘蛛卵眼泪 #击中敌人时生成蓝苍蝇或蓝蜘蛛 #产生更大的减速水迹",
    "发射更多蜘蛛卵眼泪", nil, "粘液卵囊","zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.JUICY_SACK,
    "{{ArrowUp}} Размер лужи +#Стреляет слёзы-яйца (как Паразитоид {{Collectible"..CollectibleType.COLLECTIBLE_PARASITOID.."}}, когда игрок стреляет",
    "Стреляет больше слёз-яиц", nil, "Сочащийся Кокон", "ru"
)
-- Sewn_API:AddFamiliarDescription(
--     FamiliarVariant.JUICY_SACK,
--     "{{Arrow Up}} Taille de la trainée#Tirer projette un tas de cocons (similaires à ceux de Parasitoïde {{Collectibe"..CollectibleType.COLLECTIBLE_PARASITOID.."}})",
--     "Propulse davantage de cocons", nil, "Cocon Juteux", "fr"
-- )
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.JUICY_SACK,
    "Dispara lágrimas de huevo mientras Isaac dispara#Las lágrimas de huevo generan moscas o arañas azules al golpear algo#Creep más grande",
    "Dispara más lágrimas de huevo", nil, "Nido Jugoso", "spa"
)

JuicySack.Stats = {
    CreepScale = 1.5,
    EggTearsMin = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1
    },
    EggTearsMax = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 2,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 6
    },
    CooldownMin = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 30,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 20
    },
    CooldownMax = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 60,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 40
    }
}

local function TryToScaleCreepFrom(familiar)
    local creeps = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_WHITE, -1, false, false)
    for _, creep in ipairs(creeps) do
        local eData = creep:GetData()
        if IsSpawnedBy(creep, familiar) and eData.Sewn_juicySack_creepIsScaled == nil then
            creep.Size = creep.Size * JuicySack.Stats.CreepScale
            creep.SpriteScale = creep.SpriteScale * JuicySack.Stats.CreepScale
            eData.Sewn_juicySack_creepIsScaled = true
        end
    end
end

function JuicySack:OnFamiliarUpdate(familiar)
    TryToScaleCreepFrom(familiar)

    if familiar.FireCooldown == 0 then
        local fData = familiar:GetData()
        local level = Sewn_API:GetLevel(fData)
        local nbEggTear = familiar:GetDropRNG():RandomInt(JuicySack.Stats.EggTearsMax[level] - JuicySack.Stats.EggTearsMin[level]) + JuicySack.Stats.EggTearsMin[level]

        if familiar.Player:GetShootingInput():LengthSquared() > 0 then
            BurstTears(familiar, nbEggTear, nil, 4, false, TearVariant.EGG, TearFlags.TEAR_EGG)
            familiar.FireCooldown = familiar:GetDropRNG():RandomInt(JuicySack.Stats.CooldownMax[level] - JuicySack.Stats.CooldownMin[level]) + JuicySack.Stats.CooldownMin[level]
        end
    else
        familiar.FireCooldown = familiar.FireCooldown - 1
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, JuicySack.OnFamiliarUpdate, FamiliarVariant.JUICY_SACK)