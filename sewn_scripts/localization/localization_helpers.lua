local Enums = require("sewn_scripts.core.enums")

local LocalizationHelpers = { }

LocalizationHelpers.Icons = {
    SewingBox = "{{Collectible".. Enums.CollectibleType.COLLECTIBLE_SEWING_BOX .."}}",
    TaintedHead = "{{Collectible".. Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD .."}}",
    PureBody = "{{Collectible".. Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY .."}}",

    Peeper = "{{Collectible".. CollectibleType.COLLECTIBLE_PEEPER .."}}",
    InnerEye = "{{Collectible".. CollectibleType.COLLECTIBLE_INNER_EYE .."}}",
    PupulaDuplex = "{{Collectible"..CollectibleType.COLLECTIBLE_PUPULA_DUPLEX.."}}",
    Parasitoid = "{{Collectible"..CollectibleType.COLLECTIBLE_PARASITOID.."}}",
    RubberCement = "{{Collectible"..CollectibleType.COLLECTIBLE_RUBBER_CEMENT.."}}",
    HolyLight = "{{Collectible"..CollectibleType.COLLECTIBLE_HOLY_LIGHT.."}}",
    ToughLove = "{{Collectible"..CollectibleType.COLLECTIBLE_TOUGH_LOVE.."}}",
    PlaydoughCookie = "{{Collectible"..CollectibleType.COLLECTIBLE_PLAYDOUGH_COOKIE.."}}",
    HolyMantle = "{{Collectible"..CollectibleType.COLLECTIBLE_HOLY_MANTLE.."}}",

    HolyCard = "{{Card"..Card.CARD_HOLY.."}}",

    LilDumpy = {
        DUMPLING = "{{LilDumpyVariant0}}",
        SKINLING = "{{LilDumpyVariant1}}",
        SCABLING = "{{LilDumpyVariant2}}",
        SCORCHLING = "{{LilDumpyVariant3}}",
        DROPLING = "{{LilDumpyVariant4}}",
        FROSTLING = "{{LilDumpyVariant5}}",
    }
}

return LocalizationHelpers.Icons