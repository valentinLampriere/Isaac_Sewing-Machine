local Enums = require("sewn_scripts.core.enums")

local GetLoseCollectible = { }

GetLoseCollectible.ID = Enums.ModCallbacks.GET_LOSE_COLLECTIBLE

-- Argument 1 : [REQUIRED] the id of the collectible
-- Function(player, boolean), the boolean is true when the player pick the item, false when he lose it
function GetLoseCollectible:PeffectUpdate(player)
    local pData = player:GetData()

    if pData.Sewn_items == nil then
        pData.Sewn_items = { }
    end

    for _, callback in ipairs(GetLoseCollectible.RegisteredCallbacks) do
        if callback.Argument[1] ~= nil then
            local collectibleNum = player:GetCollectibleNum(callback.Argument[1]) 

            if pData.Sewn_items[callback.Argument[1]] ~= collectibleNum then
                if pData.Sewn_items[callback.Argument[1]] == nil then
                elseif pData.Sewn_items[callback.Argument[1]] < collectibleNum then
                    callback:Function(player, true)
                else
                    callback:Function(player, false)
                end
                pData.Sewn_items[callback.Argument[1]] = collectibleNum
            end
        end
    end
end

return GetLoseCollectible