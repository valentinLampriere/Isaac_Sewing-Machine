local Pickup = require("sewn_scripts.items.pickups.pickup")

local function MC_PRE_PICKUP_COLLISION(_, pickup, collider, low)
    return Pickup:OnCollision(pickup, collider, low)
end

return MC_PRE_PICKUP_COLLISION
