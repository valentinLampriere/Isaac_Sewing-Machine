local Enums = require("sewn_scripts.core.enums")

local OnFamiliarLoseUpgradeHandler = { }
OnFamiliarLoseUpgradeHandler.DefaultArguments = { -1 }

OnFamiliarLoseUpgradeHandler.ID = Enums.ModCallbacks.ON_FAMILIAR_LOSE_UPGRADE

function OnFamiliarLoseUpgradeHandler:Evaluate(familiar, losePermanentUpgrade)
    for _, callback in ipairs(OnFamiliarLoseUpgradeHandler.RegisteredCallbacks) do
        if callback.Argument[1] == -1 or familiar.Variant == callback.Argument[1] then
            callback:Function(familiar, losePermanentUpgrade)
        end
    end
end

return OnFamiliarLoseUpgradeHandler