local Enums = require("sewn_scripts.core.enums")
local StringHelper = require("sewn_scripts.helpers.string_helper")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local ExecuteCmdFamiliarHandler = { }

ExecuteCmdFamiliarHandler.ID = Enums.ModCallbacks.EXECUTE_CMD_FAMILIAR
ExecuteCmdFamiliarHandler.DefaultArguments = { -1, Enums.FamiliarLevelFlag.FLAG_SUPER | Enums.FamiliarLevelFlag.FLAG_ULTRA }

function ExecuteCmdFamiliarHandler:ExecuteCmd(cmd, args)
    if cmd == "sewn" then
        local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
        for _, familiar in ipairs(familiars) do
            familiar = familiar:ToFamiliar()
            for _, callback in ipairs(ExecuteCmdFamiliarHandler.RegisteredCallbacks) do
                if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
                    if callback:Function(familiar, args) == false then
                        return false
                    end
                end
            end
        end
    end
end

return ExecuteCmdFamiliarHandler