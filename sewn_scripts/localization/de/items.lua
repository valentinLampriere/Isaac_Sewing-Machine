--- -- Name of the item in english, do not change it!
--- {
---     "translated Item Name",
---     "Description of the item",
--- }

local Icons = require("sewn_scripts.localization.localization_helpers")

local items = {
    -- Sewing Box
    {
        "Nähkiste",
	"Wertet Begleiter für einen Raum auf#Die zweite Nutzung wertet Begleiter auf Ultra {{UltraCrown}} auf# Sind keine passenden Begleiter verfügbar, beschwört es einen zufälligen {{SuperCrown}} Begleiter"
    },
    
    -- Doll's Tainted Head
    {
        "Doll's Beschädigter Kopf",
	"Wertet jeden normalen Begleiter auf Super {{SuperCrown}} auf#Wertet mit Doll's Makeloser Körper ".. Icons.PureBody ..", alle Begleiter auf Ultra {{UltraCrown}} auf#+20% für eine Nähmaschine in Teufelsräumen"
    },
    
    -- Doll's Pure Body
    {
        "Doll's Makeloser Körper",
        "Wertet jeden normalen Begleiter auf Super {{SuperCrown}} auf#Wertet mit Doll's Beschädigter Kopf ".. Icons.TaintedHead ..", alle Begleiter auf Ultra {{UltraCrown}} auf#+20% für eine Nähmaschine in Engelsräumen"
    },
}

return items