local SewingMachineManager = require("sewn_scripts.core.sewing_machine_manager")
local CustomCallbacksHandler = require("sewn_scripts.callbacks.custom_callbacks_handler")


local function MC_PRE_SPAWN_CLEAN_AWARD(_)
    SewingMachineManager:TryToSpawnMachineOnRoomClear()
    CustomCallbacksHandler:PreSpawnCleanAward()
end

return MC_PRE_SPAWN_CLEAN_AWARD
