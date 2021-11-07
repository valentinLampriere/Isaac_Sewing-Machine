local Enums = require("sewn_scripts/core/enums")

local SewingMachine_Angel = { }

SewingMachine_Angel.SubType = Enums.SewingMachineSubType.ANGEL
SewingMachine_Angel.Room_Types = { RoomType.ROOM_ANGEL }
SewingMachine_Angel.BreakChanceFlat = 40
SewingMachine_Angel.ShouldDisappearOnBreak = true

function SewingMachine_Angel:CanPay(player)
    return true
end
function SewingMachine_Angel:Pay(player)
    
end

return SewingMachine_Angel