local Enums = require("sewn_scripts.core.enums")
local Globals = require("sewn_scripts.core.globals")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")

local PostFamiliarFireLaserHandler = { }
PostFamiliarFireLaserHandler.DefaultArguments = { -1, Enums.FamiliarLevelFlag.SUPER | Enums.FamiliarLevelFlag.ULTRA }


PostFamiliarFireLaserHandler.ID = Enums.ModCallbacks.POST_FAMILIAR_FIRE_LASER

local function OnLaserInit(_, laser)    
    local familiar = laser.Parent
    local fData

    -- If laser hasn't been fired from a familiar
    if laser.SpawnerType ~= EntityType.ENTITY_FAMILIAR or familiar == nil then
        return
    end
    
    familiar = familiar:ToFamiliar()
    fData = familiar:GetData()

    for _, callback in ipairs(PostFamiliarFireLaserHandler.RegisteredCallbacks) do
        if callback.Argument[1] == -1 or callback.Argument[1] == familiar.Variant then
            if  callback.Argument[2] & Enums.FamiliarLevelFlag.NORMAL == Enums.FamiliarLevelFlag.NORMAL and not Sewn_API:IsSuper(fData, false) and not Sewn_API:IsUltra(fData) or
                callback.Argument[2] & Enums.FamiliarLevelFlag.SUPER == Enums.FamiliarLevelFlag.SUPER and Sewn_API:IsSuper(fData, false) or
                callback.Argument[2] & Enums.FamiliarLevelFlag.ULTRA == Enums.FamiliarLevelFlag.ULTRA and Sewn_API:IsUltra(fData) then
                callback:Function(familiar, laser)
            end
        end
    end
end

function PostFamiliarFireLaserHandler:Init()
    CustomCallbacks:AddCallback(Enums.ModCallbacks.POST_LASER_INIT, OnLaserInit)
end

return PostFamiliarFireLaserHandler