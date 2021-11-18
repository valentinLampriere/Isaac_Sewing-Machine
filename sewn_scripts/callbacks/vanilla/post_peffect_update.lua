local CustomCallbacksHandler = require("sewn_scripts.callbacks.custom_callbacks_handler")
local TainedLazarus = require("sewn_scripts.entities.player.tainted_lazarus")
local PinCushion = require("sewn_scripts.items.trinkets.pin_cushion")

local function MC_POST_PEFFECT_UPDATE(_, player)
    CustomCallbacksHandler:PeffectUpdate(player)
    TainedLazarus:OnPlayerUpdate(player)
    PinCushion:PlayerUpdate(player)
end

return MC_POST_PEFFECT_UPDATE
