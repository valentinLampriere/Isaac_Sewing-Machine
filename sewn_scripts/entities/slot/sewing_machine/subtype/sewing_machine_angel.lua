local Enums = require("sewn_scripts.core.enums")
local Random = require("sewn_scripts.helpers.random")

local SewingMachine_Angel = { }

SewingMachine_Angel.SubType = Enums.SewingMachineSubType.ANGEL

SewingMachine_Angel.BreakChanceFlat = 25
SewingMachine_Angel.BreakChancePerUse = 25

function SewingMachine_Angel:EvaluateSpawn(rng, room, level, ignoreRandom)
    local chance = SewingMachine_Angel:GetChance()
    
    if room:GetType() == RoomType.ROOM_ANGEL and (Random:CheckRoll(chance, rng) or ignoreRandom) then
        return true
    end

    return false
end
function SewingMachine_Angel:OnDestroy(machine)
    local machineSprite = machine:GetSprite()
    machineSprite:Play("Disappear")
end




function SewingMachine_Angel:CanPay(player)
    return true
end
function SewingMachine_Angel:Pay(player)

end



return SewingMachine_Angel