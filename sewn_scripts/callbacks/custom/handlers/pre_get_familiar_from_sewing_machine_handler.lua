local Enums = require("sewn_scripts/core/enums")
local MachineDataManager = require("sewn_scripts/core/machine_data_manager")

local PreGetFamiliarFromSewingMachineHandler = { }

PreGetFamiliarFromSewingMachineHandler.ID = Enums.ModCallbacks.PRE_GET_FAMILIAR_FROM_SEWING_MACHINE

function PreGetFamiliarFromSewingMachineHandler:Evaluate(sewingMachine, player, isUpgrade)
    local mData = MachineDataManager:GetMachineData(sewingMachine)

    local preventUpgrade

    for _, callback in ipairs(PreGetFamiliarFromSewingMachineHandler.RegisteredCallbacks) do
        if callback.Argument[1] == nil or mData.Sewn_currentFamiliarVariant == callback.Argument[1] then
            local _preventUpgrade = callback:Function(sewingMachine, player, mData.Sewn_currentFamiliarVariant, mData.Sewn_currentFamiliarLevel, isUpgrade)
            if _preventUpgrade == true then
                preventUpgrade = _preventUpgrade
            end
        end
    end
    return preventUpgrade
end

return PreGetFamiliarFromSewingMachineHandler