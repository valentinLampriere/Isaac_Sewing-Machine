if not EID then
    return
end

local Enums = require("sewn_scripts.core.enums")

-- EID Collectibles
EID:addCollectible(Enums.CollectibleType.COLLECTIBLE_SEWING_BOX, "Temporarily upgrades familiars for a room#Using it twice upgrades familiars to Ultra")
EID:addCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD, "Upgrade every normal familiars to super#With Doll's Pure Body, upgrade every familiars to ultra#Add 20% chance to find a Sewing Machine in Devil rooms")
EID:addCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY, "Upgrade every normal familiars to super#With Doll's Tainted Body, upgrade every familiars to ultra#Add 20% chance to find a Sewing Machine in Angel rooms")

-- EID Trinkets
EID:addTrinket(Enums.TrinketType.TRINKET_THIMBLE, "Refunds familiars upgrade when using the Sewing Machine#Spawn pickups on the floor, pickups depends on the Sewing Machine type")
EID:addTrinket(Enums.TrinketType.TRINKET_CRACKED_THIMBLE, "Have 75% chance to reroll familiars crowns when getting hit")
EID:addTrinket(Enums.TrinketType.TRINKET_LOST_BUTTON, "100% chance to spawn sewing machine in Shops#50% chance to find a sewing machine in angel rooms {{AngelRoom}} or devil rooms {{DevilRoom}}")
--EID:addTrinket(Enums.TrinketType.TRINKET_CONTRASTED_BUTTON, "50% chance to find a sewing machine in angel rooms {{AngelRoom}} or devil rooms {{DevilRoom}}")
EID:addTrinket(Enums.TrinketType.TRINKET_PIN_CUSHION, "Interacting with a Sewing Machine gives the familiar back without upgrading.#This allows you to choose the familiar you want to upgrade by dropping the trinket with the drop button when the correct one is in the machine#{{Warning}} When smelted this effect is removed, but you have a decreased chance to break sewing machines")
EID:addTrinket(Enums.TrinketType.TRINKET_SEWING_CASE, "When entering a room, has a chance to temporarily upgrade a familiar based on the amount of available familiars and luck")

-- EID Cards
EID:addCard(Enums.Card.CARD_WARRANTY, "Spawns a sewing machine#The Sewing machine change depending on the room type")
EID:addCard(Enums.Card.CARD_STITCHING, "Rerolls familiar crowns#Gives a free upgrades if none of your familiars are upgraded")
EID:addCard(Enums.Card.CARD_SEWING_COUPON, "Upgrade all familiars for a single room#One time use of Sewing Box")

local icon = Sprite()
icon:Load("/gfx/mapicon.anm2", true)
EID:addIcon("SewingMachine", "Icon", 0, 13, 13, 0, 0, icon)
EID:setModIndicatorIcon("SewingMachine")
EID:setModIndicatorName("Sewing Machine")