--- -- Name of the card in english, do not change it!
--- {
---     "Card Name",
---     "Description of the card effect",
--- }

local Icons = require("sewn_scripts.localization.localization_helpers")

local cards = {
    -- Warranty Card
    {
        "Garantiekarte",
        "Erschafft eine Nähmaschine#Art der Nähmaschine hängt von der Art des Raumes ab"
    },
    
    -- Stitching Card
    {
        "Nähkarte",
	"Ändert die Kronen deiner Begleiter#Gewährt ein Upgrade umsonst, wenn keiner deiner Begleiter eine Krone hat"
    },
    
    -- Sewing Coupon
    {
        "Nähgutschein",
        "Werte alle Begleiter für einen Raum auf#Einmalige Nutzung der Nähkiste " .. Icons.SewingBox
    },
}

return cards