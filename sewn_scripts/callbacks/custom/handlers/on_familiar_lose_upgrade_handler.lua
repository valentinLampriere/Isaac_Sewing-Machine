local Enums = require("sewn_scripts.core.enums")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local OnFamiliarLoseUpgradeHandler = { }
OnFamiliarLoseUpgradeHandler.DefaultArguments = { -1, Enums.FamiliarLevelFlag.FLAG_SUPER | Enums.FamiliarLevelFlag.FLAG_ULTRA }

OnFamiliarLoseUpgradeHandler.ID = Enums.ModCallbacks.ON_FAMILIAR_LOSE_UPGRADE

function OnFamiliarLoseUpgradeHandler:Evaluate(familiar, losePermanentUpgrade)
    for _, callback in ipairs(OnFamiliarLoseUpgradeHandler.RegisteredCallbacks) do
        if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
            callback:Function(familiar, losePermanentUpgrade)
        end
    end
end

return OnFamiliarLoseUpgradeHandler