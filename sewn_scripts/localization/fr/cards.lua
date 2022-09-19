--- Translation by siraxtas with the help of Biobak

--- -- Name of the card in english, do not change it!
--- {
---     "Card Name",
---     "Description of the card effect",
--- }

local Icons = require("sewn_scripts.localization.localization_helpers")

local cards = {
    -- Warranty Card
    {
        "Carte de Garantie",
        "Fait apparaître une Machine à Coudre#Le type de Machine à Coudre dépend du type de la salle"
    },
    
    -- Stitching Card
    {
        "Carte de Couture",
        "Change les couronnes (= les améliorations) des familiers#Si Isaac n'a aucun familier amélioré, améliore un familier aléatoire"
    },
    
    -- Sewing Coupon
    {
        "Coupon de Couture",
        "Améliore tous les familiers pour la durée de la salle#Équivaut à une utilisation de la Boîte de Couture " .. Icons.SewingBox
    },
}

return cards