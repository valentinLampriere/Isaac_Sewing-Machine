local Enums = require("sewn_scripts.core.enums")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local PostFamiliarTearUpdateHandler = { }
PostFamiliarTearUpdateHandler.DefaultArguments = { -1, Enums.FamiliarLevelFlag.FLAG_SUPER | Enums.FamiliarLevelFlag.FLAG_ULTRA }

PostFamiliarTearUpdateHandler.ID = Enums.ModCallbacks.POST_FAMILIAR_TEAR_UPDATE

function PostFamiliarTearUpdateHandler:PostTearUpdate(tear)
    local familiar = tear.Parent
    
    if tear.Parent ~= nil or tear.SpawnerEntity ~= nil and tear.SpawnerEntity.Type == EntityType.ENTITY_FAMILIAR then
        familiar = familiar or tear.SpawnerEntity
        familiar = familiar:ToFamiliar()
        if familiar == nil then
            return
        end
        for _, callback in ipairs(PostFamiliarTearUpdateHandler.RegisteredCallbacks) do
            if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
                callback:Function(familiar, tear)
            end
        end
    end
end

return PostFamiliarTearUpdateHandler