local Enums = require("sewn_scripts.core.enums")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local ExecuteCmdFamiliarHandler = { }

ExecuteCmdFamiliarHandler.ID = Enums.ModCallbacks.EXECUTE_CMD_FAMILIAR
ExecuteCmdFamiliarHandler.DefaultArguments = { -1, Enums.FamiliarLevelFlag.FLAG_SUPER | Enums.FamiliarLevelFlag.FLAG_ULTRA }

local function split (str, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = { }
    for s in string.gmatch(str, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

function ExecuteCmdFamiliarHandler:ExecuteCmd(cmd, args)
    if cmd == "sewn" then
        local _args = split(args, ",")
        local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
        for _, familiar in ipairs(familiars) do
            familiar = familiar:ToFamiliar()
            for _, callback in ipairs(ExecuteCmdFamiliarHandler.RegisteredCallbacks) do
                if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
                    if callback:Function(familiar, _args) == false then
                        return false
                    end
                end
            end
        end
    end
end

return ExecuteCmdFamiliarHandler