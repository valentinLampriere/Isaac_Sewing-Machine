local Enums = require("sewn_scripts/core/enums")
local Globals = require("sewn_scripts/core/globals")
local CustomCallbacks = require("sewn_scripts/callbacks/custom_callbacks")

local PostPlayerTouchMachineHandler = { }

PostPlayerTouchMachineHandler.ID = Enums.ModCallbacks.POST_PLAYER_TOUCH_MACHINE
PostPlayerTouchMachineHandler.DefaultArguments = { -1 }

local function OnMachineUpdate(_, machine)
    for _, callback in ipairs(PostPlayerTouchMachineHandler.RegisteredCallbacks) do
        if callback.Argument[1] == PostPlayerTouchMachineHandler.DefaultArguments[1] or machine.Variant == callback.Argument[1] then
            for i = 1, Globals.game:GetNumPlayers() do
                local player = Isaac.GetPlayer(i - 1)
                if (machine.Position - player.Position):LengthSquared() < (machine.Size + player.Size) ^ 2 then
                    callback:Function(player, machine)
                end
            end
        end
    end
end

function PostPlayerTouchMachineHandler:Init()
    CustomCallbacks:AddCallback(Enums.ModCallbacks.POST_MACHINE_UPDATE, OnMachineUpdate)
end

return PostPlayerTouchMachineHandler