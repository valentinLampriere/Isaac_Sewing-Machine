local ShootTearsCircular = require("sewn_scripts.helpers.shoot_tears_circular")
local Delay = require("sewn_scripts.helpers.delay")
local Globals = require("sewn_scripts.core.globals")

local LilGurdy = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.LIL_GURDY, CollectibleType.COLLECTIBLE_LIL_GURDY)


LilGurdy.Stats = {
    ChargingTearCooldownMin = 20,
    ChargingTearCooldownMax = 80,
    ChargingTearDamagePerChargeFrame = 0.2,
    ChargingTearDamageMax = 10,
    ChargingTearAmountMin = 5,
    ChargingTearAmountMax = 8,
    FireRateBonusFramePerSecond = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 4,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 3
    },
    DashStopFirstWaveDelay = 0,
    DashStopSecondWaveDelay = 15,
    DashStopThirdWaveDelay = 25,
    CreepCollisionDamage = 1,
}
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.LIL_GURDY,
    "{{ArrowUp}} Can be charged quicker#While charging, fires tear in different directions",
    "{{ArrowUp}} Can be charged quicker#When it dashes, it leaves red creep#Fire 3 waves of tears in different directions after dashing", nil, "Lil Gurdy"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.LIL_GURDY,
    "{{ArrowUp}} 充能更快 #在充能时可向四周方向发射环状眼泪",
    "{{ArrowUp}} 充能更快 #在冲撞时在地上留下血迹造成伤害，在冲撞结束后发射 3 次环状眼泪", nil, "小肉山","zh_cn"
)

local function ShootTears(familiar)
    local amountTears = familiar:GetDropRNG():RandomInt( LilGurdy.Stats.ChargingTearAmountMax - LilGurdy.Stats.ChargingTearAmountMin ) + LilGurdy.Stats.ChargingTearAmountMin
    local damage = math.sqrt(familiar.FireCooldown * LilGurdy.Stats.ChargingTearDamagePerChargeFrame)
    if damage > LilGurdy.Stats.ChargingTearDamageMax then
        damage = LilGurdy.Stats.ChargingTearDamageMax
    end
    ShootTearsCircular(familiar, amountTears, TearVariant.BLOOD, nil, nil, damage)
end

function LilGurdy:OnUpgraded(familiar, isPermanentUpgrade)
    local fData = familiar:GetData()
    fData.Sewn_lilGurdy_chargingTearCooldown = LilGurdy.Stats.ChargingTearAmountMin
    fData.Sewn_lilGurdy_lastFireCooldown = 0
end
function LilGurdy:Charging(familiar, sprite)
    local fData = familiar:GetData()

    if familiar.FrameCount % LilGurdy.Stats.FireRateBonusFramePerSecond[Sewn_API:GetLevel(fData)] == 0 then
        familiar.FireCooldown = familiar.FireCooldown + 1
    end

    if fData.Sewn_lilGurdy_chargingTearCooldown == 0 then
        ShootTears(familiar)
        fData.Sewn_lilGurdy_chargingTearCooldown = familiar:GetDropRNG():RandomInt( LilGurdy.Stats.ChargingTearCooldownMax - LilGurdy.Stats.ChargingTearCooldownMin ) + LilGurdy.Stats.ChargingTearCooldownMin
    elseif fData.Sewn_lilGurdy_chargingTearCooldown > 0 then
        fData.Sewn_lilGurdy_chargingTearCooldown = fData.Sewn_lilGurdy_chargingTearCooldown - 1
    end
end
function LilGurdy:Dashing(familiar, sprite)
    if familiar.FrameCount % 6 - math.floor(math.sqrt(familiar.Velocity:Length())) == 0 then
        local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, familiar.Position, Globals.V0, familiar)
        creep.CollisionDamage = LilGurdy.Stats.CreepCollisionDamage
    end
end
function LilGurdy:DashStop(familiar, sprite)
    if sprite:GetFrame() == 4 then
        Delay:DelayFunction(ShootTears, LilGurdy.Stats.DashStopFirstWaveDelay, false, familiar)
        Delay:DelayFunction(ShootTears, LilGurdy.Stats.DashStopSecondWaveDelay, false, familiar)
        Delay:DelayFunction(ShootTears, LilGurdy.Stats.DashStopThirdWaveDelay, false, familiar)
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, LilGurdy.OnUpgraded, FamiliarVariant.LIL_GURDY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_PLAY_ANIM, LilGurdy.Charging, FamiliarVariant.LIL_GURDY, nil, "Charging")
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_PLAY_ANIM, LilGurdy.Dashing, FamiliarVariant.LIL_GURDY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA, "Dashing")
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_PLAY_ANIM, LilGurdy.DashStop, FamiliarVariant.LIL_GURDY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA, "DashStop")