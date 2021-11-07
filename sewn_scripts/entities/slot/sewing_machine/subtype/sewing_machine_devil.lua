local Enums = require("sewn_scripts.core.enums")

local SewingMachine_Devil = { }

SewingMachine_Devil.SubType = Enums.SewingMachineSubType.DEVIL
SewingMachine_Devil.Room_Types = { RoomType.ROOM_DEVIL }
SewingMachine_Devil.ShouldDisappearOnBreak = true
SewingMachine_Devil.FixedUpgradeLevel = Sewn_API.Enums.FamiliarLevel.ULTRA

function SewingMachine_Devil:CanPay(player)
    return player:GetMaxHearts() >= 2
end
function SewingMachine_Devil:Pay(player)
    player:AddMaxHearts(-2, false)
end

return SewingMachine_Devil