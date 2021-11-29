local AvailableFamiliarManager = require("sewn_scripts.core.available_familiars_manager")
local FamiliarDescription = require("sewn_scripts.mod_compat.eid.familiar_description")

local EncyclopediaUpgrades = { }

-- Store the index of the "Upgrade" section for each collectibles which have an "Upgrade" section
local indexUpgradeSectionForCollectibleWiki = { }
-- Store all wiki items with their id as a key
local encyclopediaMap = nil


local function MapEncyclopedia()
    encyclopediaMap = { }
    for i, item in pairs(Encyclopedia["itemsTable"].all) do
        encyclopediaMap[item.ItemId] = item
    end
end

local function ToUpgrade(text, title)
    if text == nil then return end
    local encyclopediaUpgrade = { }
    local encyclopediaText = Encyclopedia.EIDtoWiki(text, title)

    for i, data in pairs(encyclopediaText[1]) do
        if i == 1 then -- Title
            table.insert(encyclopediaUpgrade, {str = ""})
            table.insert(encyclopediaUpgrade, {str = data.str, fsize = data.fsize, clr = data.clr})
            table.insert(encyclopediaUpgrade, {str = ""})
        else -- Other lines
            for _, subtext in ipairs(Encyclopedia.fitTextToWidth(data.str, 1, 140)) do
                table.insert(encyclopediaUpgrade, {str = subtext, fsize = data.fsize, clr = data.clr, halign = data.halign})
            end
        end
    end

    return table.unpack({encyclopediaUpgrade})
end

local function GetEIDSuper(familiarID)
    return FamiliarDescription:GetInfoForFamiliar(familiarID).SuperUpgrade
end
local function GetEIDUltra(familiarID)
    return FamiliarDescription:GetInfoForFamiliar(familiarID).UltraUpgrade
end

function EncyclopediaUpgrades:AddEncyclopediaUpgrade(familiarID, superUpgradeText, ultraUpgradeText, notesUpgradeText, overrideWiki)
    if overrideWiki == nil then overrideWiki = true end
    local collectibleID = AvailableFamiliarManager:GetFamiliarCollectibleId(familiarID)

    if collectibleID == nil then
        return
    end
    
    if Encyclopedia == nil or Encyclopedia.itemsTable.all[collectibleID] == nil then
        return
    end

    if encyclopediaMap == nil then
        MapEncyclopedia()
    end

    local wikiDesc = encyclopediaMap[collectibleID].WikiDesc
    
    if indexUpgradeSectionForCollectibleWiki[collectibleID] ~= nil then
        if overrideWiki == false then
            return
        end
        -- Remove the previous upgrade section
        wikiDesc[indexUpgradeSectionForCollectibleWiki[collectibleID]] = nil
        indexUpgradeSectionForCollectibleWiki[collectibleID] = nil
    end

    if superUpgradeText == nil then
        superUpgradeText = GetEIDSuper(familiarID)
    end
    if ultraUpgradeText == nil then
        ultraUpgradeText = GetEIDUltra(familiarID)
    end

    local _wikiUpgrade = { }
    local superWiki = ToUpgrade(superUpgradeText, "Super")
    local ultraWiki = ToUpgrade(ultraUpgradeText, "Ultra")
    local notesWiki = ToUpgrade(notesUpgradeText, "Notes") or {}

    -- Add the title "Upgrades"
    table.insert(_wikiUpgrade, {str = "Upgrades", fsize = 3, clr = 3, halign = 0})
    
    -- Add Super upgrade
    for i, data in pairs(superWiki) do
        table.insert(_wikiUpgrade, {str = data.str, fsize = data.fsize, clr = data.clr, halign = data.halign})
    end
    -- Add Ultra upgrade
    for i, data in pairs(ultraWiki) do
        table.insert(_wikiUpgrade, {str = data.str, fsize = data.fsize, clr = data.clr, halign = data.halign})
    end
    -- Add Ultra upgrade
    for i, data in pairs(notesWiki) do
        table.insert(_wikiUpgrade, {str = data.str, fsize = data.fsize, clr = data.clr, halign = data.halign})
    end

    table.insert(wikiDesc, _wikiUpgrade)

    indexUpgradeSectionForCollectibleWiki[collectibleID] = #wikiDesc
end

return EncyclopediaUpgrades