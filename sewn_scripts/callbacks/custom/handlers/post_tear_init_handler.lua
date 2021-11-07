local PostTearInitHandler = { }

local Enums = require("sewn_scripts.core.enums")

PostTearInitHandler.ID = Enums.ModCallbacks.POST_TEAR_INIT

function PostTearInitHandler:PostTearUpdate(tear)
    local tData = tear:GetData()
    if tData.Sewn_init == true then
        return
    end

    for _, callback in ipairs(PostTearInitHandler.RegisteredCallbacks) do
        callback:Function(tear)
    end
    tData.Sewn_init = true
end

return PostTearInitHandler