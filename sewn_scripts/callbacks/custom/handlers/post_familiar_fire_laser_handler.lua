local Enums = require("sewn_scripts.core.enums")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local PostFamiliarFireLaserHandler = { }
PostFamiliarFireLaserHandler.DefaultArguments = { -1, Enums.FamiliarLevelFlag.FLAG_SUPER | Enums.FamiliarLevelFlag.FLAG_ULTRA }


PostFamiliarFireLaserHandler.ID = Enums.ModCallbacks.POST_FAMILIAR_FIRE_LASER

local function OnLaserInit(_, laser)
    local familiar = laser.Parent

    if laser.Parent ~= nil or laser.SpawnerEntity ~= nil and laser.SpawnerEntity.Type == EntityType.ENTITY_FAMILIAR then
        familiar = familiar or laser.SpawnerEntity
        familiar = familiar:ToFamiliar()
        if familiar == nil then
            return
        end
        for _, callback in ipairs(PostFamiliarFireLaserHandler.RegisteredCallbacks) do
            if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
                callback:Function(familiar, laser)
            end
        end
    end
end

function PostFamiliarFireLaserHandler:Init()
    CustomCallbacks:AddCallback(Enums.ModCallbacks.POST_LASER_INIT, OnLaserInit)
end

return PostFamiliarFireLaserHandler