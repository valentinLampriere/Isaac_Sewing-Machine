local CustomCallbacksHandler = require("sewn_scripts/callbacks/custom_callbacks_handler")

local function MC_POST_PEFFECT_UPDATE(_, player)
    CustomCallbacksHandler:PeffectUpdate(player)
end

return MC_POST_PEFFECT_UPDATE
