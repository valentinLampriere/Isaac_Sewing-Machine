local Enums = require("sewn_scripts/core/enums")
local MachineDataManager = require("sewn_scripts/core/machine_data_manager")

local PostGetFamiliarFromSewingMachineHandler = { }

PostGetFamiliarFromSewingMachineHandler.ID = Enums.ModCallbacks.POST_GET_FAMILIAR_FROM_SEWING_MACHINE

function PostGetFamiliarFromSewingMachineHandler:Evaluate(sewingMachine, player, familiar)
    local mData = MachineDataManager:GetMachineData(sewingMachine)

    for _, callback in ipairs(PostGetFamiliarFromSewingMachineHandler.RegisteredCallbacks) do
        if callback.Argument[1] == nil or mData.Sewn_currentFamiliarVariant == callback.Argument[1] then
            callback:Function(sewingMachine, player, mData.Sewn_currentFamiliarVariant, familiar)
        end
    end
end

return PostGetFamiliarFromSewingMachineHandler