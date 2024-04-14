local CustomCallbacksHandler = require("sewn_scripts.callbacks.custom_callbacks_handler")
local TainedLazarus = require("sewn_scripts.entities.player.tainted_lazarus")
local Player = require("sewn_scripts.entities.player.player")

local function MC_POST_PEFFECT_UPDATE(_, player)
    CustomCallbacksHandler:PeffectUpdate(player)
    TainedLazarus:OnPlayerUpdate(player)
    Player:SetIsCloseFromMachine(player)
end

return MC_POST_PEFFECT_UPDATE
