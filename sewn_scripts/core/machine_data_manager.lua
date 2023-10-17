local Globals = require("sewn_scripts.core.globals")
local Enums = require("sewn_scripts.core.enums")

local MachineDataManager = { }

MachineDataManager.MachineData = { }

function MachineDataManager:GetMachineData(sewingMachine)
    if MachineDataManager.MachineData[sewingMachine.InitSeed] == nil then
        MachineDataManager.MachineData[sewingMachine.InitSeed] = {
            Sewn_player = nil, -- Store the player who put the familiar in the machine
            Sewn_currentFamiliarVariant = nil, -- The familiar (it variant) which is in the machine
            Sewn_currentFamiliarLevel = nil, -- The level of the familiar in the machine
            Sewn_touchCooldown = 0
        }
    end
    return MachineDataManager.MachineData[sewingMachine.InitSeed]
end
function MachineDataManager:ResetMachinesData()
    MachineDataManager.MachineData = { }
end

function MachineDataManager:SaveMachineData()
    local machinesSave = { }
    for machineId, machineValues in pairs(MachineDataManager.MachineData) do
        machinesSave[tostring(machineId)] = { }
        for key, value in pairs(machineValues) do
            if key == "Sewn_player" then
                machinesSave[tostring(machineId)][key] = value:GetName()
            else
                machinesSave[tostring(machineId)][key] = value
            end
        end
    end
    return machinesSave
end
function MachineDataManager:LoadMachineData(loadedData)
    MachineDataManager.MachineData = { }
    for machineId, machineValues in pairs(loadedData) do
        MachineDataManager.MachineData[tonumber(machineId)] = {}
        for key, value in pairs(machineValues) do
            if key == "Sewn_player" then
                for i = 1, Globals.Game:GetNumPlayers() do
                    local player = Isaac.GetPlayer(i - 1)
                    if player:GetName() == value then
                        MachineDataManager.MachineData[tonumber(machineId)][key] = player
                    end
                end
            else
                MachineDataManager.MachineData[tonumber(machineId)][key] = value
            end
        end
    end
end

function MachineDataManager:TryMatchMachineData(machine)
    local _mData = machine:GetData()
    if _mData.Sewn_machineInit == nil then
        _mData.SewingMachineData = setmetatable({},
        {
            __index = function(t, k)
                return MachineDataManager:GetMachineData(machine)[k]
            end,
            __newindex = function(t, k, v)
                MachineDataManager.MachineData[machine.InitSeed][k] = v
                --MachineDataManager:GetMachineData(machine)[k] = v
            end,
        })
        _mData.Sewn_machineInit = true
    end
end

--[[require("sewn_scripts.helpers.apioverride")

local OldGetData = APIOverride.GetCurrentClassFunction(Entity, "GetData")
APIOverride.OverrideClassFunction(Entity, "GetData", function(entity)
    if entity.Type == EntityType.ENTITY_SLOT and entity.Variant == Enums.SlotMachineVariant.SEWING_MACHINE then
        return MachineDataManager:GetMachineData(entity)
    end
    return OldGetData(entity)
end)--]]
return MachineDataManager