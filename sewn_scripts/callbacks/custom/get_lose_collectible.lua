local Player = require("sewn_scripts/entities/player/player")

local GetLoseCollectible = { }

function GetLoseCollectible:LilDelirium(player, getCollectible)
    if getCollectible == true then
        Player:GetLilDelirium(player)
    end
end

return GetLoseCollectible
