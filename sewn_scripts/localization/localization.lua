local LocalizationCore = require("sewn_scripts.localization.localization_core")
local FamiliarDescription = require("sewn_scripts.mod_compat.eid.familiar_description")

local Localization = { }

local function GetLanguageCode()
    return EID ~= nil and EID:getLanguage() or "en_us"
end

local function GetCollectible(collectibleId, languageCode)
    local languageCode = languageCode
    
    if LocalizationCore.AvailableLanguages[languageCode] == nil then
        error("The language with tag \"".. languageCode .."\" isn't registered.")
        return;
    end

    local index = LocalizationCore.CollectiblesIdToIndex[collectibleId]
    return LocalizationCore.AvailableLanguages[languageCode].Items[index]
end

local function GetTrinket(trinketId, languageCode)
    local languageCode = languageCode
    
    if LocalizationCore.AvailableLanguages[languageCode] == nil then
        error("The language with tag \"".. languageCode .."\" isn't registered.")
        return;
    end

    local index = LocalizationCore.TrinketsIdToIndex[trinketId]
    return LocalizationCore.AvailableLanguages[languageCode].Trinkets[index]
end

local function GetFamiliarUpgrade(familiarVariant, languageCode)
    local languageCode = languageCode
    
    if LocalizationCore.AvailableLanguages[languageCode] == nil then
        error("The language with tag \"".. languageCode .."\" isn't registered.")
        return;
    end

    local index = LocalizationCore.FamiliarsUpgradesVariantToIndex[familiarVariant]
    local familiarData = LocalizationCore.AvailableLanguages[languageCode].FamiliarUpgrades[index]

    if type(familiarData[1]) == "string" then
        return familiarData
    elseif type(familiarData[1]) == "table" then
        if REPENTANCE then
            return familiarData[1]
        else
            return familiarData[2]
        end
    end

    error("Can't find the upgrade descriptions for this familiar : " .. familiarVariant)
end

function Localization:GetCollectibleName(collectibleId, languageCode)
    return GetCollectible(collectibleId, languageCode)[1]
end

function Localization:GetCollectibleDescription(collectibleId, languageCode)
    return GetCollectible(collectibleId, languageCode)[2]
end

function Localization:GetTrinketName(trinketId, languageCode)
    return GetTrinket(trinketId, languageCode)[1]
end

function Localization:GetTrinketDescription(trinketId, languageCode)
    return GetTrinket(trinketId, languageCode)[2]
end

function Localization:GetFamiliarOptionalName(familiarVariant, languageCode)
    return GetFamiliarUpgrade(familiarVariant, languageCode)[3]
end

function Localization:GetFamiliarUpgradeSuper(familiarVariant, languageCode)
    return GetFamiliarUpgrade(familiarVariant, languageCode)[1]
end

function Localization:GetFamiliarUpgradeUltra(familiarVariant, languageCode)
    return GetFamiliarUpgrade(familiarVariant, languageCode)[2]
end

for id, familiarVariant in pairs(LocalizationCore.FamiliarsUpgradesIndexToVariant) do
    for languageCode, _ in pairs(LocalizationCore.AvailableLanguages) do
        local optionalName = Localization:GetFamiliarOptionalName(familiarVariant, languageCode)
        local superUpgrade = Localization:GetFamiliarUpgradeSuper(familiarVariant, languageCode)
        local ultraUpgrade = Localization:GetFamiliarUpgradeUltra(familiarVariant, languageCode)
        FamiliarDescription:AddDescriptionsForFamiliar(familiarVariant, superUpgrade, ultraUpgrade, nil, optionalName, languageCode)
    end
end

return Localization