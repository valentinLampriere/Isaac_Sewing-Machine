local Enums = require("sewn_scripts.core.enums")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")

local PostMachineDestroyHandler = { }

PostMachineDestroyHandler.ID = Enums.ModCallbacks.POST_MACHINE_DESTROY
PostMachineDestroyHandler.DefaultArguments = { -1 }


local function RemoveRecentRewards(pos)
    for _, pickup in ipairs(Isaac.FindByType(5, -1, -1)) do
        if pickup.FrameCount <= 1 and pickup.SpawnerType == 0
        and pickup.Position:DistanceSquared(pos) <= 400 then
            pickup:Remove()
        end
    end

    for _, trollbomb in ipairs(Isaac.FindByType(4, -1, -1)) do
        if (trollbomb.Variant == 3 or trollbomb.Variant == 4)
        and trollbomb.FrameCount <= 1 and trollbomb.SpawnerType == 0
        and trollbomb.Position:DistanceSquared(pos) <= 400 then
            trollbomb:Remove()
        end
    end
end

local function OnMachineUpdate(_, machine)
    local _mData = machine:GetData()
    local shouldRemoveRewards = false
    for _, callback in ipairs(PostMachineDestroyHandler.RegisteredCallbacks) do
        if callback.Argument == -1 or machine.Variant == callback.Argument[1] then
            local asploded = machine.GridCollisionClass == EntityGridCollisionClass.GRIDCOLL_GROUND
            if asploded then
                shouldRemoveRewards = callback:Function(machine)
                _mData.Sewn_isMachineBroken = true
            end
        end
    end
    if shouldRemoveRewards then
        RemoveRecentRewards(machine.Position)
    end
end

function PostMachineDestroyHandler:Init()
    CustomCallbacks:AddCallback(Enums.ModCallbacks.POST_MACHINE_UPDATE, OnMachineUpdate)
end

return PostMachineDestroyHandler