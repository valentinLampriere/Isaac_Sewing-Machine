local Enums = require("sewn_scripts.core.enums")
local Globals = require("sewn_scripts.core.globals")
local Random = require("sewn_scripts.helpers.random")

local BombBag = { }

BombBag.Stats = {
    PowderSpawnCooldown = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 6,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 5
    },
    PowderMinDistance = 10,
    PowderTimeout = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 80,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 120
    },
    BombDoublePackChance = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 5,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 10
    },
    BombGoldenChance = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 2
    },
    BombGigaChance = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1
    },
    SelfExplodeCooldownMax = 200,
    SelfExplodeCooldownMin = 100,
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.BOMB_BAG, CollectibleType.COLLECTIBLE_BOMB_BAG)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BOMB_BAG,
    "No longer spawns troll bombs#Better bomb drops#Spawn powder on the ground. The powder catches fire when it is close to fires or when something explode",
    "Better bombs drops#Can drop Giga bombs [Rep]#When it is to close to an enemy, it will sometimes explode", nil, "Bomb Bag"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BOMB_BAG,
    "不再生成即爆炸弹 #产生更好的炸弹掉落 #角色走过的地方将会掉落火药粉末，着火的敌人与炸弹均可引燃",
    "产生更好的炸弹掉落 #可掉落giga炸弹（矿层可毁灭地形的大炸弹）#敌人接近时有概率爆炸", nil, "Bomb Bag", "zh_cn"
)

local function GetCloseBombBagPowders(position)
    local closeBombBagPowders = {}
    local bombBagPowders = Isaac.FindByType(EntityType.ENTITY_EFFECT, Enums.EffectVariant.BOMB_BAG_POWDER, -1, false, false)
    for i, bombBagPowder in ipairs(bombBagPowders) do
        if (bombBagPowder.Position - position):LengthSquared() <= BombBag.Stats.PowderMinDistance ^2 then
            table.insert(closeBombBagPowders, bombBagPowder)
        end
    end
    return closeBombBagPowders
end

function BombBag:FamiliarInit(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    fData.Sewn_bombBag_powderCooldown = BombBag.Stats.PowderSpawnCooldown[level]
end
function BombBag:FamiliarUpdate(familiar)
    local fData = familiar:GetData()
    if fData.Sewn_bombBag_powderCooldown <= 0 then
        local bombBagPowders = GetCloseBombBagPowders(familiar.Position)
        if #bombBagPowders == 0 then
            local powder = Isaac.Spawn(EntityType.ENTITY_EFFECT, Enums.EffectVariant.BOMB_BAG_POWDER, -1, familiar.Position, Globals.V0, familiar):ToEffect()
            powder.Timeout = BombBag.Stats.PowderTimeout[Sewn_API:GetLevel(fData)]
        end
        fData.Sewn_bombBag_powderCooldown = BombBag.Stats.PowderSpawnCooldown[Sewn_API:GetLevel(fData)]
    else
        fData.Sewn_bombBag_powderCooldown = fData.Sewn_bombBag_powderCooldown - 1
    end
end

local function MorphBomb(bomb, subtype)
    bomb:Morph(bomb.Type, bomb.Variant, subtype, true)
    local bData = bomb:GetData()
    bData.Sewn_bombBag_checked = true
end

local function TryMorphBomb(bomb, level, rng)
    if bomb.SubType == BombSubType.BOMB_NORMAL then
        if Random:CheckRoll(BombBag.Stats.BombDoublePackChance[level], rng) then
            MorphBomb(bomb, BombSubType.BOMB_DOUBLEPACK)
        end
    elseif bomb.SubType == BombSubType.BOMB_TROLL then
        MorphBomb(bomb, BombSubType.BOMB_NORMAL)
    elseif bomb.SubType == BombSubType.BOMB_SUPERTROLL then
        MorphBomb(bomb, BombSubType.BOMB_DOUBLEPACK)
    end
    if Random:CheckRoll(BombBag.Stats.BombGoldenChance[level], rng) then
        MorphBomb(bomb, BombSubType.BOMB_GOLDEN)
    end
    if REPENTANCE and Random:CheckRoll(BombBag.Stats.BombGigaChance[level], rng) then
        MorphBomb(bomb, BombSubType.BOMB_GIGA)
    end
end

function BombBag:PlaySpawnAnim(familiar, sprite)
    local fData = familiar:GetData()

    local bombs = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, -1, false, true)
    for _, bomb in ipairs(bombs) do
        bomb = bomb:ToPickup()
        local bData = bomb:GetData()
        if bData.Sewn_bombBag_checked == nil and bomb.SpawnerEntity ~= nil and GetPtrHash(bomb.SpawnerEntity) == GetPtrHash(familiar) then
            TryMorphBomb(bomb, Sewn_API:GetLevel(fData), familiar:GetDropRNG())
        end
        bData.Sewn_bombBag_checked = true
    end
end

function BombBag:FamiliarInit_Ultra(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    fData.Sewn_bombBag_selfExplodeCooldown = BombBag.Stats.SelfExplodeCooldownMin
end
function BombBag:FamiliarUpdate_Ultra(familiar)
    local fData = familiar:GetData()

    local closeNpcs = Isaac.FindInRadius(familiar.Position - familiar.Velocity, familiar.Size * 2, EntityPartition.ENEMY)
    local hasCloseEnemy = false
    for _, npc in ipairs(closeNpcs) do
        if npc:IsVulnerableEnemy() then
            hasCloseEnemy = true
            break
        end
    end
    if hasCloseEnemy then
        if fData.Sewn_bombBag_selfExplodeCooldown <= 0 then
            Isaac.Explode(familiar.Position, familiar.Player, 30)

            fData.Sewn_bombBag_selfExplodeCooldown = familiar:GetDropRNG():RandomInt( BombBag.Stats.SelfExplodeCooldownMax - BombBag.Stats.SelfExplodeCooldownMin ) + BombBag.Stats.SelfExplodeCooldownMin
        else
            fData.Sewn_bombBag_selfExplodeCooldown = fData.Sewn_bombBag_selfExplodeCooldown - 1
        end
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, BombBag.FamiliarInit, FamiliarVariant.BOMB_BAG)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_INIT, BombBag.FamiliarInit, FamiliarVariant.BOMB_BAG)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_PLAY_ANIM, BombBag.PlaySpawnAnim, FamiliarVariant.BOMB_BAG, nil, "Spawn")
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, BombBag.FamiliarUpdate, FamiliarVariant.BOMB_BAG)

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, BombBag.FamiliarInit_Ultra, FamiliarVariant.BOMB_BAG, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_INIT, BombBag.FamiliarInit_Ultra, FamiliarVariant.BOMB_BAG, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, BombBag.FamiliarUpdate_Ultra, FamiliarVariant.BOMB_BAG, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)