local Enums = require("sewn_scripts.core.enums")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local OnFamiliarUpgradedHandler = { }
OnFamiliarUpgradedHandler.DefaultArguments = { -1, Enums.FamiliarLevelFlag.FLAG_SUPER | Enums.FamiliarLevelFlag.FLAG_ULTRA }

OnFamiliarUpgradedHandler.ID = Enums.ModCallbacks.ON_FAMILIAR_UPGRADED

function OnFamiliarUpgradedHandler:Evaluate(familiar, isPermanentUpgrade)
    for _, callback in ipairs(OnFamiliarUpgradedHandler.RegisteredCallbacks) do
        if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
            callback:Function(familiar, isPermanentUpgrade)
        end
    end
end

return OnFamiliarUpgradedHandler