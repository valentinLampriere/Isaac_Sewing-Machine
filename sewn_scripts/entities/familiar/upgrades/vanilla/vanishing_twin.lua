local Delay = require("sewn_scripts.helpers.delay")
local CColor = require("sewn_scripts.helpers.ccolor")
local Random = require("sewn_scripts.helpers.random")
local Globals = require("sewn_scripts.core.globals")

local VanishingTwin = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.VANISHING_TWIN, CollectibleType.COLLECTIBLE_VANISHING_TWIN)

-- Sewn_API:AddFamiliarDescription(
--     FamiliarVariant.VANISHING_TWIN,
--     "Removes 25% of the boss copy health",
--     "Increases chances to spawn a better item (based on Quality)#Can spawn items from the Treasure pool if no Boss pool item are found", nil, "Vanishing Twin"
-- )
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.VANISHING_TWIN,
    "复制生成的Boss血量减少25%",
    "击杀额外boss后将会生成等级更高的道具 #从 {{TreasureRoom}} 道具房与 {{BossRoom}} Boss房道具池中生成", nil, "消失的胞胎","zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.VANISHING_TWIN,
    "Убирает 25% здоровья босса-копии",
    "Увеличивает шанс заспавнить предмет более высшего качества#Может заспавнить предмет пула Сокровищницы, если предметы пула Босса не найдены", nil, "Исчезающий Близнец", "ru"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.VANISHING_TWIN,
    "Réduit de 25% les PV du boss copié",
    "Augmente les chances d'obtenir un meilleur objet (selon la Qualité)#Peut faire apparaître un objet de la Treasure Room {{TreasureRoom}} si aucun objet de la Boss Room n'a été trouvé", nil, "Jumeau Évanescent", "fr"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.VANISHING_TWIN,
    "Quita el 25% de la vida de la copia del boss",
    "Sube la probabilidad de spawnear un item mejor (basado en la Calidad)#Puede spawnear items que vienen de la sala del tesoro si no se encuentran items del boss", nil, "Gemelo Invisible", "spa"
)

VanishingTwin.Stats = {
    QualityFourChance = 7,
    QualityThreeChance = 30,
    QualityTwoChance = 75,
}

local function CheckItem(familiar, item)
    local itemPool = Globals.Game:GetItemPool()
    local itemConfig = Isaac.GetItemConfig()

    local roll = Random:Roll(familiar:GetDropRNG())

    local currentItem = item.SubType
    local rollQuality = 1
    local pool = itemPool:GetPoolForRoom(Globals.Room:GetType(), Globals.Game:GetSeeds():GetStartSeed())

    local attempt = 0
    local bestItemFound = currentItem

    if roll < VanishingTwin.Stats.QualityFourChance then
        rollQuality = 4
    elseif roll < VanishingTwin.Stats.QualityThreeChance then
        rollQuality = 3
    elseif roll < VanishingTwin.Stats.QualityTwoChance then
        rollQuality = 2
    end

    while itemConfig:GetCollectible(currentItem).Quality < rollQuality and attempt < 30 do
        currentItem = itemPool:GetCollectible(pool, false, nil, item.SubType) -- removing from pool set to false

        if itemConfig:GetCollectible(currentItem).Quality > itemConfig:GetCollectible(bestItemFound).Quality then
            bestItemFound = currentItem
        end

        attempt = attempt + 1
        
        if attempt > 10 then
            pool = ItemPoolType.POOL_TREASURE
        end
    end

    if item.SubType == currentItem then
        return
    end

    item:Remove()

    local newItem = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, bestItemFound, item.Position, Globals.V0, nil)
    newItem:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
    itemPool:RemoveCollectible(bestItemFound)
end

function VanishingTwin:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()
    if fData.Sewn_vanishingTwin_isVisible == true and familiar.Visible == false then
        Delay:DelayFunction(function()
            local npcs = Isaac.FindInRadius(familiar.Position, 20, EntityPartition.ENEMY)
            for _, npc in ipairs(npcs) do
                npc = npc:ToNPC()
                if npc:IsBoss() and npc.FrameCount <=  1 then -- Check for the vanishing twin boss(es)
                    npc.HitPoints = npc.MaxHitPoints * 0.5 -- Remove half of the boss health

                    fData.Sewn_vanishingTwin_copyBoss = true

                    local c = npc:GetColor()
                    local nColor = CColor(c.R, c.G, c.B, c.A, c.RO, c.GO, c.BO)
                    nColor:SetOffset(0.10, 0.08, 0.05)
                    npc:SetColor(nColor, -1, 1, false, true)
                end
            end
        end, 0)
        Sewn_API:HideCrown(familiar, true)
    elseif fData.Sewn_vanishingTwin_isVisible == false and familiar.Visible == true then
        Sewn_API:HideCrown(familiar, false)
    end
    fData.Sewn_vanishingTwin_isVisible = familiar.Visible
end

function VanishingTwin:OnFamiliarUpdate_Ultra(familiar)
    local fData = familiar:GetData()
    if Globals.Room:GetType() == RoomType.ROOM_BOSS and fData.Sewn_vanishingTwin_copyBoss and fData.Sewn_vanishingTwin_spawnItem ~= true then
        for _, pickup in pairs(Isaac.FindInRadius(familiar.Position, 50, EntityPartition.PICKUP)) do
            if pickup.Variant == PickupVariant.PICKUP_COLLECTIBLE and pickup.FrameCount == 1 then
                CheckItem(familiar, pickup)
                fData.Sewn_vanishingTwin_spawnItem = true
            end
        end
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, VanishingTwin.OnFamiliarUpdate, FamiliarVariant.VANISHING_TWIN)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, VanishingTwin.OnFamiliarUpdate_Ultra, FamiliarVariant.VANISHING_TWIN, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)