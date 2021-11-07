local Enums = require("sewn_scripts/core/enums")
local SewingMachine_Angel = require("sewn_scripts/entities/slot/sewing_machine/subtype/sewing_machine_angel")
local SewingMachine_Devil = require("sewn_scripts/entities/slot/sewing_machine/subtype/sewing_machine_devil")
local CustomCallbacks = require("sewn_scripts/callbacks/custom_callbacks")

local ContrastedButton = { }

ContrastedButton.Stats = {
    AppearChanceBonus = 50
}

function ContrastedButton:GetLoseContrastedButton(player, getTrinket)
    if getTrinket then
        SewingMachine_Angel.AppearChance = SewingMachine_Angel.AppearChance + ContrastedButton.Stats.AppearChanceBonus
        SewingMachine_Devil.AppearChance = SewingMachine_Devil.AppearChance + ContrastedButton.Stats.AppearChanceBonus
    else
        SewingMachine_Angel.AppearChance = SewingMachine_Angel.AppearChance - ContrastedButton.Stats.AppearChanceBonus
        SewingMachine_Devil.AppearChance = SewingMachine_Devil.AppearChance - ContrastedButton.Stats.AppearChanceBonus
    end
end

CustomCallbacks:AddCallback(Enums.ModCallbacks.GET_LOSE_TRINKET, ContrastedButton.GetLoseContrastedButton, Enums.TrinketType.TRINKET_CONTRASTED_BUTTON)

return ContrastedButton