local Player = require("sewn_scripts.entities.player.player")

local function MC_EVALUATE_CACHE(_, player, cacheFlag)
    Player:OnEvaluateCache(player, cacheFlag)
end

return MC_EVALUATE_CACHE
