local WarrantyCard = require("sewn_scripts.items.cards.warranty_card")
local StitchingCard = require("sewn_scripts.items.cards.stitching_card")
local SewingCoupon = require("sewn_scripts.items.cards.sewing_coupon")
local ReversedTheDevil = require("sewn_scripts.items.cards.reversed_the_devil")
local GetPlayerUsingItem = require("sewn_scripts.helpers.get_player_using_item")

local function MC_USE_CARD(_, card, player, useFlag)
    -- MC_USE_CARD gives only a single argument "card" in AB+
    -- Setting those to the default value to prevent bugs
    player = player or GetPlayerUsingItem()
    useFlag = useFlag or 0
    WarrantyCard:OnUse(card, player, useFlag)
    StitchingCard:OnUse(card, player, useFlag)
    SewingCoupon:OnUse(card, player, useFlag)
    ReversedTheDevil:OnUse(card, player, useFlag)
end

return MC_USE_CARD
