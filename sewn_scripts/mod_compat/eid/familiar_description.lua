local AvailableFamiliarManager = require("sewn_scripts.core.available_familiars_manager")

local FamiliarDescription = { }

local familiarsUpgradeDescriptions = { }

function FamiliarDescription:GetInfoForFamiliar(familiarVariant, language)
    language = language or EID and EID:getLanguage() or "en_us"
    local familiarUpgradeDescription = familiarsUpgradeDescriptions[familiarVariant]
    if familiarUpgradeDescription == nil then
        return
    end
    return familiarsUpgradeDescriptions[familiarVariant][language]
end

function FamiliarDescription:AddDescriptionsForFamiliar(familiarVariant, firstUpgrade, secondUpgrade, color, optionalName, language)
    if familiarVariant == nil then
        error("Can't Add descriptions for familiar with nil variant")
    end

    local kColor
    language = language or "en_us"
    local name = optionalName or AvailableFamiliarManager:GetFamiliarName(familiarVariant, language)
    if color ~= nil then
        kColor = {color[1], color[2], color[3]}
    else
        kColor = {1, 1, 1}
    end

    if EID ~= nil then
        local markupName = name.gsub(name, "'", "")
        EID:addColor("SewnColor_".. markupName, KColor(kColor[1], kColor[2], kColor[3], 1))
    end

    if familiarsUpgradeDescriptions[familiarVariant] == nil then
        familiarsUpgradeDescriptions[familiarVariant] = { }
    end

    familiarsUpgradeDescriptions[familiarVariant][language] = {
        Name = name,
        SuperUpgrade = firstUpgrade,
        UltraUpgrade = secondUpgrade,
        Color = kColor
    }

    if language == "en_us" then
        Sewn_API:AddEncyclopediaUpgrade(familiarVariant, firstUpgrade, secondUpgrade, nil, false)
    end
end

return FamiliarDescription