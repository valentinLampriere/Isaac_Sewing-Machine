local Player = require("sewn_scripts/entities/player/player")

local function MC_POST_PLAYER_INIT(_, player)
    Player:Init(player)
end

return MC_POST_PLAYER_INIT
