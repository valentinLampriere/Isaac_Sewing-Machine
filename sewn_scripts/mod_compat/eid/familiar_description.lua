local AvailableFamiliarManager = require("sewn_scripts.core.available_familiars_manager")

local FamiliarDescription = { }

local familiarsUpgradeDescriptions = { }

function FamiliarDescription:GetInfoForFamiliar(familiarVariant)
    return familiarsUpgradeDescriptions[familiarVariant]
end

function FamiliarDescription:AddDescriptionsForFamiliar(familiarVariant, firstUpgrade, secondUpgrade, color, optionalName)
    local kColor
    local name = optionalName or AvailableFamiliarManager:GetFamiliarName(familiarVariant)

    if color ~= nil then
        kColor = {color[1], color[2], color[3]}
    else
        kColor = {1, 1, 1}
    end
    --[[if sewingMachineMod.Config.EID_textColored == false then
        kColor = {1, 1, 1}
    end--]]

    if EID ~= nil then
        local markupName = name.gsub(name, "'", "")
        EID:addColor("SewnColor_".. markupName, KColor(kColor[1], kColor[2], kColor[3], 1))
    end

    familiarsUpgradeDescriptions[familiarVariant] = {
        Name = name,
        SuperUpgrade = firstUpgrade,
        UltraUpgrade = secondUpgrade,
        Color = kColor
    }

    --[[if Encyclopedia ~= nil then
        sewingMachineMod:SetEncyclopedia(sewingMachineMod.availableFamiliar[familiarVariant][1], familiarVariant)
    end--]]
end

return FamiliarDescription