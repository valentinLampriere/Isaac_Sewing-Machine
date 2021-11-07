local Enums = require("sewn_scripts/core/enums")

local RoboBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.ROBO_BABY, CollectibleType.COLLECTIBLE_ROBO_BABY)

local stats = {
    [Enums.FamiliarLevel.SUPER] = 7,
    [Enums.FamiliarLevel.ULTRA] = 14,
}
local stats_ab = {
    [Enums.FamiliarLevel.SUPER] = 10,
    [Enums.FamiliarLevel.ULTRA] = 20,
}
function RoboBaby:OnFamiliarFireLaser(familiar, laser)
    local fData = familiar:GetData()
    if REPENTANCE then
        familiar.FireCooldown = familiar.FireCooldown - stats[Sewn_API:GetLevel(fData)]
    else
        familiar.FireCooldown = familiar.FireCooldown - stats_ab[Sewn_API:GetLevel(fData)]
    end
end
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_LASER, RoboBaby.OnFamiliarFireLaser, FamiliarVariant.ROBO_BABY)