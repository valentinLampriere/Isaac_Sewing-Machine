local Pickup = require("sewn_scripts.items.pickups.pickup")

local function MC_POST_PICKUP_INIT(_, pickup)
    Pickup:OnInit(pickup)
end

return MC_POST_PICKUP_INIT
