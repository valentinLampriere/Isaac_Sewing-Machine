local Globals = require("sewn_scripts.core.globals")
local SewingMachineManager = require("sewn_scripts.core.sewing_machine_manager")
local UpgradeManager = require("sewn_scripts.core.upgrade_manager")
local json = require("json")

local SaveManager = { }
local mod

function SaveManager:Init(_mod)
    mod = _mod
end

local function SavePlayers()
    local playersSave = { }
    for i = 1, Globals.Game:GetNumPlayers() do
        local player = Isaac.GetPlayer(i - 1)
        local pData = player:GetData()
        playersSave[i] = { }
        if pData.Sewn_familiarsInMachine ~= nil then
            playersSave[i].Sewn_familiarsInMachine = { }
            for machineId, familiarVariant in pairs(pData.Sewn_familiarsInMachine) do
                playersSave[i].Sewn_familiarsInMachine[tostring(machineId)] = familiarVariant
            end
        end
    end
    return playersSave
end

function SaveManager:SaveGame()
    local saveData = {}
    saveData.config = {}
    saveData.players = SavePlayers()
    saveData.machines = SewingMachineManager:SaveMachines()
    saveData.familiars = UpgradeManager:SaveUpgrades()

    mod:SaveData(json.encode(saveData))
end

local function LoadPlayers(loadedData)
    for i = 1, Globals.Game:GetNumPlayers() do
        local player = Isaac.GetPlayer(i - 1)
        local pData = player:GetData()
        pData.Sewn_familiarsInMachine = {}
        if loadedData[i] ~= nil and loadedData[i].Sewn_familiarsInMachine ~= nil then
            for key, value in pairs(loadedData[i].Sewn_familiarsInMachine) do
                pData.Sewn_familiarsInMachine[tonumber(key)] = value
            end
        end
        player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
        player:EvaluateItems()
    end
end

function SaveManager:LoadSave()

    if not Isaac.HasModData(mod) then
        return
    end
    local loadedData = json.decode(Isaac.LoadModData(mod))
    if loadedData == nil then
        return
    end
    LoadPlayers(loadedData.players)
    SewingMachineManager:LoadMachines(loadedData.machines)
    UpgradeManager:LoadUpgrades(loadedData.familiars)
end

return SaveManager