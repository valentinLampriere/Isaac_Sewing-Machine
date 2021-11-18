local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local Enums = require("sewn_scripts.core.enums")
local SewingMachine = require("sewn_scripts.entities.slot.sewing_machine.sewing_machine")
local Random = require("sewn_scripts.helpers.random")

local PinCushion = { }

PinCushion.Stats = {
    SmeltChanceToPreventExplosion = 50
}

-- Return true to prevent the player from taking the familiar
-- Return nil to do the default behaviour
function PinCushion:PreGetFamiliarFromSewingMachine(sewingMachine, player, familiarVariant, familiarLevel, isUpgrade)
    if player:GetTrinket(0) ~= Enums.TrinketType.TRINKET_PIN_CUSHION and player:GetTrinket(1) ~= Enums.TrinketType.TRINKET_PIN_CUSHION then
        return
    end
    if isUpgrade == true then
        SewingMachine:TryGetFamiliarBack(sewingMachine, false)
        return true
    end
end
function PinCushion:PostGetFamiliarFromSewingMachine(familiar, player, sewingMachine, isUpgraded, newLevel)
    if not player:HasTrinket(Enums.TrinketType.TRINKET_PIN_CUSHION) then
        return
    end

    if player:GetTrinket(0) ~= Enums.TrinketType.TRINKET_PIN_CUSHION and player:GetTrinket(1) ~= Enums.TrinketType.TRINKET_PIN_CUSHION then
        if Random:CheckRoll(PinCushion.Stats.SmeltChanceToPreventExplosion, sewingMachine:GetDropRNG()) then
            return true -- Prevent the machine from breaking
        end
    end
end

function PinCushion:PlayerUpdate(player)
    if Input.IsActionPressed(ButtonAction.ACTION_DROP, player.ControllerIndex) and (player:GetTrinket(0) == Enums.TrinketType.TRINKET_PIN_CUSHION or player:GetTrinket(1) == Enums.TrinketType.TRINKET_PIN_CUSHION) then
        player:DropTrinket(player.Position, false)
    end
end


CustomCallbacks:AddCallback(Enums.ModCallbacks.PRE_GET_FAMILIAR_FROM_SEWING_MACHINE, PinCushion.PreGetFamiliarFromSewingMachine)
CustomCallbacks:AddCallback(Enums.ModCallbacks.POST_GET_FAMILIAR_FROM_SEWING_MACHINE, PinCushion.PostGetFamiliarFromSewingMachine)

return PinCushion