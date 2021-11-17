local Enums = require("sewn_scripts.core.enums")
local UpgradeManager = require("sewn_scripts.core.upgrade_manager")

local StitchingCard = { }

function StitchingCard:OnUse(card, player, useFlags)
    if card ~= Enums.Card.CARD_STITCHING then
        return
    end
    local hasUpgrades = false
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)

    if #familiars == 0 then
        return
    end
    for _, familiar in ipairs(familiars) do
        familiar = familiar:ToFamiliar()
        if GetPtrHash(familiar.Player) == GetPtrHash(player) then
            local fData = familiar:GetData()
            if Sewn_API:GetLevel(fData) > Enums.FamiliarLevel.NORMAL then
                hasUpgrades = true
            end
        end
    end
    if hasUpgrades then
        UpgradeManager:RerollUpgrades(player, player:GetCardRNG(card))
    else
        local rollFamiliar = player:GetCardRNG(card):RandomInt(#familiars) + 1
        UpgradeManager:TryUpgrade(familiars[rollFamiliar].Variant, 0, player.Index)
    end
end

return StitchingCard