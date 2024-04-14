local Enums = require("sewn_scripts.core.enums")
local EncyclopediaUpgrades = require("sewn_scripts.mod_compat.encyclopedia.encyclopedia_upgrades")

if not Encyclopedia then
    return
end

local modName = "Sewing Machine"

Encyclopedia.AddItem({
    ID = Enums.CollectibleType.COLLECTIBLE_SEWING_BOX,
    Name = "Sewing Box",
    ModName = modName,
    Pools = {
        Encyclopedia.ItemPools.POOL_TREASURE,
        Encyclopedia.ItemPools.POOL_SHOP,
    },
    WikiDesc = {
        {
            { str = "Effect", fsize = 2, clr = 3, halign = 0 },
            { str = "Upgrade every familiars from normal to super, or super to ultra form" },
            { str = "Using it twice in a room will upgrade familiars twice" },
            { str = "Ultra familiars can't be upgraded" },
            { str = "" },
            { str = "" },
            { str = "" },
            { str = "Note: It can only upgrade available familiars" },
            { str = "Some familiars can't be upgraded with a Sewing Machine, but can be upgraded with Sewing Box (Lilith's Incubus, Familiars which spawns from Sewing Box...)" },
        },
        {
            { str = "Synergies", fsize = 2, clr = 3, halign = 0 },
            { str = "Car Battery: Upgrade every familiars to ultra" }
        }
    }
})

local function GetDollWiki(isTaintedHead)
    local dollName
    local otherDollName
    local dollID
    local dollPool
    local dollRoom
    if isTaintedHead then
        dollName = "Doll's Tainted Head"
        otherDollName = "Doll's Pure Body"
        dollID = Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD
        dollPool = Encyclopedia.ItemPools.POOL_DEVIL
        dollRoom = "Devil"
    else
        dollName = "Doll's Pure Body"
        otherDollName = "Doll's Tainted Head"
        dollID = Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY
        dollPool = Encyclopedia.ItemPools.POOL_ANGEL
        dollRoom = "Angel"
    end

    return {
        ID = dollID,
        Name = dollName,
        ModName = modName,
        WikiDesc = {
            {
                { str = "Effect", fsize = 2, clr = 3, halign = 0 },
                { str = "Upgrade every normal familiars to super" },
                { str = "With " .. otherDollName .. ", upgrade every familiars to ultra" },
                { str = "Add 20% chance to find a Sewing machine in " .. dollRoom .. " rooms" }
            },
            {
                { str = "Synergies", fsize = 2, clr = 3, halign = 0 },
                { str = otherDollName..": Upgrade summoned familiar" },
                { str = "Quints: Upgrade Quints familiars" },
                { str = "Monster Manual: Upgrade summoned familiar" },
                { str = "Lost Button: Both increase the chance to spawn a machine in "..dollRoom.." rooms. The chance goes to 70%" }
            }
        },
        Pools = {
            dollPool
        },
    }
end

Encyclopedia.AddItem(GetDollWiki(true))
Encyclopedia.AddItem(GetDollWiki(false))

Encyclopedia.AddTrinket({
    ID = Enums.TrinketType.TRINKET_LOST_BUTTON,
    Name = "Lost Button",
    ModName = modName,
    WikiDesc = {
        {
            { str = "Effect", fsize = 2, clr = 3, halign = 0 },
            { str = "There is now 100% chance to spawn sewing machine in Shops (instead of 25%)" },
            { str = "Have 50% chance to spawn an Evil Sewing Machine in Devil rooms and 50% chance to spawn an Angelic Sewing Machine in Angel rooms" }
        },
        {
            { str = "Trivia", fsize = 2, clr = 3, halign = 0 },
            { str = "Before the update of the 27/11/2021, there were two trinkets \"Lost Button\" and \"Contrasted Button\"." },
            { str = "Those buttons trinkets have been merged together, the other trinket have been removed but it is still in the mod folder" }
        }
    }
})

Encyclopedia.AddTrinket({
    ID = Enums.TrinketType.TRINKET_CRACKED_THIMBLE,
    Name = "Cracked Thimble",
    ModName = modName,
    WikiDesc = {
        {
            { str = "Effect", fsize = 2, clr = 3, halign = 0 },
            { str = "Have 75% chance to reroll familiars crowns when getting hit" },
            { str = "When rerolling crowns, keep the same amount of crowns" },
            { str = "For example, if you've got super Brother Bobby, super Sister Maggy and ultra Robo-Baby you've got 4 crowns. The trinket will rearrange your familiars crowns but will keep 4 crowns" }
        }
    }
})

Encyclopedia.AddTrinket({
    ID = Enums.TrinketType.TRINKET_SEWING_CASE,
    Name = "Sewing Case",
    ModName = modName,
    WikiDesc = {
        {
            { str = "Effect", fsize = 2, clr = 3, halign = 0 },
            { str = "When entering a room, has a chance to temporary upgrade a familiar" },
            { str = "The chance is based on the amount of available familiars and the luck" },
            { str = "" },
            { str = "With 0 luck and a single familiar, there is 30% chance to upgrade it" },
            { str = "With 50 luck and a single familiar, there is 70% chance to upgrade it" },
            { str = "With 0 luck and 6 familiars, there is 77% chance to upgrade one of them" },
            { str = "" },
            { str = "Chance is calculated as sqrt(nb_familiars * 0.1) + luck * 0.008" },
            { str = "Luck is capped as [-10, 50]" },
        },
        {
            { str = "Synergies", fsize = 2, clr = 3, halign = 0 },
            { str = "The Twins: Can upgrade the spawned familiar" },
        }
    }
})

Encyclopedia.AddCard({
    ID = Enums.Card.CARD_WARRANTY,
    ModName = modName,
    WikiDesc = {
        {
            { str = "Effect", fsize = 2, clr = 3, halign = 0 },
            { str = "Spawn a Sewing Machine" },
            { str = "The Sewing Machine type depends on the room :" },
            { str = "- Shop: Shop Sewing Machine" },
            { str = "- Bedroom: Bedroom Sewing Machine" },
            { str = "- Devil: Evil Sewing Machine" },
            { str = "- Angel: Angelic Sewing Machine" },
            { str = "- Other rooms: Shop Sewing Machine or Bedroom Sewing Machine choosen at random" },
        }
    },
    Spr = Encyclopedia.RegisterSprite("../content/gfx/ui_cardfronts.anm2", "warrantyCard")
})
Encyclopedia.AddCard({
    ID = Enums.Card.CARD_STITCHING,
    ModName = modName,
    WikiDesc = {
        {
            { str = "Effect", fsize = 2, clr = 3, halign = 0 },
            { str = "Reroll familiars crowns" },
            { str = "When rerolling crowns, keep the same amount of crowns" },
            { str = "For example, if you've got super Brother Bobby, super Sister Maggy and ultra Robo-Baby you've got 4 crowns. The trinket will rearrange your familiars crowns but will keep 4 crowns" },
            { str = "If the player has no upgraded familiars, upgrade a familiar" }
        }
    },
    Spr = Encyclopedia.RegisterSprite("../content/gfx/ui_cardfronts.anm2", "stitchingCard")
})
Encyclopedia.AddCard({
    ID = Enums.Card.CARD_SEWING_COUPON,
    ModName = modName,
    WikiDesc = {
        {
            { str = "Effect", fsize = 2, clr = 3, halign = 0 },
            { str = "Upgrade all familiars for a single room" },
            { str = "One time use of Sewing Box" }
        }
    },
    Spr = Encyclopedia.RegisterSprite("../content/gfx/ui_cardfronts.anm2", "sewingCoupon")
})

require("sewn_scripts.mod_compat.encyclopedia.encyclopedia_familiars_upgrades")