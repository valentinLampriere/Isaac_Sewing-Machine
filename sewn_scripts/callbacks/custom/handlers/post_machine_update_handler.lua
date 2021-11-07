local Enums = require("sewn_scripts/core/enums")

local PostMachineUpdateHandler = { }

PostMachineUpdateHandler.ID = Enums.ModCallbacks.POST_MACHINE_UPDATE
PostMachineUpdateHandler.DefaultArguments = { -1, false }

-- Arguments :
-- 1 : Slot machine variant
-- 2 : is persitant ? (does the callback should be call when the machine is broken)
function PostMachineUpdateHandler:PostUpdate()
    for _, callback in ipairs(PostMachineUpdateHandler.RegisteredCallbacks) do
        local machines = Isaac.FindByType(EntityType.ENTITY_SLOT, callback.Argument[1], -1, true, false)
        for _, machine in ipairs(machines) do
            local _mData = machine:GetData()
            if callback.Argument[2] == true or _mData.Sewn_isMachineBroken ~= true then
                callback:Function(machine)
            end
        end
    end
end

return PostMachineUpdateHandler