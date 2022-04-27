local Familiar = require("sewn_scripts.entities.familiar.familiar")
local CustomCallbacksHandler = require("sewn_scripts.callbacks.custom_callbacks_handler")

local function MC_POST_FAMILIAR_RENDER(_, familiar, offset)
    Familiar:RenderCrown(familiar)
    CustomCallbacksHandler:PostFamiliarRender(familiar, offset)
end

return MC_POST_FAMILIAR_RENDER