local Enums = require("sewn_scripts.core.enums")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")

local SewingMachine_Shop = require("sewn_scripts.entities.slot.sewing_machine.subtype.sewing_machine_shop")
local SewingMachine_Angel = require("sewn_scripts.entities.slot.sewing_machine.subtype.sewing_machine_angel")
local SewingMachine_Devil = require("sewn_scripts.entities.slot.sewing_machine.subtype.sewing_machine_devil")

local LostButton = { }

local hasLostButton = false

LostButton.Stats = {
    ShopBonus = 100 - SewingMachine_Shop.AppearChance,
    AngelDevilBonus = 50
}

function LostButton:GetLoseLostButton(player, getTrinket)
    if getTrinket then
        SewingMachine_Shop.AppearChance = SewingMachine_Shop.AppearChance + LostButton.Stats.ShopBonus
        SewingMachine_Angel.AppearChance = SewingMachine_Angel.AppearChance + LostButton.Stats.AngelDevilBonus
        SewingMachine_Devil.AppearChance = SewingMachine_Devil.AppearChance + LostButton.Stats.AngelDevilBonus
        hasLostButton = true
    else
        SewingMachine_Shop.AppearChance = SewingMachine_Shop.AppearChance - LostButton.Stats.ShopBonus
        SewingMachine_Angel.AppearChance = SewingMachine_Angel.AppearChance - LostButton.Stats.AngelDevilBonus
        SewingMachine_Devil.AppearChance = SewingMachine_Devil.AppearChance - LostButton.Stats.AngelDevilBonus
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