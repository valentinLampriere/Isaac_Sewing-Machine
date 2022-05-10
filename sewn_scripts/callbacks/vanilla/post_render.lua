local Debug = require("sewn_scripts.debug.debug")

local function MC_POST_RENDER(_)
    Debug:OnRender()
end

return MC_POST_RENDER
