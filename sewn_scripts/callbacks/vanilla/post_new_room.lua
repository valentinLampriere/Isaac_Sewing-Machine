local SewingMachineManager = require("sewn_scripts.core.sewing_machine_manager")
local Delay = require("sewn_scripts.helpers.delay")
local Globals = require("sewn_scripts.core.globals")
local UpgradeManager = require("sewn_scripts.core.upgrade_manager")
local SewingCase = require("sewn_scripts.items.trinkets.sewing_case")
local CustomCallbacksHandler = require("sewn_scripts.callbacks.custom_callbacks_handler")
local BoxOfFriends = require("sewn_scripts.items.active.box_of_friends")
local TheTwins = require("sewn_scripts.items.trinkets.the_twins")
local GlowingHourglass = require("sewn_scripts.items.active.glowing_hourglass")

local function MC_POST_NEW_ROOM(_)
    Globals.Room = Globals.Game:GetRoom()
    SewingMachineManager:OnNewRoom()
    Delay:OnNewRoom()
    UpgradeManager:ResetTemporaryUpgrades()
    SewingCase:OnNewRoom()
    CustomCallbacksHandler:PostNewRoom()
    BoxOfFriends:OnNewRoom()
    TheTwins:OnNewRoom()
    GlowingHourglass:OnNewRoom()
end

return MC_POST_NEW_ROOM
