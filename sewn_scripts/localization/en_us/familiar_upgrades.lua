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
        "{{ArrowUp}} Tears Up",
        "{{ArrowUp}} Tears Up#{{ArrowUp}} Damage Up"
    },
    
    -- Sister Maggy
    {
        "{{ArrowUp}} Damage Up",
        "{{ArrowUp}} Damage Up#{{ArrowUp}} Tears Up"
    },
    
    -- Dead Cat
    {
        "When the player dies, they respawn with an additional soul heart {{SoulHeart}}",
        "When the player dies, they respawn with an additional red heart container {{Heart}} and an additional soul heart {{SoulHeart}}"
    },
    
    -- Little Chubby
    {
        "{{ArrowUp}} Lower cooldown by 50%, can be thrown quickly",
        "Sticks to enemies for 0.5 seconds then continues in its initial direction"
    },
    
    -- Robo Baby
    {
        "{{ArrowUp}} Tears Up",
        "{{ArrowUp}} Tears Up"
    },
    
    -- Little Gish
    {
        "{{ArrowUp}} Slight Tears Up#Tears create a puddle of slowing creep on hit",
        "{{ArrowUp}} Damage Up#{{ArrowUp}} Tears Up#{{ArrowUp}} Creep Size Up"
    },
    
    -- Little Steven
    {
        "{{ArrowUp}} Damage Up#{{ArrowUp}} Range Up#{{ArrowDown}} Shot Speed Down#Hitting an enemy has a chance to fire a ring of tears#Killing an enemy has a chance to fire a ring of stronger tears",
        "{{ArrowUp}} Damage Up#{{ArrowUp}} Increases chance to fire a ring of tears when hitting/killing enemies#Tears from the ring can trigger another ring of tear, resulting in a chain reaction"
    },
    
    -- Demon Baby
    {
        "Fires automatically through obstacles",
        "{{ArrowUp}} Range up#{{ArrowUp}} Tears Up"
    },
    
    -- Bomb Bag
    {
        "{{ArrowUp}} Better bomb drops#No longer spawns troll bombs#Spawn powder on the ground. The powder catches fire when it's close to fires or explosions",
        "{{ArrowUp}} Better bomb drops#{{ArrowUp}} Can drop Giga bombs [Rep]#When it's close to an enemy, it will sometimes explode"
    },
    
    -- The Peeper
    {
        "Fire 5 tears in random directions every few seconds#Tries to home onto close enemies",
        "Spawn an additional Peeper Eye ".. Icons.Peeper .."#The new Peeper Eye is upgraded as well#With Inner Eye ".. Icons.InnerEye .." spawns an additional Peeper Eye"
    },
    
    -- Ghost Baby
    {
        "{{ArrowUp}} Damage Up#Gain piercing Pupula Duplex ".. Icons.PupulaDuplex .." tears",
        "{{ArrowUp}} Tear Size Up#{{ArrowUp}} Damage Up"
    },
    
    -- Harlequin Baby
    {
        "Fire an additional shot on each side",
        "{{ArrowUp}} Damage Up"
    },
    
    -- Daddy Longlegs
    {
        "Has a chance to stomp with the head, dealing 2x the normal damage#Has a chance to stomp as Triachnid. When it does, fires 5 slowing tears in all directions",
        "{{ArrowUp}} Higher chance to stomp as Triachnid and to stomp with the head#Each time it falls, has a chance to stomps an additional time"
    },
    
    -- Sacrificial Dagger
    {
        "{{ArrowUp}} Slight Damage Up#Applies a bleed effect",
        "{{ArrowUp}} Damage Up"
    },
    
    -- Rainbow Baby
    {
        "{{ArrowUp}} Damage Up#{{ArrowUp}} Tears Up",
        "Tears combine effects"
    },
    
    -- Guppy's Hairball
    {
        "Start on the second size#Have a chance to spawn flies when it kills an enemy or when it blocks a projectile",
        "Start on the third size#Spawns more flies when it kills an enemy and when it blocks projectiles"
    },
    
    -- Dry Baby
    {
        "{{ArrowUp}} Increases chance to trigger Necronomicon effect#When it triggers the effect, enemy projectiles in the room are destroyed",
        "{{ArrowUp}} Increases chance to trigger Necronomicon effect even more!#When it triggers the effect, enemy projectiles in the room are turned into bone shards"
    },
    
    -- Juicy Sack
    {
        "{{Arrow Up}} Creep Size Up#Fires egg tears (from Parasitoid ".. Icons.Parasitoid ..") while isaac is firing",
        "Fires more egg tears"
    },
    
    -- Rotten Baby
    {
        "Spawns an additional blue fly",
        "Spawns a random locust"
    },
    
    -- Headless Baby
    {
        "{{ArrowUp}} Creep Damage Up#{{ArrowUp}} Creep Size Up",
        "{{ArrowUp}} Creep Damage Up#Fires burst of tears while isaac is firing"
    },
    
    -- Leech
    {
        "{{ArrowUp}} Damage Up#Spawns creep when it collide with an enemy",
        "{{ArrowUp}} Damage Up#Enemies it kills explode into lots of tears"
    },
    
    -- Lil Brimstone
    {
        "{{ArrowUp}} Damage Up",
        "{{ArrowUp}} Slight Damage Up#Laser lasts longer#Charges quicker"
    },
    
    -- Isaac's Heart
    {
        "{{ArrowUp}} Decreases charge time#Moves closer to the player when the player isn't firing",
        "{{ArrowUp}} Decreases charge time#When fully charged, if an enemy or projectile gets too close it automatically activates its fully charged effect#When this activates, it will go on a brief cooldown before being able to charge again"
    },
    
    -- Sissy Longlegs
    {
        "{{ArrowUp}} +3 Flat Damage Up for Sissy's blue spiders#Sissy's blue spiders apply charm when they hit an enemy",
        "{{ArrowUp}} Increased charm duration#{{ArrowUp}} +2 Flat Damage Up for blue spiders#Spawns additional spiders"
    },
    
    -- Punching Bag
    {
        "Gains random champion forms each with special abilities, such as:#"..
        "{{ColorPink}}Pink{{CR}}: Fires a tear in a random direction#"..
        "{{ColorPurple}}Violet{{CR}}: Pulls enemies and bullets#"..
        "{{ColorCyan}}Light Blue{{CR}}: Fires tears in 8 directions when player gets hit#"..
        "{{ColorCyan}}Blue{{CR}}: Spawns 2-3 flies when player gets hit#"..
        "{{ColorOrange}}Orange{{CR}}: Spawns a coin when player get hit#"..
        "Blocks bullets",
        "Gain more powerful champion forms:#"..
        "{{ColorGreen}}Green{{CR}}: Spawns green creep#"..
        "{{ColorBlack}}Black{{CR}}: Explodes when the player gets hit. Explosion deal 40 damage#"..
        "{{ColorRainbow}}Rainbow{{CR}}: Copies the effect of every other champion forms. Lasts less time than other champion forms#"..
        "Deals contact damage"
    },
    
    -- Cain's Other Eye
    {
        "Fire an additional tear in a random diagonal direction",
        "The diagonal tear gain a Rubber Cement effect " .. Icons.RubberCement.. "#{{ArrowUp}} Damage Up"
    },
    
    -- Incubus
    {
        "{{ArrowUp}} Damage Up",
        "{{ArrowUp}} Damage Up"
    },
    
    -- Lil Gurdy
    {
        "{{ArrowUp}} Charges faster#While charging, fires tear in different directions",
        "{{ArrowUp}} Charges faster#When it dashes, it leaves red creep#Fire 3 waves of tears in different directions after dashing"
    },
    
    -- Seraphim
    {
        "Has a chance to fire Holy Tears (from ".. Icons.HolyLight ..")",
        "{{ArrowUp}} Tears Up#{{ArrowUp}} Higher chance to fire Holy Tears"
    },
    
    -- Spider Mod
    {
        "Spawns eggs which apply a random effect to enemies which walk over them#Eggs last 20 seconds",
        "Higher chance to spawn eggs#At the end of rooms, eggs spawn blue spiders"
    },
    
    -- Farting Baby
    {
        "{{ArrowUp}} Increases chance to fart when getting hit#Has a chance to fart every few seconds. The closer it is to enemies, the higher chance for it fart",
        "{{ArrowUp}} Increases chance to fart when getting hit even more!#Gain an additional burning fart and holy fart"
    },
    
    -- Papa Fly
    {
        "Blocks projectiles#Has a chance to spawn a fly turret when blocking a projectiles",
        "{{ArrowUp}} Range Up#{{ArrowUp}} Higher chance to spawn a fly turret#Fires 5 tears in a row"
    },
    
    -- Lil Loki
    {
        "Fires in 8 directions",
        "{{ArrowUp}} Damage Up"
    },
    
    -- Hushy
    {
        {
            "Fire 15 tears in a random circular pattern every 4 seconds#Tears deal 3 damage",
            "{{ArrowUp}} Damage Up#Spawn minisaac after charging for a few seconds (only in rooms with enemies)"
        },
        {
            "Fire 15 tears in a random circular pattern every 4 seconds.#Tears deal 3 damage.",
            "{{ArrowUp}} Damage Up#Spawn friendly boil after charging for a few seconds (only in rooms with enemies)"
        }
    },
    
    -- Lil Monstro
    {
        "Has a chance to fire a tooth (from Tough Love ".. Icons.ToughLove,
        "Fires way more tears"
    },
    
    -- Big Chubby
    {
        "Increases its size and damage when eating bullets and when killing enemies#Reduces its size and damage over time and on a new floor",
        "{{ArrowUp}} Reduces cooldown#Increases its size even more while dealing damage to enemies#Doesn't lose damage bonus on a new floor anymore"
    },
    
    -- Mom's Razor
    {
        "{{ArrowUp}} Extends the Bleed duration (Bosses are not affected)",
        "{{ArrowUp}} Extends the Bleed duration#When an enemy dies while bleeding they spawn a large blood puddle#Have a chance to spawn half a heart {{HalfHeart}}"
    },
    
    -- Bloodshot Eye
    {
        "Fires three tears at once",
        "Fires a blood laser instead of tears"
    },
    
    -- Buddy in a Box
    {
        "Gains a random additional tear effect#Additional tear effect can't be Ipecac unless Ipecac is the base attack of the buddy",
        "Gains another random additional tear effect"
    },
    
    -- Angelic Prism
    {
        "While the player fires tears in the direction of the prism, it gets closer to the player#Tears which pass through it turn spectral",
        "Move even closer to the player#Tears which goes through it gain homing"
    },
    
    -- Lil Spewer
    {
        "When it shoots, it fires additional tears with effects of its current color",
        "Has two colors at the same time"
    },
    
    -- Pointy Rib
    {
        "Has a chance to apply bleed effect to non-boss enemies#Has a chance to spawn bone shards when it kills an enemy",
        "{{ArrowUp}} Collision Damage Up#{{Arrow Up}} Increases chance to apply bleed#{{Arrow Up}} Increases chance to spawn bone shards"
    },
    
    -- Paschal Candle
    {
        "When the player takes damage, it spreads flames around itself#The amount of flames depends on the size of the candle's flame",
        "Taking damage only reduces the flame's size by one step"
    },
    
    -- Blood Oath
    {
        "Spawns red creep#Creep rate and damage depends on the amount of half hearts {{HalfHeart}} removed",
        "When it stabs, spawns random red hearts {{Heart}}"
    },
    
    -- Psy Fly
    {
        "When it blocks a bullet, it fires a homing tear back",
        "{{ArrowUp}} Collision Damage Up#{{ArrowUp}} Tears Damage Up"
    },
    
    -- Boiled Baby
    {
        "Increase the amount of tears it burst",
        "Fires tears in the direction the player is firing"
    },
    
    -- Freezer Baby
    {
        "{{ArrowUp}} Damage Up#{{ArrowUp}} Range Up#{{ArrowUp}} Higher chance to freeze enemies",
        "{{ArrowUp}} Damage Up#Enemies it kills explode into ice tears"
    },
    
    -- Lil Dumpy
    {
        "Changes to another Lil Dumpy variant each rooms, such as:" ..
        "#".. Icons.LilDumpy.DUMPLING .." Standard effect"..
        "#".. Icons.LilDumpy.SKINLING .." Poisons enemies when farting"..
        "#".. Icons.LilDumpy.SCABLING .." When it farts, it fires 6 tears in a circular pattern"..
        "#".. Icons.LilDumpy.SCORCHLING .." When it farts, it spawns a flame which deals 15 damage"..
        "#".. Icons.LilDumpy.FROSTLING .." Enemies killed by it are turned into ice. While resting, gain a freezing aura"..
        "#".. Icons.LilDumpy.DROPLING .." When it farts, it fires tears in the opposite direction",
        "Returns to the player after a random amount of seconds, even if the player is far away"
    },
    
    -- Bot Fly
    {
        "{{ArrowUp}} Stats Up (Range, Shot Speed, Tear Size)#When it fires a tear, a laser connects the tears and the familiar#The laser deals contact damage and blocks shots",
        "{{ArrowUp}} Stats Up#Gain piercing tears#Rarely attacks enemies"
    },
    
    -- Fruity Plum
    {
        "{{ArrowUp}} Damage Up#Gains small homing effect",
        "Gains a Playdough Cookie ".. Icons.PlaydoughCookie .." effect#After an attack it fires tears in all directions"
    },
    
    -- Cube Baby
    {
        "Gains a freezing aura. Enemies which stay too long in the aura will take damage until they are completely frozen",
        "Spawns creep when moved around#The faster it moves, the more it spawns creep"
    },
    
    -- Lil Abaddon
    {
        "{{ArrowUp}} Damage Up#When holding the fire button, it spawns a swirl every few seconds. When fire button is released, a laser ring is fired by the swirls",
        "Spawns swirls more often#Lasers from swirls deal more damage, are larger and last longer#Has a tiny chance to spawn black hearts {{BlackHeart}}"
    },
    
    -- Vanishing Twin
    {
        "Removes 25% of the boss copy health",
        "Increases chances to spawn a better item (based on Quality)#Can spawn items from the Treasure pool if no Boss pool item are found"
    },
    
    -- Twisted Pair
    {
        "{{ArrowUp}} +0.33 Flat Damage Up#They move closer to the player while they fire",
        "They align with the player's direction"
    },
    
    -- BBF
    {
        "{{ArrowUp}} Explosions deal 75 more damage#{{ArrowUp}} Bigger explosions#{{Warning}} Because explosions are larger they can hit Isaac from further away",
        "Isaac doesn't take damage from the explosion unless it is too close"
    },
    
    -- King Baby
    {
        "Summon tears while Isaac is firing",
        "{{ArrowUp}} Tears Up#Each familiars improve in their own way the summoned tear"
    }
}

return familiarsUpgrades