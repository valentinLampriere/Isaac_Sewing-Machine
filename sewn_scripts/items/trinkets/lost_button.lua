local Enums = require("sewn_scripts.core.enums")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")

local SewingMachine_Shop = require("sewn_scripts.entities.slot.sewing_machine.subtype.sewing_machine_shop")
local SewingMachine_Angel = require("sewn_scripts.entities.slot.sewing_machine.subtype.sewing_machine_angel")
local SewingMachine_Devil = require("sewn_scripts.entities.slot.sewing_machine.subtype.sewing_machine_devil")

local LostButton = { }

local hasLostButton = false
local id = PickupVariant.PICKUP_TRINKET .. "." .. Enums.TrinketType.TRINKET_LOST_BUTTON

LostButton.Stats = {
    ShopBonus = 100,
    AngelDevilBonus = 50
}

function LostButton:GetLoseLostButton(player, getTrinket)
    if getTrinket then
        SewingMachine_Shop:AddChance(id, LostButton.Stats.ShopBonus)
        SewingMachine_Angel:AddChance(id, LostButton.Stats.AngelDevilBonus)
        SewingMachine_Devil:AddChance(id, LostButton.Stats.AngelDevilBonus)
        hasLostButton = true
    else
        SewingMachine_Shop:RemoveChance(id)
        SewingMachine_Angel:RemoveChance(id)
        SewingMachine_Devil:RemoveChance(id)
        hasLostButton = false
    end
end

function LostButton:NewGame()
    if hasLostButton then
        LostButton:GetLoseLostButton(nil, false)
    end
end

CustomCallbacks:AddCallback(Enums.ModCallbacks.GET_LOSE_TRINKET, LostButton.GetLoseLostButton, Enums.TrinketType.TRINKET_LOST_BUTTON)

return LostButton