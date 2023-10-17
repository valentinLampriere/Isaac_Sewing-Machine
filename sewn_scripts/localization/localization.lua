local LocalizationCore = require("sewn_scripts.localization.localization_core")
local FamiliarDescription = require("sewn_scripts.mod_compat.eid.familiar_description")

local Localization = { }

Localization.TextKey = {
    Upgradable = 1
}

local function GetLanguageCode()
    return EID ~= nil and EID:getLanguage() or "en_us"
end

function Localization:ForEachLanguage(_function)
    for languageCode, textsData in pairs(LocalizationCore.AvailableLanguages) do
        _function(languageCode)
    end
end

local function HandleLanguageCodeError(languageCode)
    if languageCode == nil then
        error("The given languageCode is nil.")
        return;
    end

    if LocalizationCore.AvailableLanguages[languageCode] == nil then
        error("The language with tag \"".. languageCode .."\" isn't registered.")
        return;
    end
end

------------------------
----- Collectibles -----
------------------------
local function GetCollectible(collectibleId, languageCode)
    HandleLanguageCodeError(languageCode)

    local index = LocalizationCore.CollectiblesIdToIndex[collectibleId]
    return LocalizationCore.AvailableLanguages[languageCode].Items[index]
end

function Localization:GetCollectiblesNum(languageCode)
    HandleLanguageCodeError(languageCode)
    return #LocalizationCore.AvailableLanguages[languageCode].Items
end

function Localization:GetCollectibleId(index)
    return LocalizationCore.CollectiblesIndexToId[index]
end

function Localization:GetCollectibleName(collectibleId, languageCode)
    return GetCollectible(collectibleId, languageCode)[1]
end

function Localization:GetCollectibleDescription(collectibleId, languageCode)
    return GetCollectible(collectibleId, languageCode)[2]
end

--------------------
----- Trinkets -----
--------------------
local function GetTrinket(trinketId, languageCode)
    HandleLanguageCodeError(languageCode)

    local index = LocalizationCore.TrinketsIdToIndex[trinketId]
    return LocalizationCore.AvailableLanguages[languageCode].Trinkets[index]
end

function Localization:GetTrinketsNum(languageCode)
    HandleLanguageCodeError(languageCode)
    return #LocalizationCore.AvailableLanguages[languageCode].Trinkets
end

function Localization:GetTrinketId(index)
    return LocalizationCore.TrinketsIndexToId[index]
end

function Localization:GetTrinketName(trinketId, languageCode)
    return GetTrinket(trinketId, languageCode)[1]
end

function Localization:GetTrinketDescription(trinketId, languageCode)
    return GetTrinket(trinketId, languageCode)[2]
end

-----------------
----- Cards -----
-----------------
local function GetCard(cardId, languageCode)
    HandleLanguageCodeError(languageCode)

    local index = LocalizationCore.CardsIdToIndex[cardId]
    return LocalizationCore.AvailableLanguages[languageCode].Cards[index]
end
function Localization:GetCardsNum(languageCode)
    HandleLanguageCodeError(languageCode)
    return #LocalizationCore.AvailableLanguages[languageCode].Cards
end

function Localization:GetCardId(index)
    return LocalizationCore.CardsIndexToId[index]
end

function Localization:GetCardName(cardId, languageCode)
    return GetCard(cardId, languageCode)[1]
end

function Localization:GetCardDescription(cardId, languageCode)
    return GetCard(cardId, languageCode)[2]
end


------------------------------
----- Familiars Upgrades -----
------------------------------
local function GetFamiliarUpgrade(familiarVariant, languageCode)
    HandleLanguageCodeError(languageCode)

    local index = LocalizationCore.FamiliarsUpgradesVariantToIndex[familiarVariant]
    local familiarData = LocalizationCore.AvailableLanguages[languageCode].FamiliarUpgrades[index]

    if familiarData == nil then
        -- Missing Data?
        return ""
    end

    if type(familiarData[1]) == "string" then
        return familiarData
    elseif type(familiarData[1]) == "table" then
        if REPENTANCE then
            return familiarData[1]
        else
            return familiarData[2]
        end
    elseif type(familiarData[1]) == "nil" then
        -- This is nil when a description is missing.
        -- This might happen when the description exists, but is missing in a particular language.
        -- In that language the data is "nil", while it has a value in other languages.
        return ""
    end

    error("Can't find the upgrade descriptions for this familiar : " .. familiarVariant)
end

function Localization:GetFamiliarUpgradesNum(languageCode)
    HandleLanguageCodeError(languageCode)
    return #LocalizationCore.AvailableLanguages[languageCode].FamiliarUpgrades
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

----------------
----- Misc -----
----------------
function Localization:GetText(textKey, languageCode)
    languageCode = languageCode or GetLanguageCode()
    
    HandleLanguageCodeError(languageCode)

    return LocalizationCore.AvailableLanguages[languageCode].Misc[textKey]
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