local encyclopediaCollectibleLoaded = {}

function sewingMachineMod:SetEncyclopedia(familiarCollectibleId, familiarVariant)
    for i, item in pairs(Encyclopedia["itemsTable"].all) do
        if item.ItemId == familiarCollectibleId then
            sewingMachineMod:AddUpgradeToEncyclopedia(item.ItemId, item, familiarVariant)
            break
        end
    end
end
function sewingMachineMod:AddUpgradeToEncyclopedia(collectibleId, itemTab, familiarVariant)
    if itemTab == nil or encyclopediaCollectibleLoaded[collectibleId] ~= nil then return end

    local wiki = itemTab.WikiDesc
    
    local upSuper = "SUPER : #" .. sewingMachineMod.FamiliarsUpgradeDescriptions[familiarVariant].firstUpgrade
    local upUltra = "ULTRA : #" .. sewingMachineMod.FamiliarsUpgradeDescriptions[familiarVariant].secondUpgrade
    
    local wikiUpgrade = Encyclopedia.EIDtoWiki(upSuper .. "# #" .. upUltra, "Upgrade")
    local _wikiUpgrade = {}
    for i, text in pairs(wikiUpgrade[1]) do
        local str = text.str
        if i == 1 then -- Title
            table.insert(_wikiUpgrade, {str = str, fsize = 2, clr = 3, halign = 0})
        else -- All other lines
            for _, subtext in ipairs(Encyclopedia.fitTextToWidth(str, 1, 140)) do
                table.insert(_wikiUpgrade, {str = subtext})
            end
        end
    end

    table.insert(wiki, _wikiUpgrade)

    encyclopediaCollectibleLoaded[collectibleId] = true
end

sewingMachineMod.errFamiliars.Error()