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
	    "{{ArrowUp}} Mehr Tränen",
        "{{ArrowUp}} Mehr Tränen#{{ArrowUp}} Mehr Schaden"
    },
    
    -- Sister Maggy
    {
        "{{ArrowUp}} Mehr Schaden",
        "{{ArrowUp}} Mehr Schaden#{{ArrowUp}} Mehr Tränen"
    },
    
    -- Dead Cat
    {
        "Wiederbelebung mit einem zusätzlichen Seelenherz {{SoulHeart}}",
        "Wiederbelebung mit einem zusätzlichen Herzcontainer {{Heart}} + Seelenherz {{SoulHeart}}"
    },
    
    -- Little Chubby
    {
        "{{ArrowUp}} Um 50% verringerte Abklingzeit, kann schneller gefeuert werden",
        "Bleibt für 0,5 Sek. an Gegnern hängen und fliegt dann in die ursprüngliche Richtung weiter"
    },
    
    -- Robo Baby
    {
        "{{ArrowUp}} Mehr Tränen",
        "{{ArrowUp}} Mehr Tränen"
    },
    
    -- Little Gish
    {
        "{{ArrowUp}} Etwas mehr Tränen#Tränen erzeugen beim Aufprallen verlangsamende Pützen",
        "{{ArrowUp}} Mehr Schaden#{{ArrowUp}} Mehr Tränen#{{ArrowUp}} Größere Pützen"
    },
    
    -- Little Steven
    {
        "{{ArrowUp}} Mehr Schaden#{{ArrowUp}} Größere Reichweite#{{ArrowDown}} Geringere Schußgeschwindigkeit#Ein Treffer hat die Chance in einen Ring aus Tränen zu explodieren#Besiegte Gegner haben die Chance in einen Ring aus stärken Tränen zu exlodieren",
        "{{ArrowUp}} Mehr Schaden#{{ArrowUp}} Erhöhte Chance auf einen Ring aus Tränen, wenn ein Gegner getroffen/ besiegt wird#Chance auf eine Kettenreaktion, da Tränen aus dem Ring nun auch einen neuen Ring auslösen können"
    },
    
    -- Demon Baby
    {
        "Schießt automatisch durch Hindernisse",
        "{{ArrowUp}} Mehr Reichweite#{{ArrowUp}} Mehr Tränen"
    },
    
    -- Bomb Bag
    {
        "{{ArrowUp}} Bessere Ausbeute#Erzeugt keine Trollbomben mehr#Verteilt Pulver auf dem Boden. Dieses fängt in der Nähe von Feuer oder Explosionen an zubrennen",
        "{{ArrowUp}} Bessere Ausbeute#{{ArrowUp}} Kann Giga-Bomben auswerfen [Rep]#Kann in der Nähe von Gegnern explodieren"
    },
    
    -- The Peeper
    {
        "Schießt alle paar Sekunden 5 Tränen in zufällige Richtungen#Wird von nahen Gegnern angezogen",
        "Verdoppelt den Begleiter + 1".. Icons.Peeper .."#Das neue Auge hat die gleiche Krone wie das Erste#Mit Inner Eye ".. Icons.InnerEye .." kommt noch ein drittes Auge dazu"
    },
    
    -- Ghost Baby
    {
        "{{ArrowUp}} Mehr Schaden#Schießt durchdringende Pupula Duplex ".. Icons.PupulaDuplex .." Tränen",
        "{{ArrowUp}} Größere Tränen#{{ArrowUp}} Mehr Schaden"
    },
    
    -- Harlequin Baby
    {
        "Feuert in beide Richtungen einen extra Schuss",
        "{{ArrowUp}} Mehr Schaden"
    },
    
    -- Daddy Longlegs
    {
        "Hat eine Chance mit dem Kopf anzugreifen, was 2x soviel Schaden macht#Hat eine Chance als Triachnid zu zutreten. In diesem Fall werden 5 verlangsamende Tränen in alle Richtungen gefeuert",
        "{{ArrowUp}} Höhere Chance als Triachnid und mit dem Kopf anzugreifen#Hat die Chance, direkt nach einem Angriff nochmals zuzutreten"

    },
    
    -- Sacrificial Dagger
    {
        "{{ArrowUp}} Etwas mehr Schaden#Verursacht den Blutungs-Effekt",
        "{{ArrowUp}} Mehr Schaden"
    },
    
    -- Rainbow Baby
    {
        "{{ArrowUp}} Mehr Schaden#{{ArrowUp}} Mehr Tränen",
        "Kombinierte Träneneffekte"
    },
    
    -- Guppy's Hairball
    {
        "Von Anfang an größer (Stufe 2)#Erhält die Chance Blaue Fliegen zu erzeugen, wenn es Gegner besiegt oder Schüsse stoppt",
        "Von Anfang an noch größer (Stufe 3)#Erzeugt mehr Fliegen, wenn es Gegner besiegt oder Schüsse stoppt"
    },
    
    -- Dry Baby
    {
        "{{ArrowUp}} Erhöhte Chance den Necronomicon-Effekt auszulösen#Wenn es den Effekt auslöst, werden die gegnerischen Geschosse im Raum zerstört",
        "{{ArrowUp}} Noch größere Chance den Necronomicon- Effekt auszulösen!#Wenn es den Effekt auslöst, verwandeln sich die gegnerischen Geschosse im Raum in Knochenscherben"

    },
    
    -- Juicy Sack
    {
        "{{ArrowUp}} Größere Pfütze#Feuert Eier-Tränen (Parasitoid ".. Icons.Parasitoid .." Tränen) während Isaac schießt",
        "Feuert mehr Eier-Tränen"
   },
    
    -- Rotten Baby
    {
        "Erzeugt eine zusätzlich Blaue Fliege",
        "Erzeugt eine zufällige Heuschrecke"
    },
    
    -- Headless Baby
    {
        "{{ArrowUp}} Mehr Pfützenschaden#{{ArrowUp}} Größere Pfützen",
        "{{ArrowUp}} Mehr Pfützenschaden#Feuert, während Isaac schießt, einen Schwall von Tränen"
    },
    
    -- Leech
    {
        "{{ArrowUp}} Mehr Schaden#Hinterlässt eine Pfütze, wenn es mit einem Gegner zusammenstößt",
        "{{ArrowUp}} Mehr Schaden#Von ihm getötete Gegener explodieren in viele Tränen"
    },
    
    -- BBF
    {
        "{{ArrowUp}} Explosionen verursachen +75 Schaden#{{ArrowUp}} Größere Explosionen#{{Warning}} Da die Explosionen größer sind, können sie Isaac von weiter weg treffen",
        "Isaac nimmt keinen Schaden von den Explosionen, außer er ist zu nahe dran"
    },
    
    -- Lil Brimstone
    {
        "{{ArrowUp}} Mehr Schaden",
        "{{ArrowUp}} Ewtas mehr Schaden#Laser hält länger an#Schnellere Aufladung"
    },
    
    -- Isaac's Heart
    {
        "{{ArrowUp}} Verringerte Aufladezeit#Befindet sich näher beim Spieler, wenn dieser nicht schießt",
        "{{ArrowUp}} Verringerte Aufladezeit#Während es voll aufgeladen ist aktiviert es von selbst seinen Effekt, wenn ein Gegner oder Geschosse ihm zu Nahe kommt#In diesem Fall dauert es kurz bevor der Effekt erneut aufgeladen werden kann"

   },
    
    -- Sissy Longlegs
    {
        "{{ArrowUp}} Sissy's Blaue Spinnen verursachen +3 mehr Schaden#Sissy's Blaue Spinnen betören Gegner, wenn sie diese berühren",
        "{{ArrowUp}} Gegner sind länger betört#{{ArrowUp}} Blaue Spinnen verursachen +2 mehr Schaden#Erzeugt zusätzliche Spinnen"
    },
    
    -- Punching Bag
    {
        "Erhält eine zufällige Champion Form. Jede besitzt eine eigene spezielle Fähigkeit:#"..
        "{{ColorPink}}Rosa{{CR}}: Schießt eine Träne in eine zufällige Richtung#"..
        "{{ColorPurple}}Violet{{CR}}: Zieht Gegener und Geschosse an#"..
        "{{ColorCyan}}Hellblau{{CR}}: Wenn der Spieler getroffen wird, schießt es Tränen in 8 Richtungen#"..
        "{{ColorCyan}}Blau{{CR}}: Wenn der Spieler getroffen wird, erzeugt es 2-3 Blaue Fliegen#"..
        "{{ColorOrange}}Orange{{CR}}: Wenn der Spieler getroffen wird, erzeugt es eine Münze#"..
        "Stoppt Geschosse",
        "Zugang zu stärkeren Championformen:#"..
        "{{ColorGreen}}Grün{{CR}}: Hinterlässt grüne Pfützen#"..
        "{{ColorBlack}}Schwarz{{CR}}: Explodiert, wenn der Spieler getroffen wird. Explosionen verfügen 40 Schaden zu#"..
        "{{ColorRainbow}}Rainbow{{CR}}: Kombiniert die Effekt aller anderen Champion Formen. Hält nicht so lange an, wie die anderen Formen#"..
        "Verursacht Berührungsschaden"
    },
    
    -- Cain's Other Eye
    {
       	"Schießt eine zusätzliche Träne in einer zufälligen Diagonale",
	"Die zusätzliche Träne erhält den Rubber Cement- Effekt ".. Icons.RubberCement .."#{{ArrowUp}} Mehr Schaden"
    },
    
    -- Incubus
    {
        "{{ArrowUp}} Mehr Schaden",
        "{{ArrowUp}} Mehr Schaden"
    },
    
    -- Lil Gurdy
    {
        "{{ArrowUp}} Schnellere Aufladung#Schießt während der Aufladung Tränen in verschiedene Richtungen",
        "{{ArrowUp}} Schnellere Aufladung#Hinterlässt rote Pfützen beim Umherschießen#Feuert nach dem Umherschießen 3 Wellen von Tränen in verschiedene Richtungen"
    },
    
    -- Seraphim
    {
        "Hat eine Chance ein heilige Träne zuschießen (ähnlich wie ".. Icons.HolyLight ..")",
        "{{ArrowUp}} Mehr Tränen#{{ArrowUp}} Erhöhte Chance heilige Tränen zuschießen"
    },
    
    -- Spider Mod
    {
        "Legt Eier, welche Gegnern, die über sie drüberlaufen, einen zufälligen Effekt auferlegen#Eier verschwinden nach 20 Sekunden",
        "Höhere Chance Eier zu legen#Sobald ein Raum geschafft ist, schlüpfen aus ihnen Blaue Spinnen"
    },
    
    -- Farting Baby
    {
        "{{ArrowUp}} Erhöhte Chance zu furzen, wenn es getroffen wird#Hat die Chance alle paar Sekunden zu furzen. Je näher Gegner sind, desto höher ist die Chance, dass es furzt",
        "{{ArrowUp}} Noch größere Chance zu furzen, wenn es getroffen wird!#Erzeugt einen zusätzlichen brennenden und/oder heiligen Furzt"
    },
    
    -- Papa Fly
    {
        "Stoppt Geschosse#Wenn es getroffen wird, dann hat es eine Chance ein Fliegen-Geschütz zu hinterlassen",
        "{{ArrowUp}} Mehr Reichweite#{{ArrowUp}} Erhöhte Chance ein Fliegen-Geschütz zu hinterlassen#Schießt 5 Tränen nacheinander"
    },
    
    -- Lil Loki
    {
        "Schießt in 8 Richtungen",
        "{{ArrowUp}} Mehr Schaden"
    },
    
    -- Hushy
    {
        {
            "Schießt alle 4 Sek. 15 Tränen in einem kreisrunden Muster#Tränen verursachen 3 Schaden",
            "{{ArrowUp}} Mehr Schaden#Erzeugt einen Minisaac nach ein paar Sekunden des Aufladens (nur in Räumen mit Gegnern)"
        },
        {
            "Schießt alle 4 Sek. 15 Tränen in einem kreisrunden Muster#Tränen verursachen 3 Schaden",
            "{{ArrowUp}} Mehr Schaden#Erschafft eine freundliche Boil (Pustel) nach ein paar Sekunden des Aufladens (nur in Räumen mit Gegnern)"
        }
    },
    
    -- Lil Monstro
    {
        "Erhält die Chance einen Zahn zuspucken (Tough Love ".. Icons.ToughLove .." -Effekt)",
        "Spuckt viel mehr Zähne"
    },

    -- King Baby
    {
        "Erzeugt Tränen während Isaac schießt",
	"{{ArrowUp}} Mehr Tränen#Jeder Begleiter fügt der erzeugten Träne einen weiteren Effekt hinzu"
    },
    
    -- Big Chubby
    {
        "Wächst und verursacht mehr Schaden, wenn es Geschosse isst und/oder Gegner tötet#Wird mit der Zeit oder mit dem Ebenenwechsel wieder kleiner und harmloser",
        "{{ArrowUp}} Verringerte Abklingzeit#Wächst umso mehr, wenn es Gegnern Schaden zufügt#Verliert nicht mehr den Schadenbonus am Anfang einer neuen Ebene"
    },
    
    -- Mom's Razor
    {
        "{{ArrowUp}} Verlängert den Blutungs-Effekt (Bosse sind nicht davon betroffen)",
        "{{ArrowUp}} Verlängert den Blutungs-Effekt#Wenn ein blutender Gegner stirbt, dann hinterlässt er eine große Blutpfütze#Hat die Chance ein halbes rotes Herz {{HalfHeart}} zu hinterlassen"
    },
    
    -- Bloodshot Eye
    {
        "Schießt 3 Tränen gleichzeitig",
        "Feuert einen Blutlaser anstelle von Tränen"
    },

    -- Angry Fly
    {
       "In Räumen mit Gegnern wird es umso wütender, je länger es ihnen keinen Schaden zufügt#{{ArrowUp}} Je wütender es ist, desto mehr Schaden fügt es zu#Das Austeilen von Schaden verringert langsam seine Wut",
	"{{ArrowUp}} Wird noch wütender"
    },
    
    -- Buddy in a Box
    {
        "Erhält einen weiteren zufälligen Träneneffekt#Davon ausgenommen ist Ipecac, es sei den Ipecac ist der Grundgangriff des Begleiters",
        "Erhält einen weiteren zufälligen Träneneffekt"
    },
    
    -- Angelic Prism
    {
        "Kommt näher zum Spieler, wenn dieser in die Richtung des Prisma schießt#Tränen, die durch es hindurchgehen werden durchlässig",
        "Umkreist den Spieler noch enger#Tränen, die durch es hindurchgehen verfolgen die Gegner"
    },
    
    -- Lil Spewer
    {
        "Wenn es spuckt, dann feuert es zusätzliche Tränen mit dem gleichen Effekt wie seine aktuelle Farbe",
        "Hat 2 Farben gleichzeitig"
    },
    
    -- Pointy Rib
    {
        "Hat die Chance den Blutungs-Effekt, bei Non-Boss Monster zu verursachen#Hat die Chance Knochenscherben zu hinterlassen, wenn es den Gegner tötet",
        "{{ArrowUp}} Mehr Berührungsschaden#{{ArrowUp}} Erhöhte Chance Blutungen zu verursachen#{{ArrowUp}} Erhöhte Chance Knochenscherben zu hinterlassen"
    },
    
    -- Paschal Candle
    {
        "Wenn der Spieler Schaden nimmt, dann verteilt es Flammen um sich herum#Die Anzahl der Flammen hängt von der Größe der Kerzenflamme ab",
        "Bei Schaden reduziert sich die Größe der Kerzenflamme nur um ein Level"
    },
    
    -- Blood Oath
    {
        "Hinterlässt rote Pfützen#Die Anzahl und Stärke der Pfütze hängt von der Anzahl geopferter halber roter Herzen {{HalfHeart}} ab",
        "Wenn es zusticht, dann hinterlässt es zufällige rote Herzen {{Heart}}"
    },
    
    -- Psy Fly
    {
        "Wenn es ein Geschoss stoppt, dann feuert es eine verfolgende Träne zurück",
        "{{ArrowUp}} Mehr Berührungsschaden#{{ArrowUp}} Tränen verursachen mehr Schaden"
    },
    
    -- Boiled Baby
    {
        "Wirft mehr Tränen aus",
        "Feuert die Tränen in die Richtung, in die der Spieler schießt"
    },
    
    -- Freezer Baby
    {
        "{{ArrowUp}} Mehr Schaden#{{ArrowUp}} Mehr Reichweite#{{ArrowUp}} Erhöhte Chance Gegner einzufrieren",
        "{{ArrowUp}} Mehr Schaden#Getötete Gegner explodieren in Eistränen"
    },

    -- Lost Soul
    { 
	"{{ArrowUp}} Bessere Belohnungen# Erhält einen einzelnen Holy Mantel Schild (Holy Card-Effekt "..Icons.HolyCard..")",
	"Erhält den Effekt von Holy Mantel "..Icons.HolyMantle
    },
    
    -- Lil Dumpy
    {
        "Nach jedem Raum wird es zu einer anderen Art von Lil Dumpy, wie z.B.:" ..
        "#".. Icons.LilDumpy.DUMPLING .." Normaler Effekt"..
        "#".. Icons.LilDumpy.SKINLING .." Vergiftet Gegner beim furzen"..
        "#".. Icons.LilDumpy.SCABLING .." Schießt 6 Tränen in einem kreisformigen Muster, wenn es furzt,"..
        "#".. Icons.LilDumpy.SCORCHLING .." Erzeugt eine Flamme, die 15 Schaden verursacht, wenn es furzt"..
        "#".. Icons.LilDumpy.FROSTLING .." Von ihm getötete Gegner erstarren zu Eis. Erhält beim Ausruhen eine gefrierende Aura"..
        "#".. Icons.LilDumpy.DROPLING .." Schießt, wenn es furzt, Tränen in die entgegengesetze Richtung",
        "Kehrt nach ein zufälligen Anzahl von Sekunden zum Spieler zurück. Selbst dann, wenn der Spieler weit entfernt ist"
    },
    
    -- Bot Fly
    {
        "{{ArrowUp}} Bessere Werte (Reichweite, Tränengeschwindigkeit, Tränengröße)#Beim Schießen einer Träne, verbindet ein Laser die Träne und den Begleiter#Der Laser verursacht Berührungsschaden und stoppt Geschosse",
        "{{ArrowUp}} Bessere Werte#Erhält Gegner durchdringende Tränen#Greift ab und zu Gegner an"
    },
    
    -- Fruity Plum
    {
        "{{ArrowUp}} Mehr Schaden#Erhälten einen leichten Verfolgung-Effekt",
        "Erhält den Playdough Cookie ".. Icons.PlaydoughCookie .." -Effekt#Feuert, nach einem Angriff, Tränen in alle Richtungen"
    },
    
    -- Cube Baby
    {
        "Erhält eine gefrierende Aura#Gegner, die zu lange darin stehen, nehmen so lange Schaden bis sie komplett einfrieren",
        "{{ArrowUp}} Größere Aura#Hinterlässt beim Herumgleiten Pfützen#Je schneller es sich bewegt, desto mehr Pützen hinterlässt es"
    },
    
    -- Lil Abaddon
    {
        "{{ArrowUp}} Mehr Schaden#Beim Halten des Schießknopfes, erzeugt es alle paar Sekunden einen Strudel. Beim Loslassen wird jeder der Strudel zu einem Laserring",
        "Erzeugt öfters Strudel#Von Strudel erzeugten Laserringe sind größer, halten länger an und verursachen mehr Schaden#Hat eine geringe Chance schwarze Herzen {{BlackHeart}} zu erzeugen"
    },

        -- Worm Friend
    {
        "Festgehaltene Gegner ziehen Geschosse in ihrer Nähe an# Für jedes Geschoss nehmen sie 1 Schaden#{{ArrowUp}} Stark reduzierter Abklingzeit",
        "{{ArrowUp}} Festgehaltene Gegner nehmen von allem mehr Schaden"
    },

    -- Vanishing Twin
    {
        "Kopierte Bosse starten mit 25% weniger Leben",
        "Erhöhte Chance ein besseres Item zu erhalten (abhängig von der Qualität)#Kann Items aus dem Schatzraum hinterlassen, wenn keine Bossraum- Items gefunden werden konnten"
    },
    
    -- Twisted Pair
    {
        "{{ArrowUp}} +0.33 Falter Schaden#Während sie schießen, dann drehen sich enger um den Spieler",
        "Richten sich nach der Richtung des Spielers aus"
    },
}

return familiarsUpgrades