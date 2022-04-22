local Enums = require("sewn_scripts.core.enums")

local SewingMachine_Bedroom = { }

SewingMachine_Bedroom.SubType = Enums.SewingMachineSubType.BEDROOM
SewingMachine_Bedroom.PlayAppearAnimOnNewRoom = true

function SewingMachine_Bedroom:CanPay(player)
    return player:GetSoulHearts() >= 2
end
function SewingMachine_Bedroom:Pay(player)
    player:AddSoulHearts(-2)

    if player:GetHearts() + player:GetSoulHearts() == 0 then
        player:Die()
    end
end

function SewingMachine_Bedroom:EvaluateSpawn(rng, room, level, ignoreRandom)
    if room:GetType() == RoomType.ROOM_ISAACS or room:GetType() == RoomType.ROOM_BARREN then
        return true
    end
    return false
end

return SewingMachine_Bedroom