local Enums = require("sewn_scripts/core/enums")
local SewingMachine_Shop = require("sewn_scripts/entities/slot/sewing_machine/subtype/sewing_machine_shop")
local CustomCallbacks = require("sewn_scripts/callbacks/custom_callbacks")

local LostButton = { }

local bonus = 100 - SewingMachine_Shop.AppearChance

function LostButton:GetLoseLostButton(player, getTrinket)
    if getTrinket then
        SewingMachine_Shop.AppearChance = SewingMachine_Shop.AppearChance + bonus
    else
        SewingMachine_Shop.AppearChance = SewingMachine_Shop.AppearChance - bonus
    end
end

CustomCallbacks:AddCallback(Enums.ModCallbacks.GET_LOSE_TRINKET, LostButton.GetLoseLostButton, Enums.TrinketType.TRINKET_LOST_BUTTON)

return LostButton