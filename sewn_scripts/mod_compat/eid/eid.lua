if not EID then
    return
end

local EIDManager = require("sewn_scripts.mod_compat.eid.eid_manager")
local LocalizationCore = require("sewn_scripts.localization.localization_core")
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
for languageCode, textsData in pairs(LocalizationCore.AvailableLanguages) do
    -- EID Collectibles
    for index, itemData in ipairs(textsData.Items) do
        local id = LocalizationCore.CollectiblesIndexToId[index]
        EID:addCollectible(id, itemData[2], itemData[1], languageCode)
    end
    
    -- EID Trinkets
    for index, trinketData in ipairs(textsData.Trinkets) do
        local id = LocalizationCore.TrinketsIndexToId[index]
        EID:addTrinket(id, trinketData[2], trinketData[1], languageCode)
    end
end

--------------------------------
-- EID Descriptions Modifiers --
--------------------------------
local function UpgradableFamiliarsModifierCallback(descObj)
    EID:appendToDescription(descObj, "#{{SuperCrown}} Upgradable")
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