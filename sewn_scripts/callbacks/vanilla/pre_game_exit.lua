local Globals = require("sewn_scripts/core/globals")
local SaveManager = require("sewn_scripts/core/save_manager")

local function MC_PRE_GAME_EXIT(_)
    SaveManager:SaveGame()
end

return MC_PRE_GAME_EXIT
