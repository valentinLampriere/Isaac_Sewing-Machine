local EntityCollidersCooldown = require("sewn_scripts.helpers.entity_colliders_cooldown")
local Random = require("sewn_scripts.helpers.random")
local SpawnBones = require("sewn_scripts.helpers.spawn_bones")

local PointyRib = { }

PointyRib.Stats = {
    ChanceBleedEffect = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 50,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 80
    },
    BoneMax = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 5,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 5
    },
    BoneMin = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 2,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 3
    },
    BoneChance = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 33,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 66
    },
    DamageBonusMultiplier = 1.5,
    DamageBonusFlat = 2,
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.POINTY_RIB, CollectibleType.COLLECTIBLE_POINTY_RIB)

-- Sewn_API:AddEncyclopediaUpgrade(
--     FamiliarVariant.POINTY_RIB,
--     "Has 50% chance to apply bleed effect to non-boss enemies#Has 33% chance to spawn 1 to 5 bones when it kills an enemy",
--     "Increase chances to apply bleed effect to 80%#Increase chances to spawn bones to 6%. Can spawn 2 to 5 bones#Deal more collision damage equals to normal damage x 1.5 + 2"
-- )

function PointyRib:OnFamiliarCollision(familiar, collider)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    
    if collider:IsVulnerableEnemy() and not collider:IsBoss() then
        if not EntityCollidersCooldown:IsInCooldown(familiar, collider, "pointyRibCooldown") then
            if Random:CheckRoll(PointyRib.Stats.ChanceBleedEffect[level], familiar:GetDropRNG()) then
                collider:AddEntityFlags(EntityFlag.FLAG_BLEED_OUT)
            end
            EntityCollidersCooldown:Add(familiar, collider, 30)
        end
    end
end

function PointyRib:OnKill(familiar, npc)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    
    if Random:CheckRoll(PointyRib.Stats.BoneChance[level], familiar:GetDropRNG()) then
        SpawnBones(familiar, npc.Position, PointyRib.Stats.BoneMin[level], PointyRib.Stats.BoneMax[level], 5)
    end
end
function PointyRib:OnHit(familiar, npc, amount, flags, source, countdown)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    
    
    npc:TakeDamage(amount * PointyRib.Stats.DamageBonusMultiplier + PointyRib.Stats.DamageBonusFlat, DamageFlag.DAMAGE_CLONES, EntityRef(familiar), countdown)

    return false
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.PRE_FAMILIAR_COLLISION, PointyRib.OnFamiliarCollision, FamiliarVariant.POINTY_RIB)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_KILL_NPC, PointyRib.OnKill, FamiliarVariant.POINTY_RIB)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_HIT_NPC, PointyRib.OnHit, FamiliarVariant.POINTY_RIB, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)