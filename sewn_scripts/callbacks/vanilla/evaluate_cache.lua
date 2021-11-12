local Player = require("sewn_scripts.entities.player.player")
local DollsTaintedHead = require("sewn_scripts.items.passive.doll_tainted_head")
local DollsPureBody = require("sewn_scripts.items.passive.doll_pure_body")
local SewnDoll = require("sewn_scripts.items.passive.sewn_doll")
local CustomCallbacksHandler = require("sewn_scripts.callbacks.custom_callbacks_handler")

local function MC_EVALUATE_CACHE(_, player, cacheFlag)
    Player:OnEvaluateCache(player, cacheFlag)
    DollsTaintedHead:OnEvaluateCache(player, cacheFlag)
    DollsPureBody:OnEvaluateCache(player, cacheFlag)
    SewnDoll:OnEvaluateCache(player, cacheFlag)
    CustomCallbacksHandler:EvaluateCache(player, cacheFlag)
end

return MC_EVALUATE_CACHE
