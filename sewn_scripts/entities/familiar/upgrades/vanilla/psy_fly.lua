local CColor = require("sewn_scripts.helpers.ccolor")
local FindCloserNpc = require("sewn_scripts.helpers.find_closer_npc")

local PsyFly = { }

PsyFly.Stats = {
    DamageMultiplier = 1.5,
    CooldownAdditionalAttack = 5
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.PSY_FLY, CollectibleType.COLLECTIBLE_PSY_FLY)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.PSY_FLY,
    "When it blocks a bullet, fire a homing tear in the opposite direction",
    "{{ArrowUp}} Damage Up (collision and tears)", nil, "Psy Fly"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.PSY_FLY,
    "阻挡弹幕后向弹幕发射的反方向发射一颗跟踪眼泪",
    "{{ArrowUp}} 攻击提升，并具有接触伤害", nil, "灵能苍蝇"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.PSY_FLY,
    nil,
    "Collision damage and tears damage up (x1.5)",
    "The super upgrade is a similar behaviour of the Psy Fly behaviour before it was nerfed in the 1.7.5 update"
)

function PsyFly:OnFamiliarCollide(familiar, collider)
    if collider.Type ~= EntityType.ENTITY_PROJECTILE then
        return
    end

    local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, collider.Position, -collider.Velocity + familiar.Velocity * 0.2, familiar):ToTear()
    tear.Parent = familiar
    tear.TearFlags = TearFlags.TEAR_HOMING
    tear:SetColor(CColor(0.4, 0.15, 0.38, 1, 0.27843, 0, 0.4549), -1, 1, false, false)
end

function PsyFly:OnFamiliarHitNpc(familiar, npc, amount, flags, source, countdown)
    npc:TakeDamage(amount * PsyFly.Stats.DamageMultiplier, DamageFlag.DAMAGE_CLONES, EntityRef(familiar), countdown)
end
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.PRE_FAMILIAR_COLLISION, PsyFly.OnFamiliarCollide, FamiliarVariant.PSY_FLY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_HIT_NPC, PsyFly.OnFamiliarHitNpc, FamiliarVariant.PSY_FLY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)