local Enums = require("sewn_scripts.core.enums")
local PreAddFamiliarInSewingMachineHandler = { }

PreAddFamiliarInSewingMachineHandler.ID = Enums.ModCallbacks.PRE_ADD_FAMILIAR_IN_SEWING_MACHINE
PreAddFamiliarInSewingMachineHandler.DefaultArguments = { -1 }

function PreAddFamiliarInSewingMachineHandler:Evaluate(sewingMachine, familiar)
    for _, callback in ipairs(PreAddFamiliarInSewingMachineHandler.RegisteredCallbacks) do
        if callback.Argument[1] == -1 or callback.Argument[1] == familiar.Variant then
            callback:Function(familiar, sewingMachine)
        end
    end
end

return PreAddFamiliarInSewingMachineHandler