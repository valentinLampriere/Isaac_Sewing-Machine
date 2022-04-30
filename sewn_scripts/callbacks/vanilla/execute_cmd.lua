local CustomCallbacksHandler = require("sewn_scripts.callbacks.custom_callbacks_handler")

local function MC_EXECUTE_CMD(_, cmd, args)
    CustomCallbacksHandler:ExecuteCmd(cmd, args)
end

return MC_EXECUTE_CMD
