local CustomCallbackHandler = require("sewn_scripts/callbacks/custom_callbacks_handler")

local function MC_POST_LASER_UPDATE(_, laser)
    CustomCallbackHandler:PostLaserUpdate(laser)
end

return MC_POST_LASER_UPDATE