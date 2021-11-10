local Enums = require("sewn_scripts.core.enums")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local PostFamiliarPlayAnimHandler = { }
PostFamiliarPlayAnimHandler.DefaultArguments = { -1, Enums.FamiliarLevelFlag.FLAG_SUPER | Enums.FamiliarLevelFlag.FLAG_ULTRA, "" }

PostFamiliarPlayAnimHandler.ID = Enums.ModCallbacks.POST_FAMILIAR_PLAY_ANIM

function PostFamiliarPlayAnimHandler:FamiliarUpdate(familiar)
    for _, callback in ipairs(PostFamiliarPlayAnimHandler.RegisteredCallbacks) do
        if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
            local sprite = familiar:GetSprite()
            local animIndex = 3
            while callback.Argument[animIndex] ~= nil do
                if sprite:IsPlaying(callback.Argument[animIndex]) then
                    callback:Function(familiar, sprite)
                end
                animIndex = animIndex + 1
            end
        end
    end
end

return PostFamiliarPlayAnimHandler