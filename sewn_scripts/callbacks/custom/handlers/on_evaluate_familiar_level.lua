local Enums = require("sewn_scripts.core.enums")

local OnEvaluateFamiliarLevelHandler = { }
OnEvaluateFamiliarLevelHandler.ID = Enums.ModCallbacks.ON_EVALUATE_FAMILIAR_LEVEL

function OnEvaluateFamiliarLevelHandler:Evaluate(familiar)
    for _, callback in ipairs(OnEvaluateFamiliarLevelHandler.RegisteredCallbacks) do
        callback:Function(familiar)
    end
end

return OnEvaluateFamiliarLevelHandler