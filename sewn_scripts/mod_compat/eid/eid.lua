if not EID then
    return
end

local Enums = require("sewn_scripts.core.enums")

-- EID Collectibles
EID:addCollectible(Enums.CollectibleType.COLLECTIBLE_SEWING_BOX, "Upgrade every familiars from normal to super, or super to ultra form#Using it twice in a room will upgrade familiars twice#Ultra familiars can't be upgraded")
EID:addCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD, "Upgrade every normal familiars to super#With Doll's Pure Body, upgrade every familiars to ultra")
EID:addCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY, "Upgrade every normal familiars to super#With Doll's Tainted Body, upgrade every familiars to ultra")

-- EID Trinkets
EID:addTrinket(Enums.TrinketType.TRINKET_THIMBLE, "Refund familiars upgrade when using the Sewing Machine#Spawn pickups on the floor, pickups depends on the Sewing Machine type")
EID:addTrinket(Enums.TrinketType.TRINKET_CRACKED_THIMBLE, "Have 75% chance to reroll familiars crowns when getting hit")
EID:addTrinket(Enums.TrinketType.TRINKET_LOST_BUTTON, "100% chance to spawn sewing machine in Shops#50% chance to find a sewing machine in angel rooms {{AngelRoom}} or devil rooms {{DevilRoom}}")
--EID:addTrinket(Enums.TrinketType.TRINKET_CONTRASTED_BUTTON, "50% chance to find a sewing machine in angel rooms {{AngelRoom}} or devil rooms {{DevilRoom}}")
EID:addTrinket(Enums.TrinketType.TRINKET_PIN_CUSHION, "Interacting with the machine gives the familiar back#It allow the player to choose the familiar he want to upgrade#Can be easily dropped by pressing the drop button#When smelt this effect is removed, but decrease chances to break a sewing machine")
EID:addTrinket(Enums.TrinketType.TRINKET_SEWING_CASE, "When entering a room, has a chance to temporary upgrade a familiar#The chance is based on the amount of available familiars and the luck")

-- EID Cards
EID:addCard(Enums.Card.CARD_WARRANTY, "Spawn a sewing machine#The Sewing machine change depending on the room type")
EID:addCard(Enums.Card.CARD_STITCHING, "Reroll familiar crowns#Gives a free upgrades if none of your familiars are upgraded")
EID:addCard(Enums.Card.CARD_SEWING_COUPON, "Upgrade all familiars for a single room#One time use of Sewing Box")