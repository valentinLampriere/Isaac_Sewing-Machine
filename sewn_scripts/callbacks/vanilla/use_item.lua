local SewingBox = require("sewn_scripts.items.active.sewing_box")

local function MC_USE_ITEM(_, collectibleType, rng)
    return SewingBox:OnUseItem(collectibleType, rng)
end

return MC_USE_ITEM
