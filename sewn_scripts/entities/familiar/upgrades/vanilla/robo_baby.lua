local Enums = require("sewn_scripts.core.enums")
local Delay = require("sewn_scripts.helpers.delay")

local RoboBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.ROBO_BABY, CollectibleType.COLLECTIBLE_ROBO_BABY)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.ROBO_BABY,
    "{{ArrowUp}} Tears Up",
    "{{ArrowUp}} Tears Up"
)

local stats = {
    [Enums.FamiliarLevel.SUPER] = 6,
    [Enums.FamiliarLevel.ULTRA] = 11,
}
local stats_ab = {
    [Enums.FamiliarLevel.SUPER] = 8,
    [Enums.FamiliarLevel.ULTRA] = 15,
}
function RoboBaby:OnFamiliarFireLaser(familiar, laser)
    local fData = familiar:GetData()
    if REPENTANCE then
        familiar.FireCooldown = familiar.FireCooldown - stats[Sewn_API:GetLevel(fData)]
    else
        Delay:DelayFunction(function ()
            familiar.FireCooldown = familiar.FireCooldown - stats_ab[Sewn_API:GetLevel(fData)]
        end)
    end
end
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_LASER, RoboBaby.OnFamiliarFireLaser, FamiliarVariant.ROBO_BABY)