local SewingMachine_Bedroom = require("sewn_scripts.entities.slot.sewing_machine.subtype.sewing_machine_bedroom")
local SewingMachine_Shop = require("sewn_scripts.entities.slot.sewing_machine.subtype.sewing_machine_shop")
local SewingMachine_Angel = require("sewn_scripts.entities.slot.sewing_machine.subtype.sewing_machine_angel")
local SewingMachine_Devil = require("sewn_scripts.entities.slot.sewing_machine.subtype.sewing_machine_devil")

local Enums = require("sewn_scripts.core.enums")

local SewingMachineTypes = { }
local machineTypes = {
    [Enums.SewingMachineSubType.BEDROOM] = SewingMachine_Bedroom,
    [Enums.SewingMachineSubType.SHOP] = SewingMachine_Shop,
    [Enums.SewingMachineSubType.ANGEL] = SewingMachine_Angel,
    [Enums.SewingMachineSubType.DEVIL] = SewingMachine_Devil
}

local function InitMachineType(machineType)
    machineType.AppearChance = machineType.AppearChance or 0
end
InitMachineType(machineTypes[Enums.SewingMachineSubType.BEDROOM])
InitMachineType(machineTypes[Enums.SewingMachineSubType.SHOP])
InitMachineType(machineTypes[Enums.SewingMachineSubType.ANGEL])
InitMachineType(machineTypes[Enums.SewingMachineSubType.DEVIL])

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
function SewingMachineTypes:GetSewingMachineTypesForRoomType(roomType)
    local sewingMachineTypesForRoomType = { }
    local _machineAlreadyAdded = { }
    for subType, machineType in pairs(machineTypes) do
        if machineType.Room_Types ~= nil and _machineAlreadyAdded[subType] == nil then
            for _, machineRoomType in ipairs(machineType.Room_Types) do
                if machineRoomType == roomType then
                    table.insert(sewingMachineTypesForRoomType, machineType)
                    _machineAlreadyAdded[subType] = true
                    break
                end
            end
        end
    end
    return sewingMachineTypesForRoomType
end

return SewingMachineTypes