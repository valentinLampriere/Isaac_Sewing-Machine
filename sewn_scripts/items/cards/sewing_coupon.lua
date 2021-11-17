local Enums = require("sewn_scripts.core.enums")

local SewingCoupon = { }

function SewingCoupon:OnUse(card, player, useFlags)
    if card ~= Enums.Card.CARD_SEWING_COUPON then
        return
    end
    
    player:UseActiveItem(Enums.CollectibleType.COLLECTIBLE_SEWING_BOX, UseFlag.USE_NOANIM)
end

return SewingCoupon