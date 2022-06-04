local Player = require("sewn_scripts.entities.player.player")
local DollTaintedHead = require("sewn_scripts.items.passive.doll_tainted_head")
local DollPureBody = require("sewn_scripts.items.passive.doll_pure_body")
local SewnDoll = require("sewn_scripts.items.passive.sewn_doll")
local CustomCallbacksHandler = require("sewn_scripts.callbacks.custom_callbacks_handler")
local HolyFart = require("sewn_scripts.entities.effects.holy_fart")

local function MC_EVALUATE_CACHE(_, player, cacheFlag)
    Player:OnEvaluateCache(player, cacheFlag)
    DollTaintedHead:OnEvaluateCache(player, cacheFlag)
    DollPureBody:OnEvaluateCache(player, cacheFlag)
    SewnDoll:OnEvaluateCache(player, cacheFlag)
    CustomCallbacksHandler:EvaluateCache(player, cacheFlag)
    HolyFart:EvaluateCache(player, cacheFlag)
end

return MC_EVALUATE_CACHE
