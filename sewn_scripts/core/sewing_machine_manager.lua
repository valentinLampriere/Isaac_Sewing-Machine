local Enums = require("sewn_scripts.core.enums")
local Globals = require("sewn_scripts.core.globals")
local SewingMachineTypes = require("sewn_scripts.entities.slot.sewing_machine.sewing_machine_types")
local MachineDataManager = require("sewn_scripts.core.machine_data_manager")
local SewingMachine = require("sewn_scripts.entities.slot.sewing_machine.sewing_machine")
local Random = require("sewn_scripts.helpers.random")

local SewingMachineManager = { }

local sewingMachineAlreadySpawn = false

-- Return a table with all the Sewing machines
function SewingMachineManager:GetAllSewingMachines(subtype)
    subtype = subtype or -1
    local allSewingMachine = {}
    for _, machine in pairs(Isaac.FindByType(EntityType.ENTITY_SLOT, Enums.SlotMachineVariant.SEWING_MACHINE, subtype, false, false)) do
        local _mData = machine:GetData()
        if _mData.Sewn_isMachineBroken ~= true then
            table.insert(allSewingMachine, machine)
        end
    end
    return allSewingMachine
end

function SewingMachineManager:SaveMachines()
    return MachineDataManager:SaveMachineData()
end
function SewingMachineManager:LoadMachines(loadedData)
    MachineDataManager:LoadMachineData(loadedData)
    for _, machine in ipairs(SewingMachineManager:GetAllSewingMachines()) do
        SewingMachine:ResetFloatingAnim(machine)
    end
end
local function GetDefaultMachineSubType()
    local sewingMachineTypes = SewingMachineTypes:GetSewingMachineTypes()
    local defaultSewingMachines = { }
    for subType, machineType in pairs(sewingMachineTypes) do
        if machineType.IsDefaultMachine == true then
            table.insert(defaultSewingMachines, machineType.SubType)
        end
    end
    local roll = Globals.rng:RandomInt(#defaultSewingMachines) + 1
    return defaultSewingMachines[roll] or 0
end

-- POST_MACHINE_DESTROY --
-- Remove the machine and spawn a similar one
function SewingMachineManager:RepairMachine(machine)
    local mData = machine:GetData().SewingMachineData

    local gridPosition = Globals.Game:GetRoom():GetGridPosition(Globals.Game:GetRoom():GetGridIndex(machine.Position))

    local newMachine = SewingMachineManager:Spawn(gridPosition, false, machine.SubType)

    local new_mData = newMachine:GetData().SewingMachineData
    new_mData = mData

    for i = 1, Globals.Game:GetNumPlayers() do
        local player = Isaac.GetPlayer(i - 1)
        local pData = player:GetData()
        if pData.Sewn_familiarsInMachine ~= nil then
            pData.Sewn_familiarsInMachine[newMachine.InitSeed] = pData.Sewn_familiarsInMachine[machine.InitSeed]
            pData.Sewn_familiarsInMachine[machine.InitSeed] = nil
        end
    end

    mData = nil

    machine:Remove()

    return newMachine
end



-- Evaluate spawn chances for each machines types and return if a machine should spawn (boolean) and the machine type (sewing_machine_type). If several machine types are correctly evaluated, a random one is choosen among all of them.
local function EvaluateSpawns(ignoreRandom)
    local sewingMachineType = SewingMachineTypes:GetSewingMachineTypes()
    local validSewingMachines = { }

    local room = Globals.Room
    local rng = RNG()
    rng:SetSeed(room:GetAwardSeed(), 1)

    for subType, machineType in pairs(sewingMachineType) do
        if machineType:EvaluateSpawn(rng, room, Globals.Level, ignoreRandom) == true then
            table.insert(validSewingMachines, machineType)
        end
    end

    if #validSewingMachines == 0 then
        return false
    end

    local roll = rng:RandomInt(#validSewingMachines) + 1

    return true, validSewingMachines[roll]
end

-- Spawn the first machine which is evaluated for the current room
local function TrySpawnMachine()
    local shouldSpawnMachine, spawnMachineType = EvaluateSpawns(false)

    if shouldSpawnMachine == true then
        SewingMachineManager:Spawn(nil, spawnMachineType.PlayAppearAnimOnNewRoom, spawnMachineType.SubType)

        sewingMachineAlreadySpawn = true
    end
end

-- Spawn a new Sewing Machine
function SewingMachineManager:Spawn(position, playAppearAnim, machineSubType)
    if position == nil then
        position = Globals.Room:FindFreePickupSpawnPosition(Globals.Room:GetGridPosition(27), 0, true)
    end

    if machineSubType == nil then
        local shouldSpawnMachine, spawnMachineType = EvaluateSpawns(true)

        if shouldSpawnMachine == true then
            machineSubType = spawnMachineType.SubType
        else
            machineSubType = Random:CheckRoll(50) and Enums.SewingMachineSubType.BEDROOM or Enums.SewingMachineSubType.SHOP
        end
    end

    local machine = Isaac.Spawn(EntityType.ENTITY_SLOT, Enums.SlotMachineVariant.SEWING_MACHINE, machineSubType or GetDefaultMachineSubType(), position, Globals.V0, nil)
    
    if playAppearAnim == true then
        machine:GetSprite():Play("Appear", true)
    end
    
    return machine
end

function SewingMachineManager:TryToSpawnMachineOnRoomClear()
    if sewingMachineAlreadySpawn == false then
        TrySpawnMachine()
    end
end

function SewingMachineManager:TryToSpawnMachineOnNewRoom()
    sewingMachineAlreadySpawn = false

    if Globals.Room:IsFirstVisit() == true and Globals.Room:IsClear() and Globals.Level ~= nil then
        -- Do not spawn machines in extra rooms
        if StageAPI and StageAPI.InExtraRoom and StageAPI.InExtraRoom() then
            return
        end

        TrySpawnMachine()
    end
end


----------------------
-- MC_POST_NEW_ROOM --
----------------------
function SewingMachineManager:OnNewRoom()
    SewingMachineManager:TryToSpawnMachineOnNewRoom()
    
    for _, machine in ipairs(SewingMachineManager:GetAllSewingMachines()) do
        MachineDataManager:TryMatchMachineData(machine)
        SewingMachine:ResetFloatingAnim(machine)
    end
end

return SewingMachineManager