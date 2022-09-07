local Enums = require("sewn_scripts.core.enums")

local LocalizationCore = { }

-- ITEMS
LocalizationCore.CollectiblesIndexToId = {
    Enums.CollectibleType.COLLECTIBLE_SEWING_BOX,
    Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD,
    Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY,
}
LocalizationCore.CollectiblesIdToIndex = { }
for index, id in ipairs(LocalizationCore.CollectiblesIndexToId) do
    LocalizationCore.CollectiblesIdToIndex[id] = index
end

-- TRINKETS
LocalizationCore.TrinketsIndexToId = {
    Enums.TrinketType.TRINKET_THIMBLE,
    Enums.TrinketType.TRINKET_CRACKED_THIMBLE,
    Enums.TrinketType.TRINKET_LOST_BUTTON,
    Enums.TrinketType.TRINKET_PIN_CUSHION,
    Enums.TrinketType.TRINKET_SEWING_CASE,
}
LocalizationCore.TrinketsIdToIndex = { }
for index, id in ipairs(LocalizationCore.TrinketsIndexToId) do
    LocalizationCore.TrinketsIdToIndex[id] = index
end

-- FAMILIAR UPGRADES
LocalizationCore.FamiliarsUpgradesIndexToVariant = {
    FamiliarVariant.BROTHER_BOBBY,
    FamiliarVariant.SISTER_MAGGY,
    FamiliarVariant.DEAD_CAT,
    FamiliarVariant.LITTLE_CHUBBY,
    FamiliarVariant.ROBO_BABY,
    FamiliarVariant.LITTLE_GISH,
    FamiliarVariant.LITTLE_STEVEN,
    FamiliarVariant.DEMON_BABY,
    FamiliarVariant.BOMB_BAG,
    FamiliarVariant.PEEPER,
    FamiliarVariant.GHOST_BABY,
    FamiliarVariant.HARLEQUIN_BABY,
    FamiliarVariant.DADDY_LONGLEGS,
    FamiliarVariant.SACRIFICIAL_DAGGER,
    FamiliarVariant.RAINBOW_BABY,
    FamiliarVariant.GUPPYS_HAIRBALL,
    FamiliarVariant.DRY_BABY,
    FamiliarVariant.JUICY_SACK,
    FamiliarVariant.ROTTEN_BABY,
    FamiliarVariant.HEADLESS_BABY,
    FamiliarVariant.LEECH,
    FamiliarVariant.LIL_BRIMSTONE,
    FamiliarVariant.ISAACS_HEART,
    FamiliarVariant.SISSY_LONGLEGS,
    FamiliarVariant.PUNCHING_BAG,
    FamiliarVariant.CAINS_OTHER_EYE,
    FamiliarVariant.INCUBUS,
    FamiliarVariant.LIL_GURDY,
    FamiliarVariant.SERAPHIM,
    FamiliarVariant.SPIDER_MOD,
    FamiliarVariant.FARTING_BABY,
    FamiliarVariant.PAPA_FLY,
    FamiliarVariant.LIL_LOKI,
    FamiliarVariant.HUSHY,
    FamiliarVariant.LIL_MONSTRO,
    FamiliarVariant.BIG_CHUBBY,
    FamiliarVariant.MOMS_RAZOR,
    FamiliarVariant.BLOODSHOT_EYE,
    FamiliarVariant.BUDDY_IN_A_BOX,
    FamiliarVariant.ANGELIC_PRISM,
    FamiliarVariant.LIL_SPEWER,
    FamiliarVariant.POINTY_RIB,
    FamiliarVariant.PASCHAL_CANDLE,
    FamiliarVariant.BLOOD_OATH,
    FamiliarVariant.PSY_FLY,
    FamiliarVariant.BOILED_BABY,
    FamiliarVariant.FREEZER_BABY,
    FamiliarVariant.LIL_DUMPY,
    FamiliarVariant.BOT_FLY,
    FamiliarVariant.FRUITY_PLUM,
    FamiliarVariant.CUBE_BABY,
    FamiliarVariant.LIL_ABADDON,
    FamiliarVariant.VANISHING_TWIN,
    FamiliarVariant.TWISTED_BABY,
    FamiliarVariant.BBF,
}
LocalizationCore.FamiliarsUpgradesVariantToIndex = { }
for index, id in ipairs(LocalizationCore.FamiliarsUpgradesIndexToVariant) do
    LocalizationCore.FamiliarsUpgradesVariantToIndex[id] = index
end

-- CARDS
LocalizationCore.CardsIndexToId = {
    Enums.Card.CARD_WARRANTY,
    Enums.Card.CARD_STITCHING,
    Enums.Card.CARD_SEWING_COUPON,
}
LocalizationCore.CardsIdToIndex = { }
for index, id in ipairs(LocalizationCore.CardsIndexToId) do
    LocalizationCore.CardsIdToIndex[id] = index
end

LocalizationCore.AvailableLanguages = { }

local languageCodes = {
    "en_us", "fr", "zh_cn", "ru", "spa", "pl"
}

for _, languageCode in ipairs(languageCodes) do
    LocalizationCore.AvailableLanguages[languageCode] = {
        Items = require("sewn_scripts.localization."..languageCode..".items"),
        Trinkets = require("sewn_scripts.localization."..languageCode..".trinkets"),
        FamiliarUpgrades = require("sewn_scripts.localization."..languageCode..".familiar_upgrades"),
        Cards = require("sewn_scripts.localization."..languageCode..".cards"),
        Misc = require("sewn_scripts.localization."..languageCode..".misc")
    }
end

return LocalizationCore