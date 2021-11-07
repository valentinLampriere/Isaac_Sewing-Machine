local Familiar = require("sewn_scripts.entities.familiar.familiar")


local function MC_POST_FAMILIAR_RENDER(_, familiar, offset)
    Familiar:RenderCrown(familiar)
end

return MC_POST_FAMILIAR_RENDER