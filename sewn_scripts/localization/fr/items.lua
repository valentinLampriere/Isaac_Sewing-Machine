--- Translation by siraxtas with the help of Biobak

--- -- Name of the item in english, do not change it!
--- {
---     "Item Name",
---     "Description of the item",
--- }

local Icons = require("sewn_scripts.localization.localization_helpers")

local items = {
    -- Sewing Box
    {
        "Boîte de couture",
        "Améliore tous les familiers pour la durée d'une salle#Utiliser l'objet deux fois dans la même salle améliore les familiers en Ultra {{UltraCrown}}#Si le joueur n'a pas de familier valide, fait apparaitre un {{SuperCrown}} familier aléatoire"
    },
    
    -- Doll's Tainted Head
    {
        "Tête Impure de Poupée",
        "Améliore tous les familiers \"Normal\" en Super {{SuperCrown}}#Si Isaac a le Corps Pur de Poupée " .. Icons.PureBody .." améliore tous les familiers en Ultra {{UltraCrown}}#20% de chance de trouver une Machine à Coudre dans les Devil Rooms"
    },
    
    -- Doll's Pure Body
    {
        "Corps Pur de Poupée",
        "Améliore tous les familiers \"Normal\" en Super {{SuperCrown}}#Si Isaac a la Tête Impure de Poupée ".. Icons.TaintedHead .." améliore tous les familiers en Ultra {{UltraCrown}}#20% de chance de trouver une Machine à Coudre dans les Angel Rooms"
    },
}

return items