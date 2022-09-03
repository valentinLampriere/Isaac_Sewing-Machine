local FamiliarDescription = require("sewn_scripts.mod_compat.eid.familiar_description")
local Enums = require("sewn_scripts.core.enums")
local EIDManager = require("sewn_scripts.mod_compat.eid.eid_manager")

local SewingMachineDescription = { }

function SewingMachineDescription:SetMachineDescription(machine)
    local mData = machine:GetData().SewingMachineData
    local description = SewingMachineDescription:GetMachineDescription(machine)

    if description ~= nil then
        EIDManager:SetEIDForEntity(machine, description.Name, description.Description)
    end
    mData.EID_Description = description
end
function SewingMachineDescription:ResetMachineDescription(machine)
    EIDManager:ResetEIDForEntity(machine)
end

function SewingMachineDescription:GetMachineDescription(machine)
    local mData = machine:GetData().SewingMachineData

    if mData.Sewn_currentFamiliarVariant == nil then
        return
    end

    local info = FamiliarDescription:GetInfoForFamiliar(mData.Sewn_currentFamiliarVariant)

    -- No description for the familiar
    if info == nil then return end

    local upgradeDescription = mData.Sewn_currentFamiliarLevel == Enums.FamiliarLevel.NORMAL and info.SuperUpgrade or info.UltraUpgrade
    local levelCrown = mData.Sewn_currentFamiliarLevel == Enums.FamiliarLevel.NORMAL and "Super" or "Ultra"

    local colorMarkup = "{{ColorWhite}}"
    if EID and EID.InlineColors["SewnColor_"..info.Name] then
        colorMarkup = "{{SewnColor_"..info.Name .. "}}"
    end

    return {
        Name = colorMarkup .. "{{Crown" .. levelCrown .. "}}" .. info.Name .." {{SewingMachine}}",
        Description = upgradeDescription
    }
end

return SewingMachineDescription