local Enums = require("sewn_scripts.core.enums")
local Delay = require("sewn_scripts.helpers.delay")

local RoboBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.ROBO_BABY, CollectibleType.COLLECTIBLE_ROBO_BABY)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.ROBO_BABY,
    "{{ArrowUp}} Tears Up",
    "{{ArrowUp}} Tears Up", nil, "Robo Baby"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.ROBO_BABY,
    "{{ArrowUp}} 射速提升",
    "{{ArrowUp}} 射速提升", nil, "机器宝宝","zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.ROBO_BABY,
    "{{ArrowUp}} Скорострельность +",
    "{{ArrowUp}} Скорострельность +", nil, "Робо-Малыш", "ru"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.ROBO_BABY,
    "{{ArrowUp}} Débit",
    "{{ArrowUp}} Débit", nil, "Robo-Bébé", "fr"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.ROBO_BABY,
    "Tears Up (x1.29)",
    "Tears Up (x1.52)"
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