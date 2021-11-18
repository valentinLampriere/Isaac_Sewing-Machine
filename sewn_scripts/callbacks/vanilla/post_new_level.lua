local Globals = require("sewn_scripts.core.globals")
local MachineDataManager = require("sewn_scripts.core.machine_data_manager")
local UpgradeManager = require("sewn_scripts.core.upgrade_manager")
local Player = require("sewn_scripts.entities.player.player")
local CustomCallbacksHandler = require("sewn_scripts.callbacks.custom_callbacks_handler")
local TaintedLazarus = require("sewn_scripts.entities.player.tainted_lazarus")

local function MC_POST_NEW_LEVEL(_)
    Globals.Level = Globals.Game:GetLevel()

    MachineDataManager:ResetMachinesData()

    Player:ResetFamiliarsInMachineForPlayers()
    UpgradeManager:ResetUpgrades(true)

    CustomCallbacksHandler:PostNewLevel()

    TaintedLazarus:OnNewFloor()
    
end

return MC_POST_NEW_LEVEL
