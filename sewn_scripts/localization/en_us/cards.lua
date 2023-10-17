--- -- Name of the card in english, do not change it!
--- {
---     "Card Name",
---     "Description of the card effect",
--- }

local Icons = require("sewn_scripts.localization.localization_helpers")

local cards = {
    -- Warranty Card
    {
        "Warranty Card",
        "Spawns a sewing machine#The Sewing machine change depending on the room type"
    },
    
    -- Stitching Card
    {
        "Stitching Card",
        "Rerolls familiar crowns#Gives a free upgrades if none of your familiars are upgraded"
    },
    
    -- Sewing Coupon
    {
        "Sewing Coupon",
        "Upgrade all familiars for a single room#One time use of Sewing Box " .. Icons.SewingBox
    },
}

return cards