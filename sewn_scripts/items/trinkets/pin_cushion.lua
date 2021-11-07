local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local Enums = require("sewn_scripts.core.enums")
local SewingMachine = require("sewn_scripts.entities.slot.sewing_machine.sewing_machine")
local Delay = require("sewn_scripts.helpers.delay")

local PinCushion = { }

-- Return true to prevent the player from taking the familiar
-- Return nil to do the default behaviour
function PinCushion:PreGetFamiliarFromSewingMachine(sewingMachine, player, familiarVariant, familiarLevel, isUpgrade)
    if not player:HasTrinket(Enums.TrinketType.TRINKET_PIN_CUSHION) then
        return
    end
    if isUpgrade == true then
        SewingMachine:TryGetFamiliarBack(sewingMachine, false)
        return true
    end
end


CustomCallbacks:AddCallback(Enums.ModCallbacks.PRE_GET_FAMILIAR_FROM_SEWING_MACHINE, PinCushion.PreGetFamiliarFromSewingMachine)

return PinCushion