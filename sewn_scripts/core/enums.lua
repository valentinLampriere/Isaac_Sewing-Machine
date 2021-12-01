local Enums = {}

Enums.SewingMachineSubType = {
    BEDROOM = 0,
    SHOP = 1,
    ANGEL = 2,
    DEVIL = 3
}

Enums.ModCallbacks = {
    POST_MACHINE_UPDATE = 0,
    POST_PLAYER_TOUCH_MACHINE = 1,
    POST_MACHINE_DESTROY = 2,
    POST_FAMILIAR_FIRE_TEAR = 3,
    POST_TEAR_INIT = 4, -- The normal POST_TEAR_INIT doesn't work properly
    POST_LASER_INIT = 5, -- The normal POST_LASER_INIT doesn't work properly
    POST_FAMILIAR_FIRE_LASER = 6,
    POST_FAMILIAR_TEAR_UPDATE = 7,
    GET_LOSE_COLLECTIBLE = 8,
    GET_LOSE_TRINKET = 9,
    PRE_GET_FAMILIAR_FROM_SEWING_MACHINE = 10,
    POST_GET_FAMILIAR_FROM_SEWING_MACHINE = 11,
    FAMILIAR_UPDATE = 12,
    FAMILIAR_HIT_NPC = 13,
    FAMILIAR_KILL_NPC = 14,
    POST_FAMILIAR_PLAY_ANIM = 15,
    POST_FAMILIAR_NEW_ROOM = 16,
    ON_FAMILIAR_UPGRADED = 17,
    POST_FAMILIAR_NEW_LEVEL = 18,
    PRE_FAMILIAR_TEAR_COLLISION = 19,
    FAMILIAR_CLEAN_ROOM = 20,
    PRE_ADD_FAMILIAR_IN_SEWING_MACHINE = 21,
    ON_FAMILIAR_LOSE_UPGRADE = 22,
    FAMILIAR_EVALUATE_CACHE = 23,
    PRE_FAMILIAR_COLLISION = 24,
    FAMILIAR_PLAYER_TAKE_DAMAGE = 25,
    POST_FAMILIAR_INIT = 26,
    ENTITY_TAKE_DAMAGE = 27,
}

Enums.FamiliarLevel = {
    NORMAL = 0,
    SUPER = 1,
    ULTRA = 2
}

Enums.FamiliarLevelFlag = {
    FLAG_NORMAL = 2^0,
    FLAG_SUPER = 2^1,
    FLAG_ULTRA = 2^2,
    FLAG_ANY = 2^0 | 2^1 | 2^2
}

Enums.CollectibleType = {
    COLLECTIBLE_SEWING_BOX = Isaac.GetItemIdByName("Sewing Box"),
    COLLECTIBLE_DOLL_S_TAINTED_HEAD = Isaac.GetItemIdByName("Doll's Tainted Head"),
    COLLECTIBLE_DOLL_S_PURE_BODY = Isaac.GetItemIdByName("Doll's Pure Body")
}
Enums.TrinketType = {
    TRINKET_THIMBLE = Isaac.GetTrinketIdByName("Thimble"),
    TRINKET_CRACKED_THIMBLE = Isaac.GetTrinketIdByName("Cracked Thimble"),
    TRINKET_LOST_BUTTON = Isaac.GetTrinketIdByName("Lost Button"),
    --TRINKET_CONTRASTED_BUTTON = Isaac.GetTrinketIdByName("Contrasted Button"),
    TRINKET_PIN_CUSHION = Isaac.GetTrinketIdByName("Pin Cushion"),
    TRINKET_SEWING_CASE = Isaac.GetTrinketIdByName("Sewing Case")
}
Enums.Card = {
    CARD_WARRANTY = Isaac.GetCardIdByName("warrantyCard"),
    CARD_STITCHING = Isaac.GetCardIdByName("stitchingCard"),
    CARD_SEWING_COUPON = Isaac.GetCardIdByName("sewingCoupon")
}

Enums.SlotMachineVariant = {
    SLOT_MACHINE = 1,
    BLOOD_DONATION_MACHINE = 2,
    FORTUNE_TELLING_MACHINE = 3,
    BEGGAR = 4,
    DEVIL_BEGGAR = 5,
    SHELL_GAME = 6,
    KEY_MASTER = 7,
    DONATION_MACHINE = 8,
    BOMB_BUM = 9,
    SHOP_RESTOCK_MACHINE = 10,
    GREED_DONATION_MACHINE = 11,
    MOM_S_DRESSING_TABLE = 12,
    BATTERY_BUM = 13,
    HELL_GAME = 15,
    CRANE_GAME = 16,
    CONFESSIONAL = 17,
    ROTTEN_BEGGAR = 18,
    LEAKY_CAULDRON = 283,
    SEWING_MACHINE = 756,
}


Enums.LaserVariant = {
    LASER_BRIMSTONE = 1,
    LASER_TECHNOLOGY = 2,
    LASER_SHOOP_DA_WHOOP = 3,
    LASER_PRIDE = 4,
    LASER_LIGHT = 5,
    LASER_MEGA_SATAN = 6,
    LASER_TRACTOR_BEAM = 7,
    LASER_BRIMTECH = 9,
    LASER_ELECTRIC = 10,
    LASER_BRIMSTONE_THICK = 11,
    LASER_MONTEZUMA = 12,
    LASER_BEAST = 13
}

Enums.FamiliarVariant = {
    DOLL_S_PURE_BODY = Isaac.GetEntityVariantByName("Doll's Pure Body"),
    DOLL_S_TAINTED_HEAD = Isaac.GetEntityVariantByName("Doll's Tainted Head"),
    SEWN_DOLL = Isaac.GetEntityVariantByName("Sewn Doll")
}

Enums.EffectVariant = {
    LIL_ABADDON_BRIMSTONE_SWIRL = Isaac.GetEntityVariantByName("Lil Abaddon Brimstone Swirl"),
    SPIDER_MOD_EGG = Isaac.GetEntityVariantByName("Spider Mod Egg"),
    CUBE_BABY_AURA = Isaac.GetEntityVariantByName("Cube Baby Aura"),
    PUNCHING_BAG_PULLING_EFFECT = Isaac.GetEntityVariantByName("Punching Bag Pulling Effect"),
    BOMB_BAG_POWDER = Isaac.GetEntityVariantByName("Bomb Bag Powder"),
}

Enums.NoUpgrade = {
    NONE = 0,
    MACHINE = 2^0,
    TEMPORARY = 2^1,
    ANY = 2^0 | 2^1
}

return Enums