local Familiar = require("sewn_scripts.entities.familiar.familiar")

local function MC_FAMILIAR_UPDATE(_, familiar)
    Familiar:TryInitFamiliar(familiar)
    Familiar:Update(familiar)
    Familiar:CheckForDelirium(familiar)
end

return MC_FAMILIAR_UPDATE
