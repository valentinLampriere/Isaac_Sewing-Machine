--- -- Name of the item in english, do not change it!
--- {
---     "Item Name",
---     "Description of the item",
--- }

local Icons = require("sewn_scripts.localization.localization_helpers")

local items = {
    -- Sewing Box
    {
        "Šicí box",
        "Dočasně upgraduje spojence pro místnost#Dvojité použití upgraduje spojence na Ultra {{UltraCrown}}#Pokud hráč nemá dostupné spojence, vytvoří náhodného {{SuperCrown}} spojence"
    },
    
    -- Doll's Tainted Head
    {
        "Poskvrněná Hlava Panenky",
        "Upgraduje všechny normální spojence na Super {{SuperCrown}}#S Čistým Tělem Panenky ".. Icons.PureBody ..", upgraduje všechny spojence na Ultra {{UltraCrown}}#Přidá 20% šanci na nalezení šicího stroje v Ďábelské místnosti"
    },
    
    -- Doll's Pure Body
    {
        "Čisté Tělo Panenky",
        "Upgraduje všechny normální spojence na Super {{SuperCrown}}#S Čistým Tělem Panenky ".. Icons.PureBody ..", upgraduje všechny spojence na Ultra {{UltraCrown}}#Přidá 20% šanci na nalezení šicího stroje v Ďábelské místnosti"
    },
}

return items