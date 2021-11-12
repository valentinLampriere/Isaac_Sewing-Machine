local Enums = require("sewn_scripts.core.enums")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local PostFamiliarFireTearHandler = { }
PostFamiliarFireTearHandler.DefaultArguments = { -1, Enums.FamiliarLevelFlag.FLAG_SUPER | Enums.FamiliarLevelFlag.FLAG_ULTRA }


PostFamiliarFireTearHandler.ID = Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR

local function OnTearInit(_, tear)
    local familiar = tear.Parent
    
    -- If tear hasn't been fired from a familiar
    if familiar == nil or familiar:ToFamiliar() == nil then
        return
    end
    
    familiar = familiar:ToFamiliar()

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