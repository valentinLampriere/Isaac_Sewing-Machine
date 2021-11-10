local Enums = require("sewn_scripts.core.enums")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local PostFamiliarNewLevel = { }

PostFamiliarNewLevel.ID = Enums.ModCallbacks.POST_FAMILIAR_NEW_LEVEL
PostFamiliarNewLevel.DefaultArguments = { -1, Enums.FamiliarLevelFlag.FLAG_SUPER | Enums.FamiliarLevelFlag.FLAG_ULTRA }

function PostFamiliarNewLevel:PostNewLevel()
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    for _, familiar in ipairs(familiars) do
        familiar = familiar:ToFamiliar()
        for _, callback in ipairs(PostFamiliarNewLevel.RegisteredCallbacks) do
            if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
                callback:Function(familiar)
            end
        end
    end
end

return PostFamiliarNewLevel