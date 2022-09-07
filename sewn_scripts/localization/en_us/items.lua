--- -- Name of the item in english, do not change it!
--- {
---     "Item Name",
---     "Description of the item",
--- }

local Icons = require("sewn_scripts.localization.localization_helpers")

local items = {
    -- Sewing Box
    {
        "Sewing Box",
        "Temporarily upgrades familiars for a room#Using it twice upgrades familiars to Ultra {{UltraCrown}}"
    },
    
    -- Doll's Tainted Head
    {
        "Doll's Tainted Head",
        "Upgrade every normal familiars to Super {{SuperCrown}}#With Doll's Pure Body ".. Icons.PureBody ..", upgrade every familiars to Ultra {{UltraCrown}}#Add 20% chance to find a Sewing Machine in Devil rooms"
    },
    
    -- Doll's Pure Body
    {
        "Doll's Pure Body",
        "Upgrade every normal familiars to Super {{SuperCrown}}#With Doll's Pure Body ".. Icons.PureBody ..", upgrade every familiars to Ultra {{UltraCrown}}#Add 20% chance to find a Sewing Machine in Devil rooms"
    },
}

return items