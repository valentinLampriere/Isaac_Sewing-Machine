local CColor = require("sewn_scripts.helpers.ccolor")

local BabyBender = { }

function BabyBender:FamiliarFireTear(familiar, tear)
    if not familiar.Player:HasTrinket(TrinketType.TRINKET_BABY_BENDER) then return end
    tear:AddTearFlags(TearFlags.TEAR_HOMING)
    local color = tear:GetColor()
    tear:SetColor(CColor(0.4, 0.15, 0.38, 1, 0.27843, 0, 0.4549), -1, 1, false, false)
end
function BabyBender:FamiliarFireLaser(familiar, laser)
    if not familiar.Player:HasTrinket(TrinketType.TRINKET_BABY_BENDER) then return end
    laser:AddTearFlags(TearFlags.TEAR_HOMING)
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, BabyBender.FamiliarFireTear)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_LASER, BabyBender.FamiliarFireLaser)

return BabyBender