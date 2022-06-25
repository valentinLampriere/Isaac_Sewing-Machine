local Random = require("sewn_scripts.helpers.random")
local Delay = require("sewn_scripts.helpers.delay")
local Globals = require("sewn_scripts.core.globals")
local CColor = require("sewn_scripts.helpers.ccolor")
local ShootTearsCircular = require("sewn_scripts.helpers.shoot_tears_circular")

local DaddyLonglegs = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.DADDY_LONGLEGS, CollectibleType.COLLECTIBLE_DADDY_LONGLEGS)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.DADDY_LONGLEGS,
    "Has a chance to stomp with the head, dealing 2x the normal damage#Has a chance to stomp as Triachnid. When it does, fires 5 slowing tears in all directions",
    "{{ArrowUp}} Higher chance to stomp as Triachnid and to stomp with the head#Each time it falls, has a chance to stomps an additional time", nil, "Daddy Longlegs"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.DADDY_LONGLEGS,
    "有概率掉落的是蜘蛛的头，造成原先伤害的 2 倍；头和脚有概率替换成Boss-Triachnid的样子，如果替换则向周围发射 5 颗减速眼泪",
    "提升Boss-Triachnid出现的概率，下落一次后有概率再触发一次下落，额外触发的一次下落也可继续触发", nil, "长腿蛛父","zh_cn"
)

DaddyLonglegs.Stats = {
    ChanceTriachnidStomp = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 25,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 50
    },
    ChanceHeadStomp = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 15,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 25
    },
    AdditionalStompChance = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 15
    }
}


local function PreStomp(familiar, sprite, animType)
    if sprite:GetFrame() ~= 1 then return end
    
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    local animPrefix = "Stomp"
    local animSuffix = animType

    fData.Sewn_daddyLonglegs_isHead = nil
    fData.Sewn_daddyLonglegs_isTriachnid = nil

    if Random:CheckRoll(DaddyLonglegs.Stats.ChanceHeadStomp[level], familiar:GetDropRNG()) then
        fData.Sewn_daddyLonglegs_isHead = true
        animPrefix = "HeadStomp"
        animSuffix = ""
    end
    
    if Random:CheckRoll(DaddyLonglegs.Stats.ChanceTriachnidStomp[level], familiar:GetDropRNG()) then
        fData.Sewn_daddyLonglegs_isTriachnid = true
        animSuffix = "Triachnid"

        Delay:DelayFunction(function ()
            local tears = ShootTearsCircular(familiar, 5, TearVariant.BLUE, nil, nil, 3.5, TearFlags.TEAR_SLOW)
            for _, tear in ipairs(tears) do
                tear:SetColor(CColor(1,1,1,1,0.5,0.5,0.5), -1, 1, false, false)
            end
            Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_WHITE, 0, familiar.Position, Globals.V0, familiar)
        end, 11)
    end
    if Random:CheckRoll(DaddyLonglegs.Stats.AdditionalStompChance[level], familiar:GetDropRNG()) then
        sprite.PlaybackSpeed = 2
        Delay:DelayFunction(function ()
            if familiar:GetDropRNG():RandomInt(2) == 1 then
                sprite:Play("StompArm", true)
            else
                sprite:Play("StompLeg", true)
            end
            fData.Sewn_daddyLonglegs_attackPosition = nil
            sprite.PlaybackSpeed = 1
        end, 17)
        fData.Sewn_daddyLonglegs_attackPosition = familiar.Position
    end

    if animPrefix .. animSuffix == "Stomp" .. animType then
        return
    end

    sprite:Play(animPrefix .. animSuffix, true)
    --sprite:SetFrame(2)
end

function DaddyLonglegs:OnFamiliarUpgraded(familiar, isPermanentUpgrade)
    Sewn_API:AddCrownOffset(familiar, Vector(0, -55))
end
function DaddyLonglegs:HitNpc(familiar, npc, amount, flags, source, countdown)
    local fData = familiar:GetData()
    if fData.Sewn_daddyLonglegs_isHead then
        npc:TakeDamage(familiar.CollisionDamage, DamageFlag.DAMAGE_CLONES, EntityRef(familiar), countdown)
    end
end
function DaddyLonglegs:StompArm(familiar, sprite)
    PreStomp(familiar, sprite, "Arm")
end
function DaddyLonglegs:StompLeg(familiar, sprite)
    PreStomp(familiar, sprite, "Leg")
end
function DaddyLonglegs:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()

    if fData.Sewn_daddyLonglegs_attackPosition ~= nil then
        familiar.Position = fData.Sewn_daddyLonglegs_attackPosition
        familiar.Velocity = Globals.V0
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, DaddyLonglegs.OnFamiliarUpgraded, FamiliarVariant.DADDY_LONGLEGS)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_PLAY_ANIM, DaddyLonglegs.StompArm, FamiliarVariant.DADDY_LONGLEGS, nil, "StompArm")
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_PLAY_ANIM, DaddyLonglegs.StompLeg, FamiliarVariant.DADDY_LONGLEGS, nil, "StompLeg")
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_HIT_NPC, DaddyLonglegs.HitNpc, FamiliarVariant.DADDY_LONGLEGS)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, DaddyLonglegs.OnFamiliarUpdate, FamiliarVariant.DADDY_LONGLEGS, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)