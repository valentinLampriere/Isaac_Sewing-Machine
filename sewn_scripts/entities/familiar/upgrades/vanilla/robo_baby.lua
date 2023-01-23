local Random = require("sewn_scripts.helpers.random")
local Enums = require("sewn_scripts.core.enums")
local Delay = require("sewn_scripts.helpers.delay")

local RoboBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.ROBO_BABY, CollectibleType.COLLECTIBLE_ROBO_BABY)

RoboBaby.Stats = {
    FireCooldownBonus = {
        [Enums.FamiliarLevel.SUPER] = 6,
        [Enums.FamiliarLevel.ULTRA] = 11
    },
    FireCooldownBonus_AB = {
        [Enums.FamiliarLevel.SUPER] = 8,
        [Enums.FamiliarLevel.ULTRA] = 15
    },
    kingBabyTearLaserChance = 60
}

function RoboBaby:OnFamiliarFireLaser(familiar, laser)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    if REPENTANCE then
        familiar.FireCooldown = familiar.FireCooldown - RoboBaby.Stats.FireCooldownBonus[level]
    else
        Delay:DelayFunction(function ()
            familiar.FireCooldown = familiar.FireCooldown - RoboBaby.Stats.FireCooldownBonus_AB[level]
        end)
    end
end

function RoboBaby:OnUltraKingBabyShootTear(familiar, kingBaby, tear)
    if Random:CheckRoll(RoboBaby.Stats.kingBabyTearLaserChance, kingBaby:GetDropRNG()) then
        tear.TearFlags = tear.TearFlags | TearFlags.TEAR_LASER
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_LASER, RoboBaby.OnFamiliarFireLaser, FamiliarVariant.ROBO_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_ULTRA_KING_BABY_SHOOT_TEAR, RoboBaby.OnUltraKingBabyShootTear, FamiliarVariant.ROBO_BABY)