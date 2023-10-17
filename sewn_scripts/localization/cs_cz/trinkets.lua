--- -- Name of the trinket in english, do not change it!
--- {
---     "Trinket Name",
---     "Description of the trinket",
--- }

local trinkets = {
    -- Thimble
    {
        "Náprstek",
        "Vytvoří pickup podle typu šicího stroje použitého při upgradu",
    },

    -- Cracked Thimble
    {
        "Prasklý Náprstek",
        "Máš 75% šanci na zamíchání korun spojenců, když budeš zasažen",
    },

    -- Lost Button
    {
        "Ztracený knoflík",
        "100% šance na vytvoření šicího stroje v obchodech#50% šance najít šicí stroj v Andělské místnosti {{AngelRoom}} nebo Ďábelské místnosti {{DevilRoom}}",
    },

    -- Pin Cushion
    {
        "Jehelníček",
        "Interakce se šicím strojem ti vrátí spojence bez upgradu.#To ti umožní vybrat si spojence, kterého chceš upgradovat, tím, že upustíš trinket pomocí tlačítka pro upuštění, když je ve stroji ten správný#{{Warning}} Při tavení se tento efekt odstraní, ale máš sníženou šanci na rozbití šicího stroje",
    },
    
    -- Sewing Case
    {
        "Šicí pouzdro",
        "Při vstupu do místnosti má možnost dočasně upgradovat spojence na základě množství dostupných spojenců a štěstí",
    },
}

return trinkets