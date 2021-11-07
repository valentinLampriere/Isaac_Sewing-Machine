local Enums = require("sewn_scripts.core.enums")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local PostFamiliarFireTearHandler = { }
PostFamiliarFireTearHandler.DefaultArguments = { -1, Enums.FamiliarLevelFlag.SUPER | Enums.FamiliarLevelFlag.ULTRA }


PostFamiliarFireTearHandler.ID = Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR

local function OnTearInit(_, tear)
    local familiar = tear.Parent
    local fData
    
    -- If tear hasn't been fired from a familiar
    if tear.SpawnerType ~= EntityType.ENTITY_FAMILIAR or familiar == nil then
        return
    end
    
    familiar = familiar:ToFamiliar()
    fData = familiar:GetData()

    for _, callback in ipairs(PostFamiliarFireTearHandler.RegisteredCallbacks) do
        if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
            callback:Function(familiar, tear)
        end
    end
end
function PostFamiliarFireTearHandler:Init()
    CustomCallbacks:AddCallback(Enums.ModCallbacks.POST_TEAR_INIT, OnTearInit)
end

return PostFamiliarFireTearHandler