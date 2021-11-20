local Enums = require("sewn_scripts.core.enums")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local PostFamiliarInit = { }
PostFamiliarInit.DefaultArguments = { -1, Enums.FamiliarLevelFlag.FLAG_SUPER | Enums.FamiliarLevelFlag.FLAG_ULTRA }

PostFamiliarInit.ID = Enums.ModCallbacks.POST_FAMILIAR_INIT

function PostFamiliarInit:FamiliarUpdate(familiar)
    local fData = familiar:GetData()
    if fData.Sewn_familiarInit == nil then
        for _, callback in ipairs(PostFamiliarInit.RegisteredCallbacks) do
            if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
                callback:Function(familiar)
            end
        end
        fData.Sewn_familiarInit = true
    end
end

function PostFamiliarInit:Init()
    CustomCallbacks:AddCallback(Enums.ModCallbacks.FAMILIAR_UPDATE, PostFamiliarInit.FamiliarUpdate)
end

return PostFamiliarInit