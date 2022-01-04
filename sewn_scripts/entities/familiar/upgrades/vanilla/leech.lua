local Delay = require("sewn_scripts.helpers.delay")
local Globals = require("sewn_scripts.core.globals")
local BurstTears = require("sewn_scripts.helpers.burst_tears")

local Leech = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.LEECH, CollectibleType.COLLECTIBLE_LEECH)


Leech.Stats = {
    CreepSpawnRate = 10,
    CreepDamage = 1,
    AdditionalDamageMultiplier = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0.5,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 0.8
    },
    BurstTearDamage = 3.5,
    BurstTearForce = 8,
}

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.LEECH,
    "Spawns creep when it collide with an enemy#{{ArrowUp}} Damage Up",
    "Enemies it kills explode into lots of tears#{{ArrowUp}} Damage Up", nil, "Leech"
)

function Leech:familiarCollider(familiar, collider)
    if familiar.FrameCount % Leech.Stats.CreepSpawnRate == 0 and collider:IsVulnerableEnemy() then
        local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, familiar.Position, Globals.V0, familiar)
        creep.CollisionDamage = Leech.Stats.CreepDamage
        creep.Parent = familiar
    end
end
function Leech:familiarHitNpc(familiar, npc, amount, flags, source, countdown)
    if GetPtrHash(source.Entity) == GetPtrHash(familiar) then
        local fData = familiar:GetData()
        local damage = amount * Leech.Stats.AdditionalDamageMultiplier[Sewn_API:GetLevel(fData)]
        npc:TakeDamage(damage, DamageFlag.DAMAGE_CLONES, EntityRef(familiar), countdown)
    end
end

function Leech:familiarKillNpc(familiar, npc)
    local enemyHP = math.floor(npc.MaxHitPoints / 2)
    local nbTears = familiar:GetDropRNG():RandomInt(math.min(enemyHP, 15)) + 3

    Delay:DelayFunction(function ()
        BurstTears(familiar, nbTears, Leech.Stats.BurstTearDamage, Leech.Stats.BurstTearForce, true, TearVariant.BLOOD, nil, npc.Position)
    end, 2)
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.PRE_FAMILIAR_COLLISION, Leech.familiarCollider, FamiliarVariant.LEECH)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_HIT_NPC, Leech.familiarHitNpc, FamiliarVariant.LEECH)

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_KILL_NPC, Leech.familiarKillNpc, FamiliarVariant.LEECH, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)