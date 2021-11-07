local Enums = require("sewn_scripts.core.enums")

local GetLoseTrinket = { }

GetLoseTrinket.ID = Enums.ModCallbacks.GET_LOSE_TRINKET

-- Argument 1 : [REQUIRED] the id of the trinket
-- Function(player, boolean), the boolean is true when the player pick the item, false when he lose it
function GetLoseTrinket:PeffectUpdate(player)
    local pData = player:GetData()
    for _, callback in ipairs(GetLoseTrinket.RegisteredCallbacks) do
        if callback.Argument[1] ~= nil then
            local hasTrinket = player:HasTrinket(callback.Argument[1])
            if pData.Sewn_hasTrinket[callback.Argument[1]] ~= true and hasTrinket == true then
                callback:Function(player, true)
                pData.Sewn_hasTrinket[callback.Argument[1]] = true
            elseif pData.Sewn_hasTrinket[callback.Argument[1]] == true and hasTrinket ~= true then
                callback:Function(player, false)
                pData.Sewn_hasTrinket[callback.Argument[1]] = nil
            end
        end
    end
end

return GetLoseTrinket