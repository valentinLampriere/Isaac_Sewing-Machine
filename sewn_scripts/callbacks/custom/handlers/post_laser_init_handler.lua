local PostLaserInitHandler = { }

local Enums = require("sewn_scripts/core/enums")

PostLaserInitHandler.ID = Enums.ModCallbacks.POST_LASER_INIT

function PostLaserInitHandler:PostLaserUpdate(laser)
    local lData = laser:GetData()
    if lData.Sewn_init == true then
        return
    end
    for _, callback in ipairs(PostLaserInitHandler.RegisteredCallbacks) do
        callback:Function(laser)
    end
    lData.Sewn_init = true
end

return PostLaserInitHandler