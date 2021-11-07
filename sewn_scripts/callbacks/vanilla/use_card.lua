local WarrantyCard = require("sewn_scripts.items.cards.warranty_card")
local StitchingCard = require("sewn_scripts.items.cards.stitching_card")
local SewingCoupon = require("sewn_scripts.items.cards.sewing_coupon")

local function MC_USE_CARD(_, card, player, useFlag)
    WarrantyCard:OnUse(card, player, useFlag)
    StitchingCard:OnUse(card, player, useFlag)
    SewingCoupon:OnUse(card, player, useFlag)
end

return MC_USE_CARD
