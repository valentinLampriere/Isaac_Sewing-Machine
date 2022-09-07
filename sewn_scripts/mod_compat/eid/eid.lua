if not EID then
    return
end

local EIDManager = require("sewn_scripts.mod_compat.eid.eid_manager")
local Localization = require("sewn_scripts.localization.localization")
local AvailableFamiliarManager = require("sewn_scripts.core.available_familiars_manager")

---------------
-- EID Icons --
---------------
local sewingMachineIcon = Sprite()
sewingMachineIcon:Load("gfx/mapicon.anm2", true)
EID:addIcon("SewingMachine", "Icon", 0, 13, 13, 0, 0, sewingMachineIcon)

local crownSprite = Sprite()
crownSprite:Load("gfx/sewn_familiar_crown.anm2", true)
EID:addIcon("SuperCrown", "Super", 0, 13, 10, 3, 10, crownSprite)
EID:addIcon("UltraCrown", "Ultra", 0, 13, 10, 3, 10, crownSprite)

-----------------------
-- EID Mod Indicator --
-----------------------
EID:setModIndicatorIcon("SewingMachine")
EID:setModIndicatorName("Sewing Machine")

----------------------
-- EID Descriptions --
----------------------
Localization:ForEachLanguage(function (languageCode)
    -- EID Collectibles
    local itemCount = Localization:GetCollectiblesNum(languageCode)
    for itemIndex = 1, itemCount do
        local id = Localization:GetCollectibleId(itemIndex)
        local name = Localization:GetCollectibleName(id, languageCode)
        local description = Localization:GetCollectibleDescription(id, languageCode)
        EID:addCollectible(id, description, name, languageCode)
    end
    -- EID Trinkets
    local trinketCount = Localization:GetTrinketsNum(languageCode)
    for trinketIndex = 1, trinketCount do
        local id = Localization:GetTrinketId(trinketIndex)
        local name = Localization:GetTrinketName(id, languageCode)
        local description = Localization:GetTrinketDescription(id, languageCode)
        EID:addTrinket(id, description, name, languageCode)
    end
    -- EID Cards
    local cardCount = Localization:GetCardsNum(languageCode)
    for cardIndex = 1, cardCount do
        local id = Localization:GetCardId(cardIndex)
        local name = Localization:GetCardName(id, languageCode)
        local description = Localization:GetCardDescription(id, languageCode)
        EID:addCard(id, description, name, languageCode)
    end
end)

--------------------------------
-- EID Descriptions Modifiers --
--------------------------------
local function UpgradableFamiliarsModifierCallback(descObj)
    EID:appendToDescription(descObj, "#{{SuperCrown}} " .. Localization:GetText(Localization.TextKey.Upgradable))
    return descObj
end
local function UpgradableFamiliarsModifierCondition(descObj)
    if descObj.ObjType ~= EntityType.ENTITY_PICKUP or descObj.ObjVariant ~= PickupVariant.PICKUP_COLLECTIBLE then
        return false
    end

    local familiarVariant = AvailableFamiliarManager:GetFamiliarFromCollectible(descObj.ObjSubType)
    return familiarVariant ~= nil
end

EID:addDescriptionModifier("Upgradable familiars", UpgradableFamiliarsModifierCondition, UpgradableFamiliarsModifierCallback)

local function FamiliarUpgradePreviewModifierCondition(descObj)
	if EID:PlayersActionPressed(EID.Config["BagOfCraftingToggleKey"]) == false or EID.inModifierPreview then
        return false
    end

    if UpgradableFamiliarsModifierCondition(descObj) == false then
        return false
    end

	return true
end

local function FamiliarUpgradePreviewModifierCallback(descObj)
	EID.TabDescThisFrame = true

	EID.inModifierPreview = true
	local descEntry = EIDManager:GetFamiliarUpgradeDescObj(descObj.ObjSubType)
	
    EID.inModifierPreview = false
	--EID.TabPreviewID = 0
	return descEntry
end

EID:addDescriptionModifier("Familiar Upgrade Preview", FamiliarUpgradePreviewModifierCondition, FamiliarUpgradePreviewModifierCallback)