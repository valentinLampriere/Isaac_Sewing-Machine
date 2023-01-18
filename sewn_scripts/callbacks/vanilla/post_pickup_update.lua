local Pickup = require("sewn_scripts.items.pickups.pickup")

local function MC_POST_PICKUP_UPDATE(_, pickup)
    Pickup:OnUpdate(pickup)
end

return MC_POST_PICKUP_UPDATE
