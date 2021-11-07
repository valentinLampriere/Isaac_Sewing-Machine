local CustomCallbackHandler = require("sewn_scripts/callbacks/custom_callbacks_handler")

local function MC_POST_TEAR_UPDATE(_, tear)
    CustomCallbackHandler:PostTearUpdate(tear)
end

return MC_POST_TEAR_UPDATE