Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.BROTHER_BOBBY,
    "Tears Up (x1.33)",
    "Tears Up (x1.47)#Damage Up (x1.33)"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.DEAD_CAT,
    nil, nil,
    "Gives a soul heart even if the player respawn without Dead Cat (That's a bug due to how the API works)"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.FARTING_BABY,
    nil,
    "Increase chances to fart#Gain two additional farts (Burning and Holy)#Burning Farts deal damage and turn enemies on fire.#Holy Farts give a large Tears and Damage up to the player (if it is in the fart range). The effect disappears quickly."
)

if REPENTANCE then
    Sewn_API:AddEncyclopediaUpgrade(
        FamiliarVariant.HUSHY,
        nil, nil,
        "In AB+, there are no minisaac so the ultra upgrade spawns a friendly boil monster instead."
    )
else
    Sewn_API:AddEncyclopediaUpgrade(
        FamiliarVariant.HUSHY,
        nil, nil,
        "In Repentance the ultra upgrade spawn a tiny Isaac familiar (known as Minisaac) instead of a boil monster."
    )
end

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.INCUBUS,
    "Damage Up (x1.33)#[REP] : Now deal the same amount of damage as the player",
    "Damage Up (x1.67)",
    "Due to API limitation, the damage bonus do not works with every weapon type (Lasers, bombs)#Lilith's Incubus can't be upgraded in Sewing Machines because Lilith's without her Incubus can't fight. It can still be upgraded with Sewing Box"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.LIL_BRIMSTONE,
    "Damage Up (x1.5)",
    "Laser lasts longer (x1.3)#Slight Damage Up (x1.6)#Charges quicker"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.LIL_DUMPY,
    "Change to another Lil Dumpy variant each rooms as :" ..
    "#Dumpling : Standard effect."..
    "#Skinling : Poisons enemies when farting."..
    "#Scabling : When it farts, fire 6 tears in a circular pattern. Tears deal 5 damage."..
    "#Scortchling : When it farts, spawn a flame which deal 15 damage. While it is pushed by it own fart, it will apply burning effect to enemies it collide with."..
    "#Frostling : Enemies it kills turn to ice. While resting, gain a freezing aura which freeze enemies which stay in it radius for too long."..
    "#Dropling : When it farts, fire tears in the opposite direction. Tears deal 3 damage." ..
    "# #Variants have a different weight which affect their chances to be picked."
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.LIL_LOKI,
    nil,
    "Damage Up (x1.5)"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.LIL_SPEWER,
    "When it throw creep, it fires tears which depends on it color.#- Normal: Fires three normal tears (one forward, two in diagonal directions) which deal 5 damage#- Black and White: Fires 3 tears (one forward, two in diagonal directions) which deal 3.5 damage and apply a slow effect#- Yellow: Fires three tears in the same direction with a 2 frames delay#- Red: Fires a single large tear which deal 12.5 damage.",
    "Has two colors at the same time allowing it to combine effects"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.LITTLE_GISH,
    "Tears create a puddle of creep on hit#Slight Tears Up (x1.14)",
    "Larger creep#Tears Up (x1.43)#Damage Up (x1.3)"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.PASCHAL_CANDLE,
    nil, nil,
    "The whole familiar mechanic have been rewrite for the ultra upgrade.#Each time the player clean a room, the stat in the Found HUD will get reset and the bonus will be applied resulting in a weird effect.#This is only a visual effect in the Found HUD."
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.POINTY_RIB,
    "Has 50% chance to apply bleed effect to non-boss enemies#Has 33% chance to spawn 1 to 5 bones when it kills an enemy",
    "Increase chances to apply bleed effect to 80%#Increase chances to spawn bones to 6%. Can spawn 2 to 5 bones#Deal more collision damage equals to normal damage x 1.5 + 2"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.PSY_FLY,
    nil,
    "Collision damage and tears damage up (x1.5)",
    "The super upgrade is a similar behaviour of the Psy Fly behaviour before it was nerfed in the 1.7.5 update"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.ROBO_BABY,
    "Tears Up (x1.29)",
    "Tears Up (x1.52)"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.ROTTEN_BABY,
    nil,
    "Spawn a random locust#Spawn two conquest locusts at a time"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.SACRIFICIAL_DAGGER,
    "Applies a bleed effect#Small damage Up (+1 dmg)",
    "Damage up (+4 dmg)"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.SERAPHIM,
    "Have 10% chance to fire a Holy Tear#Holy Tear spawn a light beam on contact",
    "Have 15% chance to fire a Holy Tear#Tears Up (x1.24)"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.SISTER_MAGGY,
    "Damage Up (x1.33)",
    "Damage Up (x1.66)#Tears Up (x1.28)"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.TWISTED_BABY,
    nil,
    "Align with the player's direction#Slight damage up. +0.33 when the damage is less than 2, +0.5 when the damage is higher than 2",
    "Due to API limitation, the damage bonus do not works with every weapon type (Lasers, bombs)"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.CAINS_OTHER_EYE,
    "Fire an additional tear in a random diagonal direction#The familiar will always fire a tear, no matter the weapon (Brimstone, Mom's Knife etc.) of the player.",
    "The diagonal tear gain a Rubber Cement effect#Damage Up#The additional tear becomes red."
)