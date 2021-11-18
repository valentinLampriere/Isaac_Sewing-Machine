local Cards = require("sewn_scripts.items.cards.cards")

local function MC_GET_CARD(_, rng, card, includePlayingCards, includeRunes, onlyRunes)
    return Cards:GetCard(rng, card, includePlayingCards, includeRunes, onlyRunes)
end

return MC_GET_CARD
