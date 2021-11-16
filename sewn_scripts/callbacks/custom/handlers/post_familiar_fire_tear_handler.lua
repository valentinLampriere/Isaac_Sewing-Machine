local Enums = require("sewn_scripts.core.enums")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local PostFamiliarFireTearHandler = { }
PostFamiliarFireTearHandler.DefaultArguments = { -1, Enums.FamiliarLevelFlag.FLAG_SUPER | Enums.FamiliarLevelFlag.FLAG_ULTRA }


PostFamiliarFireTearHandler.ID = Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR

local function OnTearInit(_, tear)
    local familiar = tear.Parent
    
    if tear.Parent ~= nil or tear.SpawnerEntity ~= nil and tear.SpawnerEntity.Type == EntityType.ENTITY_FAMILIAR then
        familiar = familiar or tear.SpawnerEntity
        familiar = familiar:ToFamiliar()
        if familiar == nil then
            return
        end
        for _, callback in ipairs(PostFamiliarFireTearHandler.RegisteredCallbacks) do
            if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
                callback:Function(familiar, tear)
            end
        end
    end
end
function PostFamiliarFireTearHandler:Init()
    CustomCallbacks:AddCallback(Enums.ModCallbacks.POST_TEAR_INIT, OnTearInit)
end

return PostFamiliarFireTearHandler