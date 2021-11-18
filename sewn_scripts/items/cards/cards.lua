local Random = require("sewn_scripts.helpers.random")
local WarrantyCard = require("sewn_scripts.items.cards.warranty_card")
local StitchingCard = require("sewn_scripts.items.cards.stitching_card")
local SewingCoupon = require("sewn_scripts.items.cards.sewing_coupon")

local Cards = { }

Cards.SpawnChance = 1.3

Cards.SewingCards = {
    WarrantyCard, StitchingCard, SewingCoupon
}

local function CopyCardTable()
    local copyCardTable = { }
    for _, card in ipairs(Cards.SewingCards) do
        table.insert(copyCardTable, card)
    end
    return copyCardTable
end

local function GetWeightCardsMax(rng)
    local weight = 0
    local copyCards = CopyCardTable()
    while (#copyCards > 0) do
        local pickCard = rng:RandomInt(#copyCards) + 1
        weight = weight + copyCards[pickCard].SpawnChance
        table.remove(copyCards, pickCard)
    end
    return weight
end

local function PickRandomCard(rng)
    local weightMax = GetWeightCardsMax(rng)
    local weight = 0
    local copyCards = CopyCardTable()
    local roll = rng:RandomFloat() * weightMax
    while (#copyCards > 0) do
        local pickCard = rng:RandomInt(#copyCards) + 1
        weight = weight + copyCards[pickCard].SpawnChance
        if weight >= roll then
            return copyCards[pickCard].ID
        end
        table.remove(copyCards, pickCard)
    end
end

function Cards:GetCard(rng, card, includePlayingCards, includeRunes, onlyRunes)
    local copyCards = CopyCardTable()
    if Random:CheckRoll(Cards.SpawnChance, rng) then
        return PickRandomCard(rng)
    end
end

return Cards