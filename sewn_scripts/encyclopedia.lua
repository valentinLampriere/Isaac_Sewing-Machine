local availableFamiliarId = {}

local function loadAvailableFamiliarId()
    for familiarVariant, familiarData in pairs(sewingMachineMod.availableFamiliar) do
        availableFamiliarId[familiarData[1]] = familiarVariant
    end
end
function sewingMachineMod:SetEncyclopedia()
    for i, item in pairs(Encyclopedia["itemsTable"].all) do
        if availableFamiliarId[item.ItemId] ~= nil then
            sewingMachineMod:AddUpgradeToEncyclopedia(item.ItemId, item.WikiDesc)
        end
    end
end
function sewingMachineMod:AddUpgradeToEncyclopedia(id, itemWiki)
    local wiki = itemWiki
    if sewingMachineMod.FamiliarsUpgradeDescriptions[availableFamiliarId[id]] == nil then return end
    local upSuper = "SUPER : #" .. sewingMachineMod.FamiliarsUpgradeDescriptions[availableFamiliarId[id]].firstUpgrade
    local upUltra = "ULTRA : # " .. sewingMachineMod.FamiliarsUpgradeDescriptions[availableFamiliarId[id]].secondUpgrade

    local wikiUpgrade = Encyclopedia.EIDtoWiki(upSuper .. "#" .. upUltra, "Upgrade")
    table.insert(wiki, wikiUpgrade[1])
end

loadAvailableFamiliarId()

sewingMachineMod.errFamiliars.Error()