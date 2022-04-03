local Enums = require("sewn_scripts.core.enums")
local Random = require("sewn_scripts.helpers.random")

local SewingMachine_Devil = { }

SewingMachine_Devil.SubType = Enums.SewingMachineSubType.DEVIL

function SewingMachine_Devil:EvaluateSpawn(rng, room, level, ignoreRandom)
    local chance = SewingMachine_Devil:GetChance()
    
    if room:GetType() == RoomType.ROOM_DEVIL and (Random:CheckRoll(chance, rng) or ignoreRandom) then
        return true
    end

    return false
end
function SewingMachine_Devil:OnDestroy(machine)
    local machineSprite = machine:GetSprite()
    machineSprite:Play("Disappear")
end
function SewingMachine_Devil:GetUpgradeLevel(currentLevel)
    return Sewn_API.Enums.FamiliarLevel.ULTRA
end


function SewingMachine_Devil:CanPay(player)
    return player:GetMaxHearts() >= 2
end
function SewingMachine_Devil:Pay(player)
    player:AddMaxHearts(-2, false)
end

return SewingMachine_Devil