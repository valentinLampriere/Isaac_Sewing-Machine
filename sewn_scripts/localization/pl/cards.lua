--- -- Name of the card in english, do not change it!
--- {
---     "Card Name",
---     "Description of the card effect",
--- }


local Icons = require("sewn_scripts.localization.localization_helpers")

local cards = {
    -- Warranty Card
    {
        "Karta Gwarancyjna",
        "Tworzy maszynę do szycia#Maszyna do szycia zmienia się w zależności od typu pokoju"
    },
    
    -- Stitching Card
    {
        "Karta Zszycia",
        "Zamienia korony chowańców#Daje darmowe ulepszenia jeśli żaden z twoich chowańców nie jest ulepszony"
    },
    
    -- Sewing Coupon
    {
        "Kupon na Szycie",
        "Ulepsza wszystkich chowańców na jeden pokój#Jednorazowe użycie zestawu do szycia" .. Icons.SewingBox
    },
}

return cards