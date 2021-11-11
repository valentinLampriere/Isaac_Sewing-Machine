local Enums = require("sewn_scripts.core.enums")
local MachineDataManager = require("sewn_scripts.core.machine_data_manager")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local PreAddFamiliarInSewingMachineHandler = { }

PreAddFamiliarInSewingMachineHandler.ID = Enums.ModCallbacks.PRE_ADD_FAMILIAR_IN_SEWING_MACHINE
PreAddFamiliarInSewingMachineHandler.DefaultArguments = { -1, Enums.FamiliarLevelFlag.FLAG_SUPER | Enums.FamiliarLevelFlag.FLAG_ULTRA }

function PreAddFamiliarInSewingMachineHandler:Evaluate(sewingMachine, familiar)
    for _, callback in ipairs(PreAddFamiliarInSewingMachineHandler.RegisteredCallbacks) do
        if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
            callback:Function(familiar, sewingMachine)
        end
    end
end

return PreAddFamiliarInSewingMachineHandler