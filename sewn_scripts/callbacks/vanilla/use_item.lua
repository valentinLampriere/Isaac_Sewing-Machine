local SewingBox = require("sewn_scripts.items.active.sewing_box")
local SacrificialAltar = require("sewn_scripts.items.active.sacrificial_altar")
local BoxOfFriends = require("sewn_scripts.items.active.box_of_friends")
local MonsterManual = require("sewn_scripts.items.active.monster_manual")
local GlowingHourglass = require("sewn_scripts.items.active.glowing_hourglass")

local function MC_USE_ITEM(_, collectibleType, rng)
    local r = nil
    r = r or SewingBox:OnUseItem(collectibleType, rng)
    r = r or SacrificialAltar:OnUseItem(collectibleType, rng)
    r = r or BoxOfFriends:OnUseItem(collectibleType, rng)
    r = r or MonsterManual:OnUseItem(collectibleType, rng)
    r = r or GlowingHourglass:OnUseItem(collectibleType, rng)
    return r
end

return MC_USE_ITEM
