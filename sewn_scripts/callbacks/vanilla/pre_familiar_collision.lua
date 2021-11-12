local CustomCallbacksHandler = require("sewn_scripts.callbacks.custom_callbacks_handler")

local function MC_PRE_FAMILIAR_COLLISION(_, familiar, collider, low)
    CustomCallbacksHandler:PreFamiliarCollision(familiar, collider, low)
end

return MC_PRE_FAMILIAR_COLLISION
