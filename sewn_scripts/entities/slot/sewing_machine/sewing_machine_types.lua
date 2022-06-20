local SewingMachine_Bedroom = require("sewn_scripts.entities.slot.sewing_machine.subtype.sewing_machine_bedroom")
local SewingMachine_Shop = require("sewn_scripts.entities.slot.sewing_machine.subtype.sewing_machine_shop")
local SewingMachine_Angel = require("sewn_scripts.entities.slot.sewing_machine.subtype.sewing_machine_angel")
local SewingMachine_Devil = require("sewn_scripts.entities.slot.sewing_machine.subtype.sewing_machine_devil")

local Globals = require("sewn_scripts.core.globals")
local Enums = require("sewn_scripts.core.enums")

local SewingMachineTypes = { }
local machineTypes = {
    [Enums.SewingMachineSubType.BEDROOM] = SewingMachine_Bedroom,
    [Enums.SewingMachineSubType.SHOP] = SewingMachine_Shop,
    [Enums.SewingMachineSubType.ANGEL] = SewingMachine_Angel,
    [Enums.SewingMachineSubType.DEVIL] = SewingMachine_Devil
}

local function InitMachineType(machineType)
    machineType.Parent = SewingMachineTypes
    machineType.Stats = machineType.Stats or {}

    machineType.AppearChance = machineType.AppearChance or 0

    machineType.AppearChancesBonus = { }
    machineType.AddChance = function (_, source, chance) SewingMachineTypes:AddChance(machineType, source, chance) end
    machineType.RemoveChance = function (_, source) SewingMachineTypes:RemoveChance(machineType, source) end
    machineType.GetChance = function (_) return SewingMachineTypes:GetChance(machineType) end
    machineType.OnDestroy = machineType.OnDestroy or function (_, machine) SewingMachineTypes:OnDestroy(machine) end
    machineType.GetUpgradeLevel = machineType.GetUpgradeLevel or function (_, currentLevel) SewingMachineTypes:GetUpgradeLevel(currentLevel) end
end
InitMachineType(machineTypes[Enums.SewingMachineSubType.BEDROOM])
InitMachineType(machineTypes[Enums.SewingMachineSubType.SHOP])
InitMachineType(machineTypes[Enums.SewingMachineSubType.ANGEL])
InitMachineType(machineTypes[Enums.SewingMachineSubType.DEVIL])

function SewingMachineTypes:AddChance(machineType, source, chance)
    machineType.AppearChancesBonus[source] = chance;
end
function SewingMachineTypes:RemoveChance(machineType, source)
    machineType.AppearChancesBonus[source] = nil;
end
function SewingMachineTypes:GetChance(machineType)
    local chance = machineType.Stats.SpawnChance or 0
    for _source, _chance in pairs(machineType.AppearChancesBonus) do
        chance = chance + _chance
    end
    return chance
end
function SewingMachineTypes:OnDestroy(machine)
    local machineSprite = machine:GetSprite()
    machineSprite:Play("Broken")
    Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BOMB_EXPLOSION, 0, machine.Position, Globals.V0, nil)
end
function SewingMachineTypes:GetUpgradeLevel(currentLevel)
    return currentLevel + 1
end


function SewingMachineTypes:IsHomeClosetRoom(room, level)
    level = level or Globals.Game:GetLevel()
    if level:GetStage() == LevelStage.STAGE8 and room:GetRoomShape() == RoomShape.ROOMSHAPE_IH then
        if room:GetDoor(DoorSlot.LEFT0) ~= nil then
            return true
        end
    end
    return false
end




function SewingMachineTypes:CanPay(player, subType)
    return machineTypes[subType]:CanPay(player)
end
function SewingMachineTypes:Pay(player, subType)
    machineTypes[subType]:Pay(player)
end
function SewingMachineTypes:GetSewingMachineTypes()
    return machineTypes
end
function SewingMachineTypes:GetSewingMachineType(machineSubType)
    return machineTypes[machineSubType]
end
function SewingMachineTypes:UpdateMachine(machine)
    if machineTypes[machine.SubType].Update == nil then
        return
    end
    machineTypes[machine.SubType].Update(machine)
end

return SewingMachineTypes