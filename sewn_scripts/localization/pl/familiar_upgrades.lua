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
        "{{ArrowUp}} Zwiększona prędkość ataku",
        "{{ArrowUp}} Zwiększona prędkość ataku#{{ArrowUp}} Zwiększone obrażenia"
    },
    
    -- Sister Maggy
    {
        "{{ArrowUp}} Zwiększone obrażenia",
        "{{ArrowUp}} Zwiększone obrażenia#{{ArrowUp}} Zwiększona prędkość ataku"
    },
    
    -- Dead Cat
    {
        "Jeśli gracz zginie, wraca do życia z dodatkowym duchowym sercem {{SoulHeart}}",
        "Jeśli gracz zginie, wraca do życia z dodatkowym pojemnikiem na czerwone serce {{Heart}} i dodatkowym duchowym sercem {{SoulHeart}}"
    },
    
    -- Little Chubby
    {
        "{{ArrowUp}} Czas oczekiwania mniejszy o 50%, może być szybko rzuconym",
        "Przyczepia się do przeciwników na 0.5 sekund a potem kontynuuje lecieć w jego początkową stronę"
    },
    
    -- Robo Baby
    {
        "{{ArrowUp}} Zwiększona prędkość ataku",
        "{{ArrowUp}} Zwiększona prędkość ataku"
    },
    
    -- Little Gish
    {
        "{{ArrowUp}} Lekko zwiększona prędkość ataku#Łzy tworzą kałżę spowalniającej cieczy gdy trafią",
        "{{ArrowUp}} Zwiękoszne obrażenia#{{ArrowUp}} Zwiększona prędkość ataku#{{ArrowUp}} Zwiększony rozmiar kałuży"
    },
    
    -- Little Steven
    {
        "{{ArrowUp}} Zwiększone obrażenia#{{ArrowUp}} Zwiększony zasięg#{{ArrowDown}} Zmniejszona prędkość pocisku#Trafienie przeciwnika ma szansę na wystrzelenie okręgu łez#Zabicie przeciwnika ma szansę na wystrzelenie okręgu mocniejszych łez",
        "{{ArrowUp}} Zwiększone obrażenia#{{ArrowUp}} Zwiększona szansa na wystrzelenie okręgu łez przy trafieniu/zabicia przeciwników#Łzy z okręgu mają szansę na wystrzelenie kolejnego okręgu łez, skutkując w reakcji łańcuchowej"
    },
    
    -- Demon Baby
    {
        "Automatycznie strzela przez przeszkody",
        "{{ArrowUp}} Zwiększony zasięg#{{ArrowUp}} Zwiększona prędkość ataku"
    },
    
    -- Bomb Bag
    {
        "{{ArrowUp}} Wypadają lepsze bomby#Już nie tworzy troll bomb#Tworzy proch na ziemi. Proch zapala się gdy jest blisko ognia lub eksplozji",
        "{{ArrowUp}} Wypadają lepsze bomby#{{ArrowUp}} Może dać Giga Bomby [Rep]#Jeśli jest blisko przeciwnika, może czasem wybuchąć"
    },
    
    -- The Peeper
    {
        "Wystrzeliwuje 5 łez w dowolnych kierunkach co kilka sekund#Stara się zbliżać do bliskich przeciwników",
        "Tworzy dodatkowego Peepera ".. Icons.Peeper .."#Nowy Peeper jest również wzmocniony#za pomocą Inner Eye ".. Icons.InnerEye .." tworzy dodatkowe Oko Peepera"
    },
    
    -- Ghost Baby
    {
        "{{ArrowUp}} Zwiększone obrażenia#Zyskuje przebicie i efekt Pupula Duplex ".. Icons.PupulaDuplex .." łzy",
        "{{ArrowUp}} Zwiększony rozmiar łez#{{ArrowUp}} Zwiększone obrażenia"
    },
    
    -- Harlequin Baby
    {
        "Wystrzeliwuje dodatkową łzę po każdej stronie",
        "{{ArrowUp}} Zwiększone obrażenia"
    },
    
    -- Daddy Longlegs
    {
        "Ma szansę uderzyć głową, zadając 2x podstawowe obrażenia#Ma szansę uderzyć jako Triachnid. Jeśli to zrobi, wystrzeli 5 spowalniających łez we wszystkie strony",
        "{{ArrowUp}} Większa szansa na uderzenie jako Triachnid i uderzenie głową#Za każdym razem gdy uderzy, ma szansę zrobić to jeszcze raz"
    },
    
    -- Sacrificial Dagger
    {
        "{{ArrowUp}} Lekko zwiększone obrażenia#Nakłada efekt krwawienia",
        "{{ArrowUp}} Zwiększone obrażenia"
    },
    
    -- Rainbow Baby
    {
        "{{ArrowUp}} Zwiększone obrażenia#{{ArrowUp}} Zwiększona prędkość ataku",
        "Łzy mają połączone efekty"
    },
    
    -- Guppy's Hairball
    {
        "Zaczyna na drugim poziomie rozmiaru#Ma szansę stworzyć muchy gdy zabije przeciwnika lub zablokuje pocisk",
        "Zaczyna na trzecim poziomie rozmiaru#Tworzy więcej much gdy zabije przeciwnika lub zablokuje pocisk"
    },
    
    -- Dry Baby
    {
        "{{ArrowUp}} Zwiększa szansę na aktywację efektu Necronomiconu#Jak efekt się aktywuje, pociski przeciwników w pokoju są zniszczone",
        "{{ArrowUp}} Jeszcze większa szansa na aktywację efektu Necronomiconu#Jak efekt się aktywuje, pociski przeciwników zostają zamienione na fragmenty kości"
    },
    
    -- Juicy Sack
    {
        "{{Arrow Up}} Zwiększony rozmiar kałuży#Wystrzeliwuje łzy jajka (z Parasitoid ".. Icons.Parasitoid ..") gdy Issac strzela",
        "Fires more egg tears"
    },
    
    -- Rotten Baby
    {
        "Tworzy dodatkową niebieską muchę",
        "Tworzy dowolną szarańczę"
    },
    
    -- Headless Baby
    {
        "{{ArrowUp}} Zwiększone obrażenia kałuży#{{ArrowUp}} Zwiększony rozmiar kałuży",
        "{{ArrowUp}} Zwiększone obrażenia kałuży#Wystrzeliwuje serię łez gdy Isaac strzela"
    },
    
    -- Leech
    {
        "{{ArrowUp}} Zwiększone obrażenia#Tworzy kałużę gdy wchodzi w kontakt z przeciwnikiem",
        "{{ArrowUp}} Zwiększone obrażenia#Przeciwnicy których zabija wybuchają dużą ilością łez"
    },
    
    -- Lil Brimstone
    {
        "{{ArrowUp}} Zwiększone obrażenia",
        "{{ArrowUp}} Lekko zwiększone obrażenia#Laser trwa dłużej#Ładuje się szybciej"
    },
    
    -- Isaac's Heart
    {
        "{{ArrowUp}} Szybciej się ładuje#Zbliża się do gracza gdy on nie strzela",
        "{{ArrowUp}} Szybciej się ładuje#Gdy w pełni się naładuje, jeśli przeciwnik lub pocisk się za bardzo zbliży do Serca to automatycznie aktywuje jego w pełni naładowany efekt#Gdy to się stanie to trzeba poczekać chwilę aby znowu naładować efekt Serca"
    },
    
    -- Sissy Longlegs
    {
        "{{ArrowUp}} +3 stałe obrażenia dla niebieskich pająków Sissy#Niebieskie pająki Sissy nakładają efekt zauroczenia gdy trafią przeciwnika",
        "{{ArrowUp}} Zwiększony czas trwania zauroczenia#{{ArrowUp}} +2 stałe obrażenia dla niebieskich pająków#Tworzy dodatkowe niebieskie pająki"
    },
    
    -- Punching Bag
    {
        "Gains random champion forms each with special abilities, such asZyskuje różne formy czempiona ze specjalnymi umiejętnościami takimi jak:#"..
        "{{ColorPink}}Rózowy{{CR}}: Strzela łzę w dowolną stronę#"..
        "{{ColorPurple}}Fiołkowy{{CR}}: Przyciąga przeciwników i pociski#"..
        "{{ColorCyan}}Błękitny{{CR}}: Wystrzeliwuje łzy w 8 stron gdy gracz zostanie trafiony#"..
        "{{ColorCyan}}Niebieski{{CR}}: Tworzy 2-3 niebieskie muchy gdy gracz zostanie trafiony#"..
        "{{ColorOrange}}Pomarańczowy{{CR}}: Tworzy monetę gdy gracz zostanie trafiony#"..
        "Blokuje pociski",
        "Zyskuje mocniejsze formy czempiona:#"..
        "{{ColorGreen}}Zielony{{CR}}: Tworzy zieloną kałużę#"..
        "{{ColorBlack}}Czarny{{CR}}: Wybucha gdy gracz zostanie trafiony. Wybuch zadaje 40 obrażeń#"..
        "{{ColorRainbow}}Tęczowy{{CR}}: Kopiuje efekt każdej innej formy. Trwa dłużej niż w poprzednich formach#"..
        "Zadaje obrażenia kontaktowe"
    },
    
    -- Cain's Other Eye
    {
        "Wystrzeliwuje 2 łzy zamiast 1#Łzy zyskują efekt Rubber Cementu " .. Icons.RubberCement,
        "{{ArrowUp}}Zwiększony zasięg#Wystrzeliwuje 4 łzy"
    },
    
    -- Incubus
    {
        "{{ArrowUp}} Zwiększone obrażenia",
        "{{ArrowUp}} Zwiększone obrażenia"
    },
    
    -- Lil Gurdy
    {
        "{{ArrowUp}} Szybciej się ładuje#Gdy się ładuje, wystrzeliwuje łzę w innym kierunku",
        "{{ArrowUp}} Szybciej się ładuje#Gdy szarżuje, pozostawia czerwoną kałużę za sobą#Wystrzeliwuje 3 fale łez w innych kierunkach po szarży"
    },
    
    -- Seraphim
    {
        "Ma szansę wystrzelić święte łzy (z ".. Icons.HolyLight ..")",
        "{{ArrowUp}} Zwiększona prędkość ataku#{{ArrowUp}} Większa szansa na wystrzelenie świętych łez"
    },
    
    -- Spider Mod
    {
        "Tworzy jajka które nakładają dowolny efekt na przeciwników którzy na nie ustaną#Jajka trwają 20 sekund",
        "Większa szansa na stworzenie jajek#Po ukończeniu pokoju, jajka tworzą niebieskie pająki"
    },
    
    -- Farting Baby
    {
        "{{ArrowUp}} Zwiększona szansa na pierdnięcie gdy zostanie trafiony#Ma szansę pierdnąć co kilka sekund. Im bliżej jest przeciwników, tym większa szansa na pierdnięcie",
        "{{ArrowUp}} Jeszcze większa szansa na pierdnięcie gdy zostanie trafiony!#Zyskuje dodatkową szansę na ogniste pierdnięcie i święte pierdnięcie"
    },
    
    -- Papa Fly
    {
        "Blokuje pociski#sMa szansę na stworzenie strzelającej muchy gdy blokuje pociski",
        "{{ArrowUp}} Zwiększony zasięg#{{ArrowUp}} Zwiększona szansa na stworzenie strzelającej muchy#Strzela pięcioma łzami pod rząd"
    },
    
    -- Lil Loki
    {
        "Strzela w 8 stron",
        "{{ArrowUp}} Zwiększone obrażenia"
    },
    
    -- Hushy
    {
        {
            "Wystrzeliwuje 15 łez w dowolnym kolistym wzorze co 4 sekundy#Łzy zadają 3 punkty obrażeń",
            "{{ArrowUp}} Zwiększone obrażenia#Tworzy miniaaca po ładowaniu przez kilka sekund (tylko w pokojach z przeciwnikami)"
        },
        {
            "Wystrzeliwuje 15 łez w dowolnym kolistym wzorze co 4 sekundy#Łzy zadają 3 punkty obrażeń.",
            "{{ArrowUp}} Zwiększone obrażenia#Tworzy przyjaznego boila po ładowaniu przez kilka sekund (tylko w pokojach z przeciwnikami)"
        }
    },
    
    -- Lil Monstro
    {
        "Ma szansę wystrzelić ząb (z Tough Love ".. Icons.ToughLove,
        "Wystrzeliwuje znacznie więcej łez"
    },
    
    -- Big Chubby
    {
        "Zwiększa jego rozmiar i obrażenia gdy zjada pociski i zabija przeciwników#Z czasem zmniejsza jego rozmiar i obrażenia oraz na początku nowego piętra",
        "{{ArrowUp}} Zmniejszony czas ładowania#Zwiększa rozmiar jeszcze bardziej gdy zadaje obrażenia#ie traci bonusowych obrażeń na nowym piętrze"
    },
    
    -- Mom's Razor
    {
        "{{ArrowUp}} Wydłuża czas trwania krwawienia (Bossowie temu nie podlegają)",
        "{{ArrowUp}} Wydłuża czas trwania krwawienia#Gdy przeciwnik zginie krwawiąc to tworzy dużą kałużę krwi#Ma szansę stworzyć połowę serca {{HalfHeart}}"
    },
    
    -- Bloodshot Eye
    {
        "Wystrzeliwuje trzy łzy na raz",
        "Wystrzeliwuje laser krwi zamiast łez"
    },
    
    -- Buddy in a Box
    {
        "Zyskuje dowolny dodatkowy efekt łez#Dodatkowy efekt łzy nie może być Ipecac'iem jeżeli nie jest on jego podstawowym atakiem Buddy'ego",
        "Zyskuje kolejny dodatkowy efekt łez"
    },
    
    -- Angelic Prism
    {
        "Gdy gracz wystrzeliwuje łzy w stronę pryzmatu, to zbliża on się do gracza#Łzy które przenikają przez niego stają się duchowe",
        "Jeszcze bardziej się zbliża do gracza#Łzy które przez niego przenikają stają się namierzające"
    },
    
    -- Lil Spewer
    {
        "Gdy strzela, wystrzeliwuje dodatkowe łzy z efektem jego obecnego koloru",
        "Ma dwa kolory na raz"
    },
    
    -- Pointy Rib
    {
        "Ma szansę nałozyć efekt krwawienia na zwykłych przeciwników#Ma szansę stworzyć fragmenty kości przy zabiciu przeciwnika",
        "{{ArrowUp}} Zwiększone obrażenia kontaktowe#{{Arrow Up}} IZwiększa szansę na krwawienie#{{Arrow Up}} Zwiększa szansę na stworzenie fragmentów kości"
    },
    
    -- Paschal Candle
    {
        "Gdy gracz zostanie zraniony, wysyła płomienie wokół siebie#Ilość płomienie zależy od rozmiaru ognia świeczki",
        "Dostanie obrażeń obniża rozmiar ognia świeczki tylko o 1 poziom"
    },
    
    -- Blood Oath
    {
        "Tworzy kałużę krwi#Częstotliwość kałuży i jej obrażenia zależą od połówek serc {{HalfHeart}} które zostały usunięte",
        "Gdy dźgnie, tworzy dowolne czerwone serca {{Heart}}"
    },
    
    -- Psy Fly
    {
        "Gdy zablokuje pocisk, wystrzeliwuje go z powrotem i efektem namierzania",
        "{{ArrowUp}} Zwiększone obrażenia kontaktowe#{{ArrowUp}} Zwiększone obrażenia łez"
    },
    
    -- Boiled Baby
    {
        "Zwiększa ilość łez które wystrzeliwuje",
        "Strzela łzami w tym samym kierunku co gracz"
    },
    
    -- Freezer Baby
    {
        "{{ArrowUp}} Zwiększone obrażenia#{{ArrowUp}} Zwiększony zasięg#{{ArrowUp}} Większa szansa na zamrożenie przeciwników",
        "{{ArrowUp}} Zwiększone obrażenia#Przeciwnicy których zabije wybuchają lodowymi łzami"
    },
    
    -- Lil Dumpy
    {
        "Co pokój zmienia formę Lil Dumpy'ego:" ..
        "#".. Icons.LilDumpy.DUMPLING .." Podstawowy efekt"..
        "#".. Icons.LilDumpy.SKINLING .." Zatruwa przeciwników przy pierdnięciu"..
        "#".. Icons.LilDumpy.SCABLING .." Gdy pierdzi, wystrzeliwuje okrąg 6 łez"..
        "#".. Icons.LilDumpy.SCORCHLING .." Gdy pierdzi, tworzy płomień zadający 15 obrażeń"..
        "#".. Icons.LilDumpy.FROSTLING .." Gdy zabije przeciwnika to go zamraża. Gdy odpoczywa to ma lodową aurę"..
        "#".. Icons.LilDumpy.DROPLING .." Gdy pierdzi, strzela łzą w przeciwnym kierunku",
        "Wraca do gracza po dowolnym czasie, nawet gdy gracz jest daleko"
    },
    
    -- Bot Fly
    {
        "{{ArrowUp}} Zwiększone statystyki (Zasięg, prędkość pocisku, rozmiar ataku)#Gdy wystrzeliwuje łzę, laser łączy jego i jego łzy#Zadaje on obrażenia i blokuje pociski",
        "{{ArrowUp}} Zwiększone statystyki#Zyskuje przebicie#Rzadko atakuje przeciwników"
    },
    
    -- Fruity Plum
    {
        "{{ArrowUp}} Zwiększone obrażenia#Ma lekki efekt namierzania",
        "Zyskuje efekt Playdough Cookie ".. Icons.PlaydoughCookie .."#Po ataku strzela łzami w każdą stronę"
    },
    
    -- Cube Baby
    {
        "Zyskuje lodową aurę. Jeśli przeciwnik jest w niej za długo to dostaje obrażenia dopóki nie zamarznie",
        "Tworzy kałużę gdy się porusza#Im szybciej się porusza tym więcej kałuż tworzy"
    },
    
    -- Lil Abaddon
    {
        "{{ArrowUp}} Zwiększone obrażenia#Gdy trzymasz przycisk strzelania, tworzy wir co kilka sekund. Gdy go puścisz, laserowy okrąg powstaje z nich",
        "Częściej tworzy wiry#Lasery z wirów zadają więcej obrażeń, są większe i trwają dłużej#Ma małą szansę na stworzenie czarnego serca{{BlackHeart}}"
    },
    
    -- Vanishing Twin
    {
        "Kopia bossa ma 25% mniej hp",
        "Zwiększa szansę na lepszy przedmiot (zależne od jakości)#Tworzy przedmioty z zasobu skarbca jeśli zasób bossa się skończy"
    },
    
    -- Twisted Pair
    {
        "{{ArrowUp}}Obrażenia zwiększone o stałe +0,33#Zbliżają się do gracza gdy strzelają",
        "Pokrywają się z kierunkiem gracza"
    },
    
    -- BBF
    {
        "{{ArrowUp}}Wybuchy zadają o 75 więcej obrażeń#{{ArrowUp}}Większe wybuchy#{{Uwaga}}Rozmiar sprawia, że Isaac może być łatwiej trafiony",
        "Isaac nie dostaje obrażeń od wybuchu jeśli nie jest zbyt blisko centrum"
    },
}

return familiarsUpgrades