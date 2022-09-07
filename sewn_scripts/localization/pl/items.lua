--- -- Name of the item in english, do not change it!
--- {
---     "Item Name",
---     "Description of the item",
--- }

local Icons = require("sewn_scripts.localization.localization_helpers")

local items = {
    -- Zestaw do szycia
    {
        "Zestaw do szycia",
        "Ulepsza chowańców na jeden pokój#Użycie dwa razy ulepsza je do poziomu Ultra {{UltraCrown}}"
    },
    
    -- Skażona głowa lalki
    {
        "Skażona głowa lalki",
        "Ulepsza wszystkie zwykłe chowańce do poziomu Super {{SuperCrown}}#Z nieskalanym ciałem lalki ".. Icons.PureBody ..", ulepsza je do poziomu Ultra {{UltraCrown}}#Dodaje 20% szans na maszynę do szycia w pokoju diabła"
    },
    
    -- Nieskalane ciało lalki
    {
        "Nieskalane ciało lalki",
        "Ulepsza wszystkie zwykłe chowańce do poziomu Super {{SuperCrown}}#Ze skażoną głową lalkę ".. Icons.PureBody ..", ulepsza je do poziomu Ultra {{UltraCrown}}#Dodaje 20% szans na maszynę do szycia w pokoju diabła"
    },
}

return items