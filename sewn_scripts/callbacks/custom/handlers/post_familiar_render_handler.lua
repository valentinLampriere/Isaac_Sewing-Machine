local Enums = require("sewn_scripts.core.enums")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local PostFamiliarRenderHandler = { }
PostFamiliarRenderHandler.DefaultArguments = { -1, Enums.FamiliarLevelFlag.FLAG_SUPER | Enums.FamiliarLevelFlag.FLAG_ULTRA }

PostFamiliarRenderHandler.ID = Enums.ModCallbacks.POST_FAMILIAR_RENDER

function PostFamiliarRenderHandler:PostFamiliarRender(familiar, offset)
    for _, callback in ipairs(PostFamiliarRenderHandler.RegisteredCallbacks) do
        if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
            if callback:Function(familiar, offset) == false then
                return false
            end
        end
    end
end

return PostFamiliarRenderHandler