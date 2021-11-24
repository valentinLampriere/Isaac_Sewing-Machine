local Familiar = require("sewn_scripts.entities.familiar.familiar")
local CustomCallbacksHandler = require("sewn_scripts.callbacks.custom_callbacks_handler")

local function MC_FAMILIAR_UPDATE(_, familiar)
    Familiar:TryInitFamiliar(familiar)
    Familiar:Update(familiar)
    Familiar:CheckForDelirium(familiar)
    Familiar:SetTransparencyForUnavailableFamiliar(familiar)
    CustomCallbacksHandler:FamiliarUpdate(familiar)
end

return MC_FAMILIAR_UPDATE
