local Globals = require("sewn_scripts/core/globals")

local GetPlayerUsingItem = function(_)
    local player = Isaac.GetPlayer(0)
    for i = 1, Game():GetNumPlayers() do
        local p = Isaac.GetPlayer(i - 1)
         if Input.IsActionTriggered(ButtonAction.ACTION_ITEM, p.ControllerIndex) or Input.IsActionTriggered(ButtonAction.ACTION_PILLCARD, p.ControllerIndex) then
            player = p
            break
        end
    end
    return player
end

return GetPlayerUsingItem