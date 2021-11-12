local Enums = require("sewn_scripts.core.enums")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local FamiliarUpdateHandler = { }
FamiliarUpdateHandler.DefaultArguments = { -1, Enums.FamiliarLevelFlag.FLAG_SUPER | Enums.FamiliarLevelFlag.FLAG_ULTRA }

FamiliarUpdateHandler.ID = Enums.ModCallbacks.FAMILIAR_UPDATE

function FamiliarUpdateHandler:FamiliarUpdate(familiar)
    local fData = familiar:GetData()
    if fData.Sewn_Init == nil then return end
    for _, callback in ipairs(FamiliarUpdateHandler.RegisteredCallbacks) do
        if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
            callback:Function(familiar)
        end
    end
end

return FamiliarUpdateHandler