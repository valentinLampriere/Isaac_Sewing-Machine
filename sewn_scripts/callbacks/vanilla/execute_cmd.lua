local CustomCallbacksHandler = require("sewn_scripts.callbacks.custom_callbacks_handler")
local Debug = require("sewn_scripts.debug.debug")
local StringHelper = require("sewn_scripts.helpers.string_helper")

local function MC_EXECUTE_CMD(_, cmd, args)
    local _args = StringHelper:Split(args, " ")
    CustomCallbacksHandler:ExecuteCmd(cmd, _args)
    Debug:OnExecuteCmd(cmd, _args)
end

return MC_EXECUTE_CMD
