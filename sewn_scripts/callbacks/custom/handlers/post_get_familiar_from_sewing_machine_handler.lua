local Enums = require("sewn_scripts.core.enums")

local PostGetFamiliarFromSewingMachineHandler = { }

PostGetFamiliarFromSewingMachineHandler.ID = Enums.ModCallbacks.POST_GET_FAMILIAR_FROM_SEWING_MACHINE

function PostGetFamiliarFromSewingMachineHandler:Evaluate(sewingMachine, player, familiar, newLevel)
    local mData = sewingMachine:GetData().SewingMachineData

    for _, callback in ipairs(PostGetFamiliarFromSewingMachineHandler.RegisteredCallbacks) do
        if callback.Argument[1] == nil or mData.Sewn_currentFamiliarVariant == callback.Argument[1] then
            callback:Function(familiar, player, sewingMachine, newLevel)
        end
    end
end

return PostGetFamiliarFromSewingMachineHandler