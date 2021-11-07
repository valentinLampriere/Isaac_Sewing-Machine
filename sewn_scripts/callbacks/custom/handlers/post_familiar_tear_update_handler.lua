local Enums = require("sewn_scripts/core/enums")
local CallbackFamiliarArgument = require("sewn_scripts/helpers/callback_familiar_argument")

local PostFamiliarTearUpdateHandler = { }
PostFamiliarTearUpdateHandler.DefaultArguments = { -1, Enums.FamiliarLevelFlag.SUPER | Enums.FamiliarLevelFlag.ULTRA }

PostFamiliarTearUpdateHandler.ID = Enums.ModCallbacks.POST_FAMILIAR_TEAR_UPDATE

function PostFamiliarTearUpdateHandler:PostTearUpdate(tear)
    local familiar = tear.Parent
    local fData
    
    -- If tear hasn't been fired from a familiar
    if tear.SpawnerType ~= EntityType.ENTITY_FAMILIAR or familiar == nil or familiar:Exists() == false then
        return
    end
    
    familiar = familiar:ToFamiliar()
    fData = familiar:GetData()

    for _, callback in ipairs(PostFamiliarTearUpdateHandler.RegisteredCallbacks) do
        if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
            callback:Function(familiar, tear)
        end
    end
end

return PostFamiliarTearUpdateHandler