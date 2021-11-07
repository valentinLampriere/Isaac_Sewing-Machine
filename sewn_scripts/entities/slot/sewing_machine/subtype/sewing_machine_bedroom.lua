local Enums = require("sewn_scripts/core/enums")

local SewingMachine_Bedroom = { }

SewingMachine_Bedroom.SubType = Enums.SewingMachineSubType.BEDROOM
SewingMachine_Bedroom.Room_Types = { RoomType.ROOM_ISAACS, RoomType.ROOM_BARREN }
SewingMachine_Bedroom.IsDefaultMachine = true
SewingMachine_Bedroom.PlayAppearAnimOnNewRoom = true
SewingMachine_Bedroom.ShouldExplodeOnBreak = true


function SewingMachine_Bedroom:CanPay(player)
    return player:GetSoulHearts() >= 2
end
function SewingMachine_Bedroom:Pay(player)
    player:AddSoulHearts(-2)
end

return SewingMachine_Bedroom