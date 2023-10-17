local Globals = require("sewn_scripts.core.globals")

local AvailableFamiliarManager = { }

-- Store familiars which can be upgraded in the Sewing Machine
local availableFamiliars = { }

local collectibleToFamiliarVariantMap = { }

local function GetSpriteFromCollectibleId(collectibleId)
    local collectible = Isaac.GetItemConfig():GetCollectible(collectibleId)
    if collectible ~= nil then
        return collectible.GfxFileName
    end
end

function AvailableFamiliarManager:IterateOverAvailableFamiliars(_function)
    for familiarID, data in pairs(availableFamiliars) do
        _function(familiarID, data)
    end
end

function AvailableFamiliarManager:GetRandomAvailableFamiliars(rng, ...)
    local familiarsToExcludeList = {...}
    local familiarsToExcludeMap = { }

    for _, familiarToExclude in ipairs(familiarsToExcludeList) do
        familiarsToExcludeMap[familiarToExclude] = true
    end

    rng = rng or Globals.rng

    local availableFamiliarsList = { }
    for familiarID, data in pairs(availableFamiliars) do
        if familiarsToExcludeMap[familiarID] ~= true then
            table.insert(availableFamiliarsList, familiarID)
        end
    end

    local familiarsCount = #availableFamiliarsList
    local roll = rng:RandomInt(familiarsCount) + 1
    return availableFamiliarsList[roll]
end

function AvailableFamiliarManager:TryMakeFamiliarAvailable(familiarVariant, collectibleID, customSprite)
    if familiarVariant == nil then
        error("Can't make this familiar ("..familiarVariant..") available for Sewing Machine")
        return
    end
    
    local sprite

    if customSprite == nil then
        sprite = GetSpriteFromCollectibleId(collectibleID)
    else
        sprite = customSprite
    end
    
    availableFamiliars[familiarVariant] = { CollectibleID = collectibleID, Sprite = sprite}

    if collectibleToFamiliarVariantMap[collectibleID] == nil then
        collectibleToFamiliarVariantMap[collectibleID] = familiarVariant
    else
        if type(collectibleToFamiliarVariantMap[collectibleID]) ~= "table" then
            collectibleToFamiliarVariantMap[collectibleID] = { collectibleToFamiliarVariantMap[collectibleID] }
        end

        table.insert(collectibleToFamiliarVariantMap[collectibleID], familiarVariant)
    end
end
function AvailableFamiliarManager:IsFamiliarAvailable(familiarVariant)
    return availableFamiliars[familiarVariant] ~= nil
end
function AvailableFamiliarManager:GetFamiliarSprite(familiarVariant)
    local default = "gfx/items/collectibles/questionmark.png"
    if availableFamiliars[familiarVariant] ~= nil then
        return availableFamiliars[familiarVariant].Sprite or default
    end
    return default
end
function AvailableFamiliarManager:GetFamiliarCollectibleId(familiarVariant)
    if availableFamiliars[familiarVariant] ~= nil then
        return availableFamiliars[familiarVariant].CollectibleID or -1
    end
    return -1
end
function AvailableFamiliarManager:GetFamiliarFromCollectible(collectibleId)
    return collectibleToFamiliarVariantMap[collectibleId]
end
local function ReplaceDash(string)
    if string == nil then
        return
    end

    return string:gsub("-", " ")
end
function AvailableFamiliarManager:GetFamiliarName(familiarVariant, language)
    local familiarData = availableFamiliars[familiarVariant]
    local name = "???"

    if familiarData == nil then
        error("Can't find the name for a familiar ("..familiarVariant..") which has not been registered")
        return
    end

    local collectible = Isaac.GetItemConfig():GetCollectible(familiarData.CollectibleID)
    if collectible ~= nil then
        name = ReplaceDash(collectible.Name) or name
    end

    if EID ~= nil then
        local languageCode = language or EID:getLanguage() or "en_us"

        -- Vanilla items
        local eidDescription = EID.descriptions[languageCode].collectibles[familiarData.CollectibleID]
        if eidDescription ~= nil then
            name = ReplaceDash(eidDescription[2]) or name
        end

        -- Modded items
        local eidCustomDescription = EID.descriptions[languageCode].custom["5.100."..familiarData.CollectibleID]
        if eidCustomDescription ~= nil then
            name = ReplaceDash(eidCustomDescription[2]) or name
        end
    end

    return name
end

return AvailableFamiliarManager