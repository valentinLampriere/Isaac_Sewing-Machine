local encyclopediaCollectibleLoaded = {}
local encyclopedia_itemsTableAll = nil
local autogeneratedItems = {}


local function LoadItemsTableAll()
    encyclopedia_itemsTableAll = {}
    for i, item in pairs(Encyclopedia["itemsTable"].all) do
        encyclopedia_itemsTableAll[item.ItemId] = item
    end
end

if Encyclopedia ~= nil then
    -- Override Encyclopedia.AutogenerateUnknownItems to load generated items
    local OldAutogenerateUnknownItems = Encyclopedia.AutogenerateUnknownItems
    Encyclopedia.AutogenerateUnknownItems = function ()
        OldAutogenerateUnknownItems()
        LoadItemsTableAll()
        for familiarCollectibleId, familiarVariant in pairs(autogeneratedItems) do
            sewingMachineMod:SetEncyclopedia(familiarCollectibleId, familiarVariant)
        end
    end
end


function sewingMachineMod:SetEncyclopedia(familiarCollectibleId, familiarVariant)
    if encyclopedia_itemsTableAll == nil then
        LoadItemsTableAll()
    end

    if encyclopedia_itemsTableAll[familiarCollectibleId] ~= nil then
        sewingMachineMod:AddUpgradeToEncyclopedia(familiarCollectibleId, encyclopedia_itemsTableAll[familiarCollectibleId], familiarVariant)
    else -- Auto Generated items
        autogeneratedItems[familiarCollectibleId] = familiarVariant
    end
end
function sewingMachineMod:AddUpgradeToEncyclopedia(collectibleId, itemTab, familiarVariant)
    if itemTab == nil or itemTab.WikiDesc == nil or encyclopediaCollectibleLoaded[collectibleId] ~= nil then return end
    if sewingMachineMod.FamiliarsUpgradeDescriptions[familiarVariant] == nil or sewingMachineMod.FamiliarsUpgradeDescriptions[familiarVariant] == {} then return end

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