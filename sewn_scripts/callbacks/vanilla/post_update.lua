local CustomCallbackHandler = require("sewn_scripts/callbacks/custom_callbacks_handler")
local UpgradeManager = require("sewn_scripts/core/upgrade_manager")
local Delay = require("sewn_scripts/helpers/delay")

local function MC_POST_UPDATE(_)
    CustomCallbackHandler:PostUpdate()
    UpgradeManager:CheckForChanges()
    Delay:OnUpdate()
end

return MC_POST_UPDATE
