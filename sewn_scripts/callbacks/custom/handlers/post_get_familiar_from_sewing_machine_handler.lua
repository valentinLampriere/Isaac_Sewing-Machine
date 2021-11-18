local Enums = require("sewn_scripts.core.enums")

local PostGetFamiliarFromSewingMachineHandler = { }

PostGetFamiliarFromSewingMachineHandler.ID = Enums.ModCallbacks.POST_GET_FAMILIAR_FROM_SEWING_MACHINE

function PostGetFamiliarFromSewingMachineHandler:Evaluate(sewingMachine, player, familiar, isUpgraded, newLevel)
    local mData = sewingMachine:GetData().SewingMachineData
    local preventExplosion = false
    for _, callback in ipairs(PostGetFamiliarFromSewingMachineHandler.RegisteredCallbacks) do
        if callback.Argument[1] == nil or mData.Sewn_currentFamiliarVariant == callback.Argument[1] then
            preventExplosion = callback:Function(familiar, player, sewingMachine, isUpgraded, newLevel) or preventExplosion
        end
    end
    return preventExplosion
end

return PostGetFamiliarFromSewingMachineHandler