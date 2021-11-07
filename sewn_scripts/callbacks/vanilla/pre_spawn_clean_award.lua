local SewingMachineManager = require("sewn_scripts.core.sewing_machine_manager")

local function MC_PRE_SPAWN_CLEAN_AWARD(_)
    SewingMachineManager:TryToSpawnMachineOnRoomClear()
end

return MC_PRE_SPAWN_CLEAN_AWARD
