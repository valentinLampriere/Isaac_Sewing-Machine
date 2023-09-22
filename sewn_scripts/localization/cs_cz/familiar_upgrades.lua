--- Translation by David Kapitančik

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
        "{{ArrowUp}} Více Slz",
        "{{ArrowUp}} Více Slz#{{ArrowUp}} Větší Poškození"
    },
    
    -- Sister Maggy
    {
        "{{ArrowUp}} Větší Poškození",
        "{{ArrowUp}} Větší Poškození#{{ArrowUp}} Více Slz"
    },
    
    -- Dead Cat
    {
        "Když hráč zemře, znovu se objeví s dalším duševním srdcem {{SoulHeart}}",
        "Když hráč zemře, znovu se objeví s dalším místem pro červené srdce {{Heart}} a s dalším duševním srdcem {{SoulHeart}}"
    },
    
    -- Little Chubby
    {
        "{{ArrowUp}} Nižší cooldown o 50%, lze ho rychleji hodit",
        "Přilne k nepřátelům po dobu 0,5 sekundy a poté pokračuje v původním směru"
    },
    
    -- Robo Baby
    {
        "{{ArrowUp}} Více Slz",
        "{{ArrowUp}} Více Slz"
    },
    
    -- Little Gish
    {
        "{{ArrowUp}} Více Slz ale jen o trošku#Slzy při zásahu vytvářejí zpomalujícího louži",
        "{{ArrowUp}} Větší Poškození#{{ArrowUp}} Více Slz#{{ArrowUp}} Větší louže"
    },
    
    -- Little Steven
    {
        "{{ArrowUp}} Větší Poškození#{{ArrowUp}} Větší Dostřel#{{ArrowDown}} Menší Rychlost Střel#Šance na vystřelení prstence slz při zasáhnutí nepřítele #Zabití nepřítele mají šanci na vystřelení prstence silnějších slz",
        "{{ArrowUp}} Větší Poškození#{{ArrowUp}} Zvyšuje šanci na vystřelení prstence slz při zasažení/zabití nepřátel#Slzy z prstence mohou spustit další slzný prstenec, což vede k řetězové reakci"
    },
    
    -- Demon Baby
    {
        "Střílí automaticky přes překážky",
        "{{ArrowUp}} Větší Dostřel#{{ArrowUp}} Více Slz"
    },
    
    -- Bomb Bag
    {
        "{{ArrowUp}} Lepší bombové dropy#Už nevytvoří trollí bomby#Vytváří prášek na zemi. Prášek se vznítí, když je blízko požáru nebo výbuchu",
        "{{ArrowUp}} Lepší bombové dropy#{{ArrowUp}} Může vytvořit Giga bomby [Rep]#Někdy exploduje, když je blízko nepřítele"
    },
    
    -- The Peeper
    {
        "Každých pár sekund vystřelí 5 slz v náhodných směrech#Pokouší se navádět na nepřátele poblíž",
        "Vytvoří další Kukadlo".. Icons.Peeper .."#Ono nové Kukadlo je taky upgradováno#S Vnitřním Okem".. Icons.InnerEye .."vytvoří ještě další Kukadlo"
    },
    
    -- Ghost Baby
    {
        "{{ArrowUp}} Větší Poškození#Získáš průrazné slzy jako u ".. Icons.PupulaDuplex .."Duplexní Pupily",
        "{{ArrowUp}} Větší Slzy#{{ArrowUp}} Větší Poškození"
    },
    
    -- Harlequin Baby
    {
        "Vystřelí další střelu na každou stranu",
        "{{ArrowUp}} Větší Poškození"
    },
    
    -- Daddy Longlegs
    {
        "Má šanci dupnout svou hlavou a způsobit 2x normálního poškození#Má šanci dupnout jako Triachnid. Když se tak stane, vystřelí 5 zpomalujících slz do všech směrů",
        "{{ArrowUp}} Vyšší šance na zadupání jako Triachnid a zadupání svojí hlavou#Pokaždé, když dopadne, má šanci zadupat na delší dobu"
    },
    
    -- Sacrificial Dagger
    {
        "{{ArrowUp}} Drobné Větší Poškození#Aplikuje efekt krvácení",
        "{{ArrowUp}} Větší Poškození"
    },
    
    -- Rainbow Baby
    {
        "{{ArrowUp}} Větší Poškození#{{ArrowUp}} Více Slz",
        "Slzy kombinují efekty"
    },
    
    -- Guppy's Hairball
    {
        "Začne na své druhé velikosti#Má šanci vytvořit mouchy, když zabije nepřítele nebo když blokuje střelu",
        "Začne na své třetí velikosti#Vytváří více much, když zabije nepřítele a když blokuje střelu"
    },
    
    -- Dry Baby
    {
        "{{ArrowUp}} Zvyšuje šanci na spuštění efektu Necronomiconu#Když spustí efekt, nepřátelské střely v místnosti jsou zničeny",
        "{{ArrowUp}} Ještě více zvyšuje šanci na spuštění efektu Necronomiconu!#Když spustí efekt, nepřátelské střely v místnosti se změní na kostěné úlomky"
    },
    
    -- Juicy Sack
    {
        "{{ArrowUp}} Větší louže#Vystřeluje vaječné slzy (z Parazitoida ".. Icons.Parasitoid ..") když Izák střílí",
        "Vystřeluje více vaječných slz"
    },
    
    -- Rotten Baby
    {
        "Vytvoří další modrou mušku",
        "Vytvoří náhodnou kobylku"
    },
    
    -- Headless Baby
    {
        "{{ArrowUp}} Větší Poškození louže#{{ArrowUp}} Větší louže",
        "{{ArrowUp}} Větší Poškození louže#Vystřeluje salvu slz, když Izák střílí"
    },
    
    -- Leech
    {
        "{{ArrowUp}} Větší Poškození#Vytvoří louži, když se srazí s nepřítelem",
        "{{ArrowUp}} Větší Poškození#Nepřátele, které zabije, vybuchnou do spousty slz"
    },
    
    -- Lil Brimstone
    {
        "{{ArrowUp}} Větší Poškození",
        "{{ArrowUp}} Drobné Větší Poškození#Lasery vydrží déle#Nabíjí se rychleji"
    },
    
    -- Isaac's Heart
    {
        "{{ArrowUp}} Zkracuje dobu nabíjení#Přibližuje se k hráči, když hráč nestřílí",
        "{{ArrowUp}} Zkracuje dobu nabíjení#Při plném nabití, pokud se nepřítel nebo projektil přiblíží příliš blízko, automaticky aktivuje svůj plně nabitý efekt#Když se toto aktivuje, na chvilku bude mít cooldown, než se bude moci znovu nabít"
    },
    
    -- Sissy Longlegs
    {
        "{{ArrowUp}} +3 Plošné Větší Poškození pro Sissyiny modré pavouky#Modří pavouci Sissy Dlohonožky aplikují okouzlení, když zasáhnou nepřítele",
        "{{ArrowUp}} Prodloužená doba trvání okouzlení#{{ArrowUp}} +2 Flat Plošné Větší Poškození pro modré pavouky#Vytvoří další pavouky"
    },
    
    -- Punching Bag
    {
        "Získá náhodné formy šampionů se speciálními schopnostmi, jako jsou:#"..
        "{{ColorPink}}Růžová{{CR}}: Vystřelí slzu náhodným směrem#"..
        "{{ColorPurple}}Fialová{{CR}}: Tahá nepřátele a střely#"..
        "{{ColorCyan}}Světle Modrá{{CR}}: Když je hráč zasažen, vystřelí slzy do 8 směrů#"..
        "{{ColorCyan}}Modrá{{CR}}: Když je hráč zasažen, vytvoří 2-3 mouchy#"..
        "{{ColorOrange}}Oranžová{{CR}}: Když je hráč zasažen, vytvoří minci#"..
        "Blokuje střely",
        "Získá silnější formy šampionů:#"..
        "{{ColorGreen}}Zelená{{CR}}: Vytvoří zelenou louži#"..
        "{{ColorBlack}}Černá{{CR}}: Vybuchne, když je hráč zasažen. Exploze způsobí 40 poškození#"..
        "{{ColorRainbow}}Duhová{{CR}}: Kopíruje efekt všech ostatních forem šampionů. Vydrží méně času než jiné formy šampionů#"..
        "Uděluje kontaktní poškození"
    },
    
    -- Cain's Other Eye
    {
       --"Vystřelí 2 slzy místo 1#Slzy získávají efekt Gumového Cementu " .. Icons.RubberCement,
       --"{{ArrowUp}}Větší Dostřel#Vystřelí 4 slzy"
    },
    
    -- Incubus
    {
        "{{ArrowUp}} Větší Poškození",
        "{{ArrowUp}} Větší Poškození"
    },
    
    -- Lil Gurdy
    {
        "{{ArrowUp}} Nabíjí se rychleji#Při nabíjení vystřeluje slzy do různých směrů",
        "{{ArrowUp}} Nabíjí se rychleji#Když se rozletí, zanechá po sobě červenou kaluž#Po úprku vystřelí 3 vlny slz v různých směrech"
    },
    
    -- Seraphim
    {
        "Má šanci vystřelit slzu Posvátného Světla (z ".. Icons.HolyLight ..")",
        "{{ArrowUp}} Více Slz#{{ArrowUp}} Vyšší šance na vystřelení slzy Posvátného Světla"
    },
    
    -- Spider Mod
    {
        "Plodí vajíčka, která aplikují náhodný efekt na nepřátele, když po nich projdou#Vejce vydrží 20 sekund",
        "Vyšší šance na vyplození vajec#Na konci místností vajíčka vyplodí modré pavouky"
    },
    
    -- Farting Baby
    {
        "{{ArrowUp}} Zvyšuje šanci na prdění, když dostane zásah#Má šanci prdět každých pár sekund. Čím blíže je k nepřátelům, tím větší šance na prd",
        "{{ArrowUp}} Ještě více zvyšuje šanci na prdění, když dostane zásah!#Získá další hořící prd a svatý prd"
    },
    
    -- Papa Fly
    {
        "Blokuje střely#Při blokování projektilů má šanci vytvořit muší střílnu",
        "{{ArrowUp}} Větší Dostřel#{{ArrowUp}} Vyšší šance na vytvoření muší střílny#Vystřelí 5 slz za sebou"
    },
    
    -- Lil Loki
    {
        "Střílí v 8 směrech",
        "{{ArrowUp}} Větší Poškození"
    },
    
    -- Hushy
    {
        {
            "Každé 4 sekundy vystřelí 15 slz v náhodném kruhovém vzoru#Slzy způsobí 3 poškození",
            "{{ArrowUp}} Větší Poškození#Vytvoří miniizáka po nabíjení po dobu několika sekund (pouze v místnostech s nepřáteli)"
        },
        {
            "Každé 4 sekundy vystřelí 15 slz v náhodném kruhovém vzoru#Slzy způsobí 3 poškození",
            "{{ArrowUp}} Větší Poškození#Vytvoří přátelského Vařáka po nabíjení po dobu několika sekund (pouze v místnostech s nepřáteli)"
        }
    },
    
    -- Lil Monstro
    {
        "Má šanci vystřelit zub (z Tvrdé Lásky ".. Icons.ToughLove ..")",
        "Vystřelí mnohem více slz"
    },
    
    -- Big Chubby
    {
        "Zvyšuje svou velikost a poškození při pojídání střel a při zabíjení nepřátel#Snižuje svoji velikost a poškození v průběhu času a na novém patře",
        "{{ArrowUp}} Snižuje cooldown#Ještě více zvětšuje svou velikost a zároveň uděluje poškození nepřátelům #Už neztrácí bonus poškození na novém patře"
    },
    
    -- Mom's Razor
    {
        "{{ArrowUp}} Prodlužuje trvání krvácení (bossové nejsou ovlivněni)",
        "{{ArrowUp}} Prodlužuje trvání krvácení#Když nepřítel zemře při krvácení, vytvoří velkou louži krve#Má šanci zplodit půl srdce {{HalfHeart}}"
    },
    
    -- Bloodshot Eye
    {
        "Vystřelí tři slzy najednou",
        "Vystřelí krvavý laser místo slz"
    },
    
    -- Buddy in a Box
    {
        "Získává náhodný dodatečný slzný efekt#Další slzný efekt nemůže být Ipekakový, pokud není Ipekak základním útokem spojence",
        "Získává další náhodný dodatečný slzný efekt"
    },
    
    -- Angelic Prism
    {
        "Zatímco hráč střílí slzy ve směru hranolu, přibližuje se k hráči#Slzy, které jím projdou, se změní na spektrální",
        "Přesune se ještě blíže k hráči#Slzy, které jím projdou, získají navádění"
    },
    
    -- Lil Spewer
    {
        "Když vystřelí, vystřelí další slzy s efekty své aktuální barvy",
        "Má dvě barvy zároveň"
    },
    
    -- Pointy Rib
    {
        "Má šanci aplikovat efekt krvácení na ne-bossové nepřátele#Když zabije nepřítele, má šanci vytvořit úlomky kostí",
        "{{ArrowUp}} Větší Poškození při kolizi#{{Arrow Up}} Zvyšuje šanci na aplikaci efektu krvácení#{{Arrow Up}} Zvyšuje šanci na vytvoření úlomků kostí"
    },
    
    -- Paschal Candle
    {
        "Když hráč utrpí poškození, šíří kolem sebe plameny#Množství plamenů závisí na velikosti plamene svíčky",
        "Poškození pouze sníží velikost plamene o jeden krok"
    },
    
    -- Blood Oath
    {
        "Vytvoří červenou kaluž#Kaluž a poškození závisí na počtu odebraných polovičních srdcí {{HalfHeart}}",
        "Když bodne, vytvoří náhodná červená srdce {{Heart}}"
    },
    
    -- Psy Fly
    {
        "Když zablokuje střelu, vystřelí naváděcí slzu zpět",
        "{{ArrowUp}} Větší Poškození při kolizi#{{ArrowUp}} Větší Poškození Slz"
    },
    
    -- Boiled Baby
    {
        "Zvyší množství slz, které vyprskne",
        "Vystřelí slzy ve směru, kterým hráč střílí"
    },
    
    -- Freezer Baby
    {
        "{{ArrowUp}} Větší Poškození#{{ArrowUp}} Větší Dostřel#{{ArrowUp}} Vyšší šance na zmrazení nepřátel",
        "{{ArrowUp}} Větší Poškození#Nepřátelé, které zabíje, explodují do ledových slz"
    },
    
    -- Lil Dumpy
    {
        "Změny na jinou variantu Malého Dumpyho v každé místnosti, jako například:" ..
        "#".. Icons.LilDumpy.DUMPLING .." Standardní efekt"..
        "#".. Icons.LilDumpy.SKINLING .." Otráví nepřátele při prdění"..
        "#".. Icons.LilDumpy.SCABLING .." Když prdne, vystřelí 6 slz v kruhovém vzoru"..
        "#".. Icons.LilDumpy.SCORCHLING .." Když prdne, vytvoří plamen, který způsobí 15poškození"..
        "#".. Icons.LilDumpy.FROSTLING .." Nepřátelé zabití jím se promění v led. Při odpočinku získáš mrazivou auru"..
        "#".. Icons.LilDumpy.DROPLING .." Když prdne, vystřelí slzy opačným směrem",
        "Vrátí se k hráči po náhodném počtu sekund, i když je hráč daleko"
    },
    
    -- Bot Fly
    {
        "{{ArrowUp}} Zvýšení Statů (Dosah, Rychlost Střel, Velikost Slz)#Když vystřelí slzu, laser spojí slzu a spojence#Laser způsobí kontaktní poškození a blokuje výstřely",
        "{{ArrowUp}} Zvýšení Statů#Získá pronikavé slzy#Zřídka útočí na nepřátele"
    },
    
    -- Fruity Plum
    {
        "{{ArrowUp}} Větší Poškození#Získává malý naváděcí efekt",
        "Získá efekt Playdough Sušenky ".. Icons.PlaydoughCookie .."#Po útoku vystřelí slzy na všechny strany"
    },
    
    -- Cube Baby
    {
        "Získá mrazivou auru. Nepřátelé, kteří zůstanou v auře příliš dlouho, budou poškozeni, dokud úplně nezmrznou",
        "Vytvoří kaluž při pohybu#Čím rychleji se pohybuje, tím více kaluží vytváří"
    },
    
    -- Lil Abaddon
    {
        "{{ArrowUp}} Větší Poškození#Když držíš tlačítko střelby, každých pár sekund se spustí vír. Když uvolníš tlačítko střelby, vystřelí prstence z laseru",
        "Vytváří víří častěji#Lasery z vírů způsobují větší poškození, jsou větší a vydrží déle#Má malou šanci zplodit černá srdce {{BlackHeart}}"
    },
    
    -- Vanishing Twin
    {
        "Odebere 25 % zdraví kopie bosse",
        "Zvyšuje šance na vytvoření lepšího předmětu (na základě kvality)#Může vytvořit předměty z Pokladnice, pokud není nalezena žádný předmět ze skupiny Bossových předmětů"
    },
    
    -- Twisted Pair
    {
        "{{ArrowUp}}+0.33 Větší Plošné Poškození#Při střelbě se přibližují k hráči",
        "Zarovnají se v souladu s hráčovým směrem "
    },
    
    -- BBF
    {
        "{{ArrowUp}}Exploze způsobí o 75 více poškození#{{ArrowUp}}Větší výbuchy#{{Warning}}Protože jsou výbuchy větší, mohou zasáhnout Izáka z větší vzdálenosti",
        "Izák neutrpí poškození výbuchem, pokud není příliš blízko"
    },
    
    -- King Baby
    {
        "Summon tears while Isaac is firing",
        "{{ArrowUp}}Tears Up#Each familiars improve in their own way the summoned tear"
    }
}

return familiarsUpgrades