local Enums = require("sewn_scripts.core.enums")
local Globals = require("sewn_scripts.core.globals")
local SewingMachineTypes = require("sewn_scripts.entities.slot.sewing_machine.sewing_machine_types")
local MachineDataManager = require("sewn_scripts.core.machine_data_manager")
local SewingMachine = require("sewn_scripts.entities.slot.sewing_machine.sewing_machine")
local Random = require("sewn_scripts.helpers.random")

local SewingMachineManager = { }

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

    SewingMachineManager:ResetMachineFloatingAnimation()
end


function SewingMachineManager:ResetMachineFloatingAnimation()
    for _, machine in ipairs(SewingMachineManager:GetAllSewingMachines()) do
        local mData = MachineDataManager:GetMachineData(machine)
        if mData.Sewn_currentFamiliarVariant ~= nil then
            SewingMachine:SetFloatingAnim(machine)
        end
    end
end

local function GetSewingMachineTypeForCurrentRoom()
    local sewingMachineTypesForRoomType = SewingMachineTypes:GetSewingMachineTypesForRoomType(Globals.Room:GetType())
    
    while #sewingMachineTypesForRoomType > 0 do
        local rollMachineType = Globals.rng:RandomInt(#sewingMachineTypesForRoomType) + 1
        local machineType = sewingMachineTypesForRoomType[rollMachineType]

        if Random:CheckRoll(machineType.AppearChance) then
            return machineType
        end

        table.remove(sewingMachineTypesForRoomType, rollMachineType)
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
    local mData = MachineDataManager:GetMachineData(machine)

    local gridPosition = Globals.Game:GetRoom():GetGridPosition(Globals.Game:GetRoom():GetGridIndex(machine.Position))

    local newMachine = SewingMachineManager:Spawn(gridPosition, false, machine.SubType)

    local new_mData = MachineDataManager:GetMachineData(newMachine)
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


-- Spawn a new Sewing Machine
function SewingMachineManager:Spawn(position, playAppearAnim, machineSubType)
    --[[local level = sewingMachineMod.currentLevel
    local room = sewingMachineMod.currentRoom

    if InfinityTrueCoopInterface ~= nil and sewingMachineMod.Config.TrueCoop_removeMachine then
        return
    end

    if position == nil then
        position = room:FindFreePickupSpawnPosition(room:GetGridPosition(27), 0, true)
    end

    if machineSubType == nil then
        if room:GetType() == RoomType.ROOM_ERROR then -- Error rooms
            machineSubType = grng:RandomInt(4)
        elseif room:GetType() == RoomType.ROOM_ISAACS or room:GetType() == RoomType.ROOM_BARREN then -- Bedrooms
            machineSubType = sewingMachineMod.SewingMachineSubType.BEDROOM
        elseif room:GetType() == RoomType.ROOM_SHOP or level:GetStage() == LevelStage.STAGE8 then -- Shops or Home
            machineSubType = sewingMachineMod.SewingMachineSubType.SHOP
        elseif room:GetType() == RoomType.ROOM_ANGEL then -- Angel rooms
            machineSubType = sewingMachineMod.SewingMachineSubType.ANGELIC
        elseif room:GetType() == RoomType.ROOM_DEVIL then -- Devil rooms
            machineSubType = sewingMachineMod.SewingMachineSubType.EVIL
        else -- Other rooms
            if grng:RandomInt(2) == 0 then
                machineSubType = sewingMachineMod.SewingMachineSubType.BEDROOM
            else
                machineSubType = sewingMachineMod.SewingMachineSubType.SHOP
            end
        end
    end

    local machine = Isaac.Spawn(EntityType.ENTITY_SLOT, sewingMachineMod.SewingMachine, machineSubType, position, v0, nil)
    if playAppearAnim == true then
        machine:GetSprite():Play("Appear", true)
    end
    --]]

    if position == nil then
        position = Globals.Room:FindFreePickupSpawnPosition(Globals.Room:GetGridPosition(27), 0, true)
    end

    if machineSubType == nil then
        local sewingMachineType = GetSewingMachineTypeForCurrentRoom()
        if sewingMachineType ~= nil then
            machineSubType = sewingMachineType.SubType
        end
    end

    local machine = Isaac.Spawn(EntityType.ENTITY_SLOT, Enums.SlotMachineVariant.SEWING_MACHINE, machineSubType or GetDefaultMachineSubType(), position, Globals.V0, nil)
    if playAppearAnim == true then
        machine:GetSprite():Play("Appear", true)
    end
    
    return machine
end

function SewingMachineManager:TryToSpawnMachineOnRoomClear()
    local sewingMachineType = GetSewingMachineTypeForCurrentRoom()
    if sewingMachineType ~= nil then
        SewingMachineManager:Spawn(nil, sewingMachineType.PlayAppearAnimOnNewRoom, sewingMachineType.SubType)
    end
end

function SewingMachineManager:TryToSpawnMachineOnNewRoom()
    if Globals.Room:IsFirstVisit() == true and Globals.Room:IsClear() then
        -- Do not spawn machines in extra rooms
        if StageAPI and StageAPI.InExtraRoom() then
            return
        end

        local sewingMachineType = GetSewingMachineTypeForCurrentRoom()
        if sewingMachineType ~= nil then
            SewingMachineManager:Spawn(nil, sewingMachineType.PlayAppearAnimOnNewRoom, sewingMachineType.SubType)
        end
    end
end


----------------------
-- MC_POST_NEW_ROOM --
----------------------
function SewingMachineManager:OnNewRoom()
    SewingMachineManager:TryToSpawnMachineOnNewRoom()
    SewingMachineManager:ResetMachineFloatingAnimation()
end

return SewingMachineManager