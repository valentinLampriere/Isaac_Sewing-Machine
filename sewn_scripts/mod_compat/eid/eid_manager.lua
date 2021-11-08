---@diagnostic disable: undefined-global
local AvailableFamiliarManager = require("sewn_scripts.core.available_familiars_manager")

local EIDManager = { }

local isEidLoaded = false

function EIDManager:SetEIDForEntity(entity, name, description)
    local data = entity:GetData()
    data.EID_Description = {
        Name = name,
        Description = description
    }
end
function EIDManager:ResetEIDForEntity(entity)
    local data = entity:GetData()
    data.EID_Description = nil
end

function EIDManager:AddIndicatorOnCollectibleDesciptions()
    if EID == nil or isEidLoaded then
        return
    end

    local crownSprite = Sprite()
    crownSprite:Load("gfx/sewn_familiar_crown.anm2", false)
    crownSprite:LoadGraphics()

    EID:addIcon("FamiliarUpgradable", "DescrSuper", 0, 15, 12, 8, 6, crownSprite)
    EID:addIcon("SewnCrownSuper", "Super", 0, 12, 9, 1, 10, crownSprite)
    EID:addIcon("SewnCrownUltra", "Ultra", 0, 12, 9, 1, 10, crownSprite)

    AvailableFamiliarManager:IterateOverAvailableFamiliars(function(familiarVariant, data)
        local collectibleID = data.CollectibleID
        local additionalDescr = "#{{SewnCrownSuper}} Upgradable"
        
        -- Old EID support
        if __eidItemDescriptions ~= nil and __eidItemDescriptions[collectibleID] ~= nil then
            __eidItemDescriptions[collectibleID] = string.gsub(__eidItemDescriptions[collectibleID], additionalDescr, "")
        else
            for key, data in pairs(EID.descriptions) do
                if data.collectibles[collectibleID] ~= nil then -- Vanilla items
                    data.collectibles[collectibleID][3] = data.collectibles[collectibleID][3] .. additionalDescr
                elseif data.custom["5.100." .. collectibleID] ~= nil then -- Modded items
                    data.custom["5.100." .. collectibleID][3] = data.custom["5.100." .. collectibleID][3] .. additionalDescr
                end
            end
        end
    end)

    isEidLoaded = true
end

return EIDManager