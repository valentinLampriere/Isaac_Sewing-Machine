local Enums = require("sewn_scripts.core.enums")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local PreFamiliarCollisionHandler = { }
PreFamiliarCollisionHandler.DefaultArguments = { -1, Enums.FamiliarLevelFlag.FLAG_SUPER | Enums.FamiliarLevelFlag.FLAG_ULTRA }

PreFamiliarCollisionHandler.ID = Enums.ModCallbacks.PRE_FAMILIAR_COLLISION

function PreFamiliarCollisionHandler:PreFamiliarCollision(familiar, collider, low)
    local fData = familiar:GetData()
    if fData.Sewn_Init == nil then return end
    for _, callback in ipairs(PreFamiliarCollisionHandler.RegisteredCallbacks) do
        if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
            callback:Function(familiar, collider)
        end
    end
end

return PreFamiliarCollisionHandler