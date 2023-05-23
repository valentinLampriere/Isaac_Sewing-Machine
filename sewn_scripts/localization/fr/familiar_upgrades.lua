--- Translation by siraxtas with the help of Biobak

--- -- Name of the familiar in english, do not change it!
--- {
---     "First upgrade description",
---     "Second upgrade description",
---     "Name of the familiar" (optional)
--- }

local Icons = require("sewn_scripts.localization.localization_helpers")

local familiarsUpgrades = {
    -- Brother Bobby
    {
        "{{ArrowUp}} Débit",
        "{{ArrowUp}} Débit#{{ArrowUp}} Dégâts"
    },
    
    -- Sister Maggy
    {
        "{{ArrowUp}} Dégâts",
        "{{ArrowUp}} Dégâts#{{ArrowUp}} Débit"
    },
    
    -- Dead Cat
    {
        "Isaac ressucite avec un cœur d'âme {{SoulHeart}} supplémentaire",
        "Isaac ressucite avec un cœur d'âme {{SoulHeart}} supplémentaire ainsi qu'un réceptacle de cœur rouge {{Heart}}supplémentaire"
    },
    
    -- Little Chubby
    {
        "{{ArrowUp}} Réduit le temps de recharge de 50% (Peut être lancé plus souvent)",
        "S'arrête pendant 1/2 seconde sur les ennemis qu'il croise"
    },
    
    -- Robo Baby
    {
        "{{ArrowUp}} Débit",
        "{{ArrowUp}} Débit"
    },
    
    -- Little Gish
    {
        "{{ArrowUp}} Léger Débit#Ses larmes répandent une flaque collante au contact",
        "{{ArrowUp}} Dégâts#{{ArrowUp}} Débit#{{ArrowUp}} Taille des flaques"
    },
    
    -- Little Steven
    {
        "{{ArrowUp}} Dégâts#{{ArrowUp}} Portée#{{ArrowDown}} Vitesse de larmes#Toucher un ennemi avec une larme peut projeter un cercle de larmes#Tuer un ennemi peut projeter un cercle de grosses larmes",
        "{{ArrowUp}} Dégâts#{{ArrowUp}} Augmente les chances de déclencher un cercle de larmes#Les larmes des cercles de larmes peuvent déclencher un autre cercle de larmes et démarrer des réactions en chaine"
    },
    
    -- Demon Baby
    {
        "Tire automatiquement à travers les obstacles",
        "{{ArrowUp}} Portée#{{ArrowUp}} Débit"
    },
    
    -- Bomb Bag
    {
        "{{ArrowUp}} Meilleurs bombes#Ne peut plus faire apparaitre de \"Troll Bombs\"#Répand de la poudre au sol qui prend feu au contact de flammes ou d'explosions",
        "{{ArrowUp}} Meilleurs bombes#{{ArrowUp}} Peut donner des Giga Bombes [Rep]#Peut créer une explosion à proximité d'ennemis"
    },
    
    -- The Peeper
    {
        "Tire parfois 5 larmes en cercle#Il est légerement attiré par les ennemis a proximité",
        "Invoque un deuxième Œil Baladeur " .. Icons.Peeper .. " amélioré#Invoque un Œil Baladeur supplémentaire si Isaac a \"Le Troisième Œeil\"" .. Icons.InnerEye
    },
    
    -- Ghost Baby
    {
        "{{ArrowUp}} Dégâts#Ses larmes deviennent transperçantes et prennent l'apparence de \"Polycorie\" " .. Icons.PupulaDuplex,
        "{{ArrowUp}} Taille des larmes#{{ArrowUp}} Dégats"
    },
    
    -- Harlequin Baby
    {
        "Tire deux larmes supplémentaires",
        "{ArrowUp}} Dégâts"
    },
    
    -- Daddy Longlegs
    {
        "Peut frapper avec sa tête, infligeant 2x plus de dégâts#Peut frapper en tant que \"Triachnide\". \"Triachnide\" tire 5 larmes ralentissantes dans différente directions",
        "{{ArrowUp}} Augmente les chances de frapper avec la tête et les chances de frapper en tant que \"Triachnide\"#Peut frapper deux fois de suite"
    },
    
    -- Sacrificial Dagger
    {
        "{{ArrowUp}} Dégâts léger#Applique un effet de saignement",
        "{{ArrowUp}} Dégâts"
    },
    
    -- Rainbow Baby
    {
        "{{ArrowUp}} Dégât#{{ArrowUp}} Débit",
        "Les larmes combinent plusieurs effets"
    },
    
    -- Guppy's Hairball
    {
        "Passe immédiatement au deuxième stage#Tuer un ennemi ou bloquer un projectile peut invoquer des mouches bleues",
        "Passe immédiatement au troisième stage#Génère davantage de mouches bleues"
    },
    
    -- Dry Baby
    {
        "{{ArrowUp}} Augmente les chances de déclencher l'effet du Necronomicon#Lorsque l'effet se déclenche, détruit tous les projectiles",
        "{{ArrowUp}} Augmente davantage les chances de déclencher l'effet du Necronomicon#Lorsque l'effet se déclenche, transforme tous les projectiles en os"
    },
    
    -- Juicy Sack
    {
        "{{Arrow Up}} Taille de la trainée#Tirer projette un tas de cocons (similaires à ceux de Parasitoïde ".. Icons.Parasitoid ..")",
        "Propulse davantage de cocons"
    },
    
    -- Rotten Baby
    {
        "Invoque une mouche bleue supplémentaire",
        "Invoque un locuste aléatoire"
    },
    
    -- Headless Baby
    {
        "{{ArrowUp}} Dégâts de la trainée de sang#{{ArrowUp}} Taille de la trainée de sang",
        "{{ArrowUp}} Dégâts de la trainée de sang#Projette un tas de larmes quand Isaac tire"
    },
    
    -- Leech
    {
        "{{ArrowUp}} Dégâts#Répand une trainée de sang lorsqu'elle inflige des dégâts",
        "{{ArrowUp}} Dégâts#Les ennemis qu'elle tue explosent en larmes"
    },
    
    -- Lil Brimstone
    {
        "{{ArrowUp}} Dégâts",
        "{{ArrowUp}} Dégâts#Les lasers durent plus longtemps#Se charge plus vite"
    },
    
    -- Isaac's Heart
    {
        "{{ArrowUp}} Réduit le temps de chargement#Ne pas tirer rapproche le cœur plus près d'Isaac",
        "{{ArrowUp}} Réduit le temps de chargement#Repousse automatiquement les tirs et les ennemis trop proche quand il est complètement chargé, puis doit se recharger"
    },
    
    -- Sissy Longlegs
    {
        "{{ArrowUp}} +3 dégâts pour les araignées bleues de Sissy#Les araignées de Sissy envoûtent les ennemis qu'elles touchent",
        "{{ArrowUp}} Augmente la durée de l'envoutement#{{ArrowUp}} +2 dégâts pour les araignées bleues#Invoque davantage d'araignées bleus"
    },
    
    -- Punching Bag
    {
        "Obtient différentes formes d'élite#"..
        "{{ColorPink}}Rose{{CR}}: Tire une larme dans une direction aléatoire#"..
        "{{ColorPurple}}Violet{{CR}}: Attire les ennemis et les projectiles#"..
        "{{ColorCyan}}Bleu Clair{{CR}}: Tire 8 larmes en cercles quand Isaac subit des dégâts#"..
        "{{ColorCyan}}Bleu{{CR}}: Invoque 2-3 mouches bleues quand Isaac subit des dégâts#"..
        "{{ColorOrange}}Orange{{CR}}: Fait apparaître 1 pièce quand Isaac subit des dégâts#"..
        "Bloque les projectiles",
        "Obtient de puissantes formes d'élite :#"..
        "{{ColorGreen}}Vert{{CR}}: Répand une trainée de liquide vert#"..
        "{{ColorBlack}}Noir{{CR}}: Provoque une explosion qui inflige 40 dégâts quand Isaac subit des dégâts#"..
        "{{ColorRainbow}}Arc-en-Ciel{{CR}}: Regroupe les effets des autres élites. Dure moins longtemps que les autres formes#"..
        "Inflige des dégâts de contact"
    },
    
    -- Cain's Other Eye
    -- {
    --     "Tire 2 larmes au lieu d'une#Les larmes gagnent l'effet de Colle Caoutchouc " .. Icons.RubberCement,
    --     "{{ArrowUp}} Portée#Tire 4 larmes"
    -- },
    
    -- Incubus
    {
        "{{ArrowUp}} Dégâts",
        "{{ArrowUp}} Dégâts"
    },
    
    -- Lil Gurdy
    {
        "{{ArrowUp}} Se charge plus rapidement#Projette des larmes autour de lui quand Isaac tire",
        "{{ArrowUp}} Se charge plus rapidement#Répand une trainée de sang derrière lui quand il est propulsé#Tire 3 vagues de larmes en cercle après avoir été propulsé"
    },
    
    -- Seraphim
    {
        "Peut tirer une larme sacrée (comme avec \"Saint Éclat\" ".. Icons.HolyLight ..")",
        "{{ArrowUp}} Débit#{{ArrowUp}} Augmente les chances de tirer une larme sacrée"
    },
    
    -- Spider Mod
    {
        "Pond des œufs qui appliquent un effet aléatoire aux ennemis qui marchent dessus#Les œufs ont une durée de 20 secondes",
        "Augmente les chances de pondre un œuf#Quand une salle est terminée, les œufs éclosent en araignées bleues"
    },
    
    -- Farting Baby
    {
        "{{ArrowUp}} Augmente les chances de pèter lorqu'il est touché par un projectile#Peut péter après quelques secondes. Être proche d'ennemis augmente ses chances de péter",
        "{{ArrowUp}} Augmente les chances de pèter lorqu'il est touché par un projectile#Obtient deux nouveaux type de pets. L'un brûle les ennemis, l'autre augmente les stats d'Isaac pour une très courte durée"
    },
    
    -- Papa Fly
    {
        "Bloque les projectiles#Bloquer un projectile peut faire apparaître une mouche qui tire automatiquement",
        "{{ArrowUp}} Portée#{{ArrowUp}} Augmente les chances de faire apparaître des mouches#Tire 5 larmes à la suite"
    },
    
    -- Lil Loki
    {
        "Tire dans 8 directions",
        "{{ArrowUp}} Dégâts"
    },
    
    -- Hushy
    {
        {
            "Tire 15 larmes en cercle toutes les 4 secondes#Ses larmes infligent 3 dégâts",
            "{{ArrowUp}} Dégâts#Charge puis invoque un Micro-Isaac dans les salles sans ennemis"
        },
        {
            "Tire 15 larmes en cercle toute les 4 secondes#Ses larmes font 3 de dégâts",
            "{{ArrowUp}} Dégâts#Charge puis invoque un furoncle dans les salles sans ennemis"
        }
    },
    
    -- Lil Monstro
    {
        "Peut lancer des dents (comme le \"Poing Américain\" " .. Icons.ToughLove,
        "Tire beaucoup plus de larmes"
    },
    
    -- Big Chubby
    {
        "Augmente sa taille et ses dégâts lorqu'il mange des projectiles ou tue des ennemis#Reprend sa taille initiale au fil du temps#Reprend sa taille initiale au changement d'étage",
        "{{ArrowUp}} Réduit le temps de récupération#Augmente davantage sa taille et ses dégâts lorsqu'il inflige des dégâts aux ennemis#Ne perd plus ses bonus de dégâts au changement d'étage"
    },
    
    -- Mom's Razor
    {
        "{{ArrowUp}} Augmente la durée du saignement, sauf pour les Boss",
        "{{ArrowUp}} Augmente la durée du saignement#Les ennemis qui meurent en saignant répandent une grande flaque de sang#Peut rarement laisser tomber un demi-cœur {{HalfHeart}}"
    },
    
    -- Bloodshot Eye
    {
        "Tire trois larmes à la fois",
        "Ses larmes sont remplacées par un laser de sang"
    },
    
    -- Buddy in a Box
    {
        "Obtient un nouvel effet de larme aléatoire#L'effet de larme ne peut pas être Ipéca (sauf si Ipéca est l'effet de base du familier)",
        "Obtient de nouveau un effet de larme aléatoire"
    },
    
    -- Angelic Prism
    {
        "Se rapproche d'Isaac lorsqu'il tire#Les larmes qui lui passent au travers deviennent spectrales",
        "S'approche davantage de Isaac#Les larmes qui passent au travers deviennent autoguidées"
    },
    
    -- Lil Spewer
    {
        "Tire des larmes en crachant#Les larmes ont différents effets selon la couleur du P'tit Spewer",
        "Devient bicolore"
    },
    
    -- Pointy Rib
    {
        "Peut appliquer un effet de saignement aux ennemis#Tuer un ennemi peut faire apparaître des os",
        "{{ArrowUp}} Dégâts#{{Arrow Up}} Augmente les chances d'appliquer l'effet de saignement#{{Arrow Up}} Augmente les chances de faire apparaître des os"
    },
    
    -- Paschal Candle
    {
        "Quand Isaac subit des dégâts, le Cierge Pascal projette des flames autour de lui#Le nombre de flames dépend de la taille de la flamme du Cierge Pascal",
        "Subir des dégâts ne réduit que d'un stage la taille de la flamme"
    },
    
    -- Blood Oath
    {
        "Répand une traînée de sang derrière lui#Le taux d'apparition des trainées de sang et leur dégâts dépendent du nombre de demi-coeurs {{HalfHeart}} retirés",
        "Fait apparaitre des coeurs rouges {{Heart}} après avoir poignardé Isaac"
    },
    
    -- Psy Fly
    {
        "Renvoie à l'envoyeur les projectiles qu'elle touche",
        "{{ArrowUp}} Dégâts"
    },
    
    -- Boiled Baby
    {
        "Augmente le nombre de larmes qu'il projette",
        "Projette des larmes dans la direction des tirs d'Isaac"
    },
    
    -- Freezer Baby
    {
        "{{ArrowUp}} Dégâts#{{ArrowUp}} Portée#{{ArrowUp}} Augmente les chances de pétrifier les ennemis",
        "{{ArrowUp}} Dégâts#Les ennemies qu'il tue projettent des larme de glace dans toutes les directions"
    },
    
    -- Lil Dumpy
    {
        "Change d'aspect à chaque salle :" ..
        "#".. Icons.LilDumpy.DUMPLING .." Effet normal"..
        "#".. Icons.LilDumpy.SKINLING .." Ses pets empoisonnent les ennemis"..
        "#".. Icons.LilDumpy.SCABLING .." Tire 6 larmes en cercle quand il pète"..
        "#".. Icons.LilDumpy.SCORCHLING .." Crée une flame qui inflige 15 dégâts quand il pète"..
        "#".. Icons.LilDumpy.FROSTLING .." Gèle les ennemis qu'il tue. Est entouré d'une aura gelée lorsqu'il se repose"..
        "#".. Icons.LilDumpy.DROPLING .." Projette une salve de larme derrière lui quand il pète",
        "Revient auprès d'Isaac après quelques secondes"
    },
    
    -- Bot Fly
    {
        "{{ArrowUp}} Bonus de stats (Portée, Vitesse de tir, Taille de larmes)#Un arc électrique relie les larmes lancées à la Robomouche#Le laser inflige des dégâts et bloque les projectiles",
        "{{ArrowUp}} Bonus de stats#Larmes transperçantes#Attaque parfois directement les ennemis"
    },
    
    -- Fruity Plum
    {
        "{{ArrowUp}} Dégâts#P'tite Prunelle est légèrement attiré par les ennemis",
        "Obtient l'effet de \"Pâte à Modeler\" ".. Icons.PlaydoughCookie .."#Après chaque attaque, tire des larmes dans toute les directions"
    },
    
    -- Cube Baby
    {
        "Obtient une aura gelée. Les ennemis qui restent trop longtemps dans l'aura subissent des dégâts jusqu'à être complètement gelés",
        "Répand une trainée derrière lui lorsqu'il est poussé#Répand davantage selon sa vitesse#"
    },
    
    -- Lil Abaddon
    {
        "{{ArrowUp}} Dégâts#Maintenir les boutons de tir crée des tourbillons du néant#Lorsque les boutons de tir sont relachés, les tourbillons du néant génèrent un anneau du néant",
        "{{ArrowUp}} Crée davantage de tourbillons du néant#Les anneaux du néant infligent davantage de dégâts, sont plus grands et restent actifs plus longtemps#Peut rarement faire apparaitre un cœur noir {{BlackHeart}}"
    },
    
    -- Vanishing Twin
    {
        "Réduit de 25% les PV du boss copié",
        "Augmente les chances d'obtenir un meilleur objet (selon la Qualité)#Peut faire apparaître un objet de la Treasure Room {{TreasureRoom}} si aucun objet de la Boss Room n'a été trouvé"
    },
    
    -- Twisted Pair
    {
        "{{ArrowUp}}+0.33 Dégâts#Ils se rapprochent de Isaac quand celui-ci tire",
        "Ils s'alignent avec Isaac, dans la direction dans lequel il tire"
    },
    
    -- BBF
    {
        "{{ArrowUp}}75 dégâts supplémentaire par explosion#{{ArrowUp}}Explosions plus larges#{{Warning}}Comme les explosions sont plus grosse elle peuvent touché Isaac de plus loin",
        "Isaac ne subit pas de dégât sauf si il est trop près de l'explosion"
    },
}

return familiarsUpgrades