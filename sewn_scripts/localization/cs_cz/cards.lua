--- Translation by David Kapitančik

--- -- Name of the card in english, do not change it!
--- {
---     "Card Name",
---     "Description of the card effect",
--- }

local Icons = require("sewn_scripts.localization.localization_helpers")

local cards = {
    -- Warranty Card
    {
        "Záruční karta",
        "Vytvoří šicí stroj#Šicí stroj se mění v závislosti na typu místnosti"
    },
    
    -- Stitching Card
    {
        "Sešívací karta",
        "Přeroluje korunu spojence#Poskytuje bezplatné vylepšení, pokud žádný z tvých spojenců není upgradován"
    },
    
    -- Sewing Coupon
    {
        "Kupón na šití",
        "Upgraduje všechny spojence za jeden pokoj#Jednorázové použití šicího boxu" .. Icons.SewingBox
    },
}

return cards