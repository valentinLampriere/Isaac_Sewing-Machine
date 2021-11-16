local SewingBox = require("sewn_scripts.items.active.sewing_box")
local SacrificialAltar = require("sewn_scripts.items.active.sacrificial_altar")

local function MC_USE_ITEM(_, collectibleType, rng)
    local r = nil
    r = r or SewingBox:OnUseItem(collectibleType, rng)
    r = r or SacrificialAltar:OnUseItem(collectibleType, rng)
    return r
end

return MC_USE_ITEM
