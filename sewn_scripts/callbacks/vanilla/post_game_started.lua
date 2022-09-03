local UpgradeManager = require("sewn_scripts.core.upgrade_manager")
local MachineDataManager = require("sewn_scripts.core.machine_data_manager")
local SaveManager = require("sewn_scripts.core.save_manager")
local Delay = require("sewn_scripts.helpers.delay")
local LostButton = require("sewn_scripts.items.trinkets.lost_button")
local Lilith = require("sewn_scripts.entities.player.lilith")

local function MC_POST_GAME_STARTED(_, isExistingRun)
    if not isExistingRun then
        UpgradeManager:ResetUpgrades()
        MachineDataManager:ResetMachinesData()
        LostButton:NewGame()
    else
        SaveManager:LoadSave()
    end
    Delay:OnGameStart(isExistingRun)
    Lilith:NewGame()
end

return MC_POST_GAME_STARTED
