local CustomCallbackHandler = require("sewn_scripts.callbacks.custom_callbacks_handler")

local function MC_PRE_TEAR_COLLISION(_, tear, collider, low)
    return CustomCallbackHandler:PreTearCollision(tear, collider)
end

return MC_PRE_TEAR_COLLISION
