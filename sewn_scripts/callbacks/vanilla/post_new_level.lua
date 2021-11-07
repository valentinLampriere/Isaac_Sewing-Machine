local Globals = require("sewn_scripts.core.globals")
local MachineDataManager = require("sewn_scripts.core.machine_data_manager")
local UpgradeManager = require("sewn_scripts.core.upgrade_manager")
local Player = require("sewn_scripts.entities.player.player")

local function MC_POST_NEW_LEVEL(_)
    Globals.Level = Globals.game:GetLevel()

    MachineDataManager:ResetMachinesData()

    Player:ResetFamiliarsInMachineForPlayers()
    UpgradeManager:ResetUpgrades(true)
end

return MC_POST_NEW_LEVEL