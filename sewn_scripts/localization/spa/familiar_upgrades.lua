--- Translation by Ferpe and Goncholito

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
        "{{ArrowUp}} + Lágrimas",
        "{{ArrowUp}} + Lágrimas#{{ArrowUp}} + Daño"
    },
    
    -- Sister Maggy
    {
        "{{ArrowUp}} + Daño",
        "{{ArrowUp}} + Daño#{{ArrowUp}} + Lágrimas"
    },
    
    -- Dead Cat
    {
        "Al morir, Isaac revivirá con un corazón de alma extra",
        "Al morir, Isaac revivirá con un contenedor de corazón y un corazón de alma extra"
    },
    
    -- Little Chubby
    {
        "Tiempo de espera reducido en un 50%, puede ser lanzado rapidamente.",
        "Se pega a los enemigos por 0,5 segunods y continua en la dirección inicial."
    },
    
    -- Robo Baby
    {
        "{{ArrowUp}} + Lágrimas",
        "{{ArrowUp}} + Lágrimas"
    },
    
    -- Little Gish
    {
        "Las lágrimas crean lagos de creep cuando dan a algo#{{ArrowUp}} + Lágrimas ligeramente",
        "Creep más grande#{{ArrowUp}} + Lágrimas##{{ArrowUp}} + Daño"
    },
    
    -- Little Steven
    {
        "Dar a un enemigo tiene la probabilidad de disparar un aro de lágrimas#Matar a un enemigo tiene la probabilidad de disparar un aro de lágrimas más fuertes#{{ArrowUp}} + Rango#{{ArrowDown}} - Velocidad de Disparo#{{ArrowUp}} + Daño",
        "Aumenta las probabilidades de disparar un aro de lágrimas cuando da/mata un enemigo#Lágrimas del aro pueden actrivar otro aro de lágrimas causando una reacción en cadena#{{ArrowUp}} + Daño"
    },
    
    -- Demon Baby
    {
        "Dispara automáticamente a través de las paredes",
        "{{ArrowUp}} ++ Alcance#{{ArrowUp}} + Lágrimas"
    },
    
    -- Bomb Bag
    {
        "Deja de generar bombas troll#Genera mejores bombas#Genera pólvora en el suelo. La pólvora se enciende al entrar en contacto con fuego o explosiones",
        "Genera mejores bombas#Puede dar Bombas Gigantes [Rep]#Puede explotar al acercarse a un enemigo"
    },
    
    -- The Peeper
    {
        "Dispara 5 lágrimas en diferentes direcciones cada varios segundos.#Intenta acercarse a los enemigos",
        "Spawnea un Ojo de Meador adicional ".. Icons.Peeper .."#El nuevo Ojo de Meador también se mejora.#Con el Ojo Interior ".. Icons.InnerEye ..", spawnea dos Ojos de Meador"
    },
    
    -- Ghost Baby
    {
        "Obtiene lágrimas de Pupila Dobre penetrantes#{{ArrowUp}} + Daño",
        "Las lágrimas son más grandes#{{ArrowUp}} + Daño"
    },
    
    -- Harlequin Baby
    {
        "Dispara una lágrima extra a cada lado",
        "{{ArrowUp}} + Daño"
    },
    
    -- Daddy Longlegs
    {
        "Tiene una probabilidad de caer con la cabeza, haciendo el doble de daño#Tiene una probabilidad de caer como Triácnido. Cuando lo hace, dispara 5 lágrimas ralentizantes en todas direcciones",
        "Aumenta la probabilidad de caer como Triácnido y de caer con la cabeza#Cada vez que cae, puede caer denuevo"
    },
    
    -- Sacrificial Dagger
    {
        "Aplica efecto de sangrado#{{ArrowUp}} + Daño pequeño",
        "{{ArrowUp}} + Daño"
    },
    
    -- Rainbow Baby
    {
        "{{ArrowUp}} + Daño#{{ArrowUp}} + Lágrimas",
        "Las lágrimas combinan efectos"
    },
    
    -- Guppy's Hairball
    {
        "Comienza en el segundo nivel de tamaño#Tiene una probabilidad de generar moscas al matar un enemigo o al bloquear un proyectil",
        "Comienza en el tercer nivel de tamaño#Genera más moscas al matar un enemigo o al bloquear un proyectil"
    },
    
    -- Dry Baby
    {
        "{{ArrowUp}} Aumenta la probabilidad de hacer el efecto del Necronomicón#Al hacer este efecto, todos los proyectiles en la habitación se destruyen",
        "Aumenta aún más la probabilidad de hacer el efecto del Necronomicón#Al hacer este efecto, todos los proyectiles en la habitación se convierten en huesos"
    },
    
    -- Juicy Sack
    {
        "Dispara lágrimas de huevo mientras Isaac dispara#Las lágrimas de huevo generan moscas o arañas azules al golpear algo#Creep más grande",
        "Dispara más lágrimas de huevo"
    },
    
    -- Rotten Baby
    {
        "Spawnea una mosca azul adicional",
        "Spawnea una langosta aleatoria"
    },
    
    -- Headless Baby
    {
        "Genera creep más grande#{{ArrowUp}} El creep hace más daño",
        "Dispara lágrimas mientras Isaac dispare#{{ArrowUp}} El creep hace más daño"
    },
    
    -- Leech
    {
        "Genera creep al tocar un enemigo#{{ArrowUp}} + Daño",
        "Los enemigos que mate explotan en lágrimas#{{ArrowUp}} + Daño"
    },
    
    -- Lil Brimstone
    {
        "{{ArrowUp}} + Daño",
        "{{ArrowUp}} + Daño ligeramente#Los laseres se quedan más tiempo#Carga más rapido"
    },
    
    -- Isaac's Heart
    {
        "Se acerca a Isaac cuando no dispara#Reduce el tiempo de carga",
        "Al cargarse del todo, si un enemigo o proyectil se acerca mucho se activa automáticamente#Al activarse, deberá reposar momentaneamente antes de cargar denuevo#Reduce el tiempo de carga"
    },
    
    -- Sissy Longlegs
    {
        "Las arañas de Sissy aplican encanto cuando le dan a un enemigo#Cuando le dan a un enemigo, hacen daño plano adicional",
        "Spawnea arañs adicionales#Aumenta el daño del encanto y añade daño plano para las arañas azules"
    },
    
    -- Punching Bag
    {
        "Gana formas champion aleatorias con cada abilidad especial#Rosa : Dispara una lágrima en una dirección aleatoria#Violeta : Empuja enemigos y lágrimas#Azul Claro : Dispara lágrimas en 8 direcciones cuando hacen daño al jugador#Azul : Spawnea entre 2 y 3 moscas azules cuando el jugador se hace daño#Naranja: Spawnea una moneda cuando el jugador se hace daño#Bloquea lágrimas",
        "Gana formas champion más poderosas :#Verde : Spawnea creep verde#Negro : Explota cuando el jugador recibe daño. La explosión hace 40 de daño#Arcoíris : Copia los efectos de todas las otras formas champion. Dura menos tieme que las otras formas#Hace daño por contacto"
    },
    
    -- Cain's Other Eye
    {
        --"Dispara dos lágrimas en lugar de una#Las lágrimas reciben el efecto de Cemento Elástico " .. Icons.RubberCement,
        --"Dispara cuatro lágrimas#+ Alcance"
    },
    
    -- Incubus
    {
        "{{ArrowUp}} + Daño",
        "{{ArrowUp}} + Daño"
    },
    
    -- Lil Gurdy
    {
        "{{ArrowUp}} Puede recargase más rápido#Mientras carga, dispara lágrimas en diferentes direcciones",
        "{{ArrowUp}} Puede recargase más rápido#Cuando embiesta, suelta creep rojo#Dispara 3 olas de lágrimas después de embestir en direcciones diferentes"
    },
    
    -- Seraphim
    {
        "Tiene una probabilidad de disparar Lágrimas Sagradas",
        "Tiene una probabilidad más alta de disparar Lágrimas Sagradas#{{ArrowUp}} + Lágrimas"
    },
    
    -- Spider Mod
    {
        "Spawnea huevos que aplican efectos aleatorios a enemigos que pasan sobre ellos#Los huevos duran 20 segundos",
        "Alta probabilidad de spawnear huevos#Al final de las habitaciiones, los huevos spawnean arañas azules"
    },
    
    -- Farting Baby
    {
        "{{ArrowUp}} Aumenta la probabilidad de tirarse un pedo al ser golpeado#Tiene una probabilidad de tirarse un pedo. Entre más cerca esté de un enemigo, mayor es la probabilidad de tirarse un pedo.",
        "{{ArrowUp}} Aumenta la probabilidad de tirarse un pedo#Puede tirarse pedos ígneos o santos."
    },
    
    -- Papa Fly
    {
        "Bloquea proyectiles#Tiene una probabilidad de spawnear una mosca torreta cuando bloquea un proyectil",
        "Dispara 5 lágrimas de una#{{ArrowUp}} + Rango#Alta probabilidad de spawnear una mosca torreta"
    },
    
    -- Lil Loki
    {
        "Dispara en 8 direcciones",
        "{{ArrowUp}} + Daño"
    },
    
    -- Hushy
    {
        {
            "Dispara 15 lágrimas en un patrón circular cada 4 segundos#Las lágrimas tienen 3 de daño",
            "Genera Mini-Isaacs luego de cargar por unos segundos (solo en habitaciones con enemigos)#{{ArrowUp}} + Daño"
        },
        {
            "Dispara 15 lágrimas en un patrón circular cada 4 segundos#Las lágrimas tienen 3 de daño",
            "Genera un Bolo amistoso cada pocos segundos (solo en habitaciones con enemigos)#{{ArrowUp}} + Daño"
        }
    },
    
    -- Lil Monstro
    {
        "Hay una probabilidad de disparar un diente#El diente hara x3.2 más daño que de normal",
        "Dispara más lágrimas"
    },
    
    -- Big Chubby
    {
        "Aumenta su tamaño y daño al comer proyectiles y al matar monstruos#Su tamaño se reduce con el tiempo y al bajar de planta",
        "Aumenta aún más su tamaño al dañar enemigos#Ya no pierde el daño extra al cambiar de planta#{{ArrowUp}} Espera menos para atacar"
    },
    
    -- Mom's Razor
    {
        "{{ArrowUp}} Extiende la duración de sangrado. A los jefes no les afecta.",
        "Cuando un enemigo muere mientras sangra, spawnea un gran lago de sangre.#Tiene una probabilidad de spawnear medio corazón.#{{ArrowUp}} Extiende la duración de sangrado"
    },
    
    -- Bloodshot Eye
    {
        "Dispara tres lágrimas a la vez",
        "Dispara un láser de sangre en lugar de lágrimas"
    },
    
    -- Buddy in a Box
    {
        "Recibe un efecto extra#Este efecto no puede ser Ipecac",
        "Recibe otro efecto extra"
    },
    
    -- Angelic Prism
    {
        "Al disparar en la misma dirección que el prisma, este se acerca a Isaac#Las lágrimas que pasen a través del prisma se vuelven espectrales",
        "Se acerca aún más a Isaac#Las lágrimas que pasen a través del prisma se harán teledirigidas"
    },
    
    -- Lil Spewer
    {
        "Cuando dispara, tira lágrimas adicionales con efectos que dependen del color",
        "Tiene 2 colores al mismo tiempo"
    },
    
    -- Pointy Rib
    {
        "Hay una probabilidad de aplicar efecto de sangrado a enemigos que no sean bosses#Tiene la probabilidad de spawnear huesos cuando matas un enemigo",
        "Incrementa las probabilidades de aplicar sangrado y spawnear huesos#Incrementa el daño de colisión"
    },
    
    -- Paschal Candle
    {
        "Cuando al jugador le hacen daño, dispara llamas alrededor#La cantidad de llamas depende del tamaño de la llama de la vela",
        "Hacerte daño solo reduce el tamaño de la vela por 1"
    },
    
    -- Blood Oath
    {
        "Genera creep rojo#La cantidad y el daño del creep depende de la cantidad de mitades de corazón removidas",
        "Al clavar a Isaac, genera corazones rojos al azar"
    },
    
    -- Psy Fly
    {
        "Cuando bloquea una lágrima, dispara una lágrima teledirigida en la dirección opuesta",
        "{{ArrowUp}} + Daño (colisión y lágrimas)"
    },
    
    -- Boiled Baby
    {
        "Aumenta la cantidad de lágrimas que dispara",
        "Dispara en la dirección que Isaac esté disparando"
    },
    
    -- Freezer Baby
    {
        "{{ArrowUp}} + Daño#{{ArrowUp}} + Alcance#Aumenta la probabilidad de congelar enemigos",
        "Los enemigos que mate explotan en lágrimas de hielo#{{ArrowUp}} + Daño"
    },
    
    -- Lil Dumpy
    {
        "Cambia a otra variante de Pequeño Dumpy como : " ..
        "#".. Icons.LilDumpy.DUMPLING .." Efecto estandar."..
        "#".. Icons.LilDumpy.SKINLING .." Envenena enemigos cuando se tira pedos."..
        "#".. Icons.LilDumpy.SCABLING .." Cuando se tira un pedo, dispara 6 lágrimas en un patrón circular."..
        "#".. Icons.LilDumpy.SCORCHLING .." Cuando se tira un pedo, spawnea una llama que hace 15 de daño."..
        "#".. Icons.LilDumpy.FROSTLING .." Los enemigos matados se convierten en hielo. Mientras descansa, gana un aura congelador."..
        "#".. Icons.LilDumpy.DROPLING .." Cuando se tira un pedo, dispara lágrimas en la dirección opuesta.",
        "Vuelve al jugador después de una cantidad aleatoria de segundos, incluso si el jugador está lejos."
    },
    
    -- Bot Fly
    {
        "Las lágrimas que dispare se conectarán al familiar con un láser#Este láser hace daño y bloquea disparos#{{ArrowUp}} Mejora estadísticas (Alcance, Velocidad de Disparo, Tamaño de Lágrima)",
        "{{ArrowUp}} Mejora estadísticas#Las lágrimas se vuelven penetrantes#A veces ataca a los enemigos"
    },
    
    -- Fruity Plum
    {
        "{{ArrowUp}} + Daño#Leve efecto teledirigido",
        "Obtiene el efecto de la Galleta De Plastilina ".. Icons.PlaydoughCookie .."#Luego de atacar, dispara en todas direcciones"
    },
    
    -- Cube Baby
    {
        "Obtiene un aura congelante. Los enemigos que estén en el aura por mucho tiempo recibirán daño hasta congelarse",
        "Genera creep al ser movido#Entre más rápido se mueva, más creep generará"
    },
    
    -- Lil Abaddon
    {
        "{{ArrowUp}} + Daño#Cuando aprietas el botón de disparar, spawnea un remolino cada pocos segundos cuando se suelta el botón, un aro de laser es disparado por los remolinos",
        "Spawns swirls more often#Lasers from swirls deal more damage, are larger and last longer#Has a tiny chance to spawn black hearts {{BlackHeart}}"
    },
    
    -- Vanishing Twin
    {
        "Quita el 25% de la vida de la copia del boss",
        "Sube la probabilidad de spawnear un item mejor (basado en la Calidad)#Puede spawnear items que vienen de la sala del tesoro si no se encuentran items del boss"
    },
    
    -- Twisted Pair
    {
        "Se mueven más cerca al jugador cuando disparan#+0,33 Daño",
        "Se alinean con la posición del jugador"
    },
    
    -- BBF
    {
        "",
        ""
    },
    
    -- King Baby
    {
        "Summon tears while Isaac is firing",
        "{{ArrowUp}}Tears Up#Each familiars improve in their own way the summoned tear"
    }
}

return familiarsUpgrades