local Enums = require("sewn_scripts.core.enums")

local SewingCoupon = { }

SewingCoupon.ID = Enums.Card.CARD_SEWING_COUPON
SewingCoupon.SpawnChance = 1.2

function SewingCoupon:OnUse(card, player, useFlags)
    if card ~= SewingCoupon.ID then
        return
    end
    
    player:UseActiveItem(Enums.CollectibleType.COLLECTIBLE_SEWING_BOX, UseFlag.USE_NOANIM)
end

return SewingCoupon