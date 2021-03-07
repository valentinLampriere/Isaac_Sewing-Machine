local availableFamiliarId = {}
local encyclopediaLoaded = false

local function loadAvailableFamiliarId()
    for familiarVariant, familiarData in pairs(sewingMachineMod.availableFamiliar) do
        availableFamiliarId[familiarData[1]] = familiarVariant
    end
end
function sewingMachineMod:SetEncyclopedia()
    if encyclopediaLoaded == true then return end
    loadAvailableFamiliarId()
    for i, item in pairs(Encyclopedia["itemsTable"].all) do
        if availableFamiliarId[item.ItemId] ~= nil then
            sewingMachineMod:AddUpgradeToEncyclopedia(item.ItemId, item)
        end
    end
    encyclopediaLoaded = true
end
function sewingMachineMod:AddUpgradeToEncyclopedia(id, itemTab)
    local wiki = itemTab.WikiDesc
    if sewingMachineMod.FamiliarsUpgradeDescriptions[availableFamiliarId[id]] == nil then return end
    local upSuper = "SUPER : #" .. sewingMachineMod.FamiliarsUpgradeDescriptions[availableFamiliarId[id]].firstUpgrade
    local upUltra = "ULTRA : #" .. sewingMachineMod.FamiliarsUpgradeDescriptions[availableFamiliarId[id]].secondUpgrade
    --for _, text in pairs(Encyclopedia.fitTextToWidth(sewingMachineMod.FamiliarsUpgradeDescriptions[availableFamiliarId[id]].firstUpgrade, 1, 140)) do
    --    upSuper = upSuper .. "#" .. text
    --end
    --for _, text in pairs(Encyclopedia.fitTextToWidth(sewingMachineMod.FamiliarsUpgradeDescriptions[availableFamiliarId[id]].secondUpgrade, 1, 140)) do
    --    upUltra = upUltra ..  "#" .. text
    --end
    
    local wikiUpgrade = Encyclopedia.EIDtoWiki(upSuper .. "# #" .. upUltra, "Upgrade")
    local _wikiUpgrade = {}
    for i, text in pairs(wikiUpgrade[1]) do
        local str = text.str
        if i == 1 then -- Title
            table.insert(_wikiUpgrade, {str = str, fsize = 2, clr = 3, halign = 0})
        else
            for _, subtext in ipairs(Encyclopedia.fitTextToWidth(str, 1, 140)) do
                table.insert(_wikiUpgrade, {str = subtext})
            end
        end
    end

    --local wikiUpgrade = Encyclopedia.EIDtoWiki(upSuper .. "# #" .. upUltra, "Upgrade")
    table.insert(wiki, _wikiUpgrade)
end

sewingMachineMod.errFamiliars.Error()