if REPENTANCE == nil then
    return
end

local Random = require("sewn_scripts.helpers.random")

local LittleSteven = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.LITTLE_STEVEN, CollectibleType.COLLECTIBLE_LITTLE_STEVEN)

local littleStevenBulletPatterns = {
    { AmountOfBullet = 8, Offset = 2.5, Damage = 5, Scale = 2 }, -- Steven
    { Velocity = 7, AmountOfBullet = 8 } -- Baby Steven
}

LittleSteven.Stats = {
    FireBulletHitChance = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 5,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 10
    },
    FireBulletKillChance = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 50,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 75
    },
    ShotSpeedBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0.9,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 0.9
    },
    DamageBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1.25,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.5
    },
    TearScale = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1.04,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.08
    },
    RangeBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 2,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 2.5
    },
    ChainReactionChance = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 15
    }
}

local function LittleSteven_fireBullets(littleSteven, enemy, pattern)
    local fData = littleSteven:GetData()
    pattern = pattern or littleStevenBulletPatterns[littleSteven:GetDropRNG():RandomInt(#littleStevenBulletPatterns) + 1]
    for i = 1, pattern.AmountOfBullet or 8 do
        local offset = pattern.Offset or 1.5
        local velocity = Vector(pattern.Velocity or 5, pattern.Velocity or 5)
        velocity = velocity:Rotated((360 / pattern.AmountOfBullet) * i)
        local position = enemy.Position + velocity * (enemy.Size * 0.15) * offset
        local bullet = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_FCUK, 0, position, velocity, littleSteven):ToProjectile()
        bullet:AddProjectileFlags(ProjectileFlags.HIT_ENEMIES | ProjectileFlags.CANT_HIT_PLAYER)
        bullet.Damage = pattern.Damage or 3.5
        bullet.Scale = bullet.Scale * (pattern.Scale or 1)
        bullet.FallingAccel = -0.08

        if Sewn_API:IsUltra(fData) and Random:CheckRoll(LittleSteven.Stats.ChainReactionChance[Sewn_API:GetLevel(fData)]) then
            bullet.Parent = littleSteven
        end
    end
end

function LittleSteven:OnFamiliarFireTear(familiar, tear)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    tear.CollisionDamage = tear.CollisionDamage * LittleSteven.Stats.DamageBonus[level]
    tear.Scale = tear.Scale * LittleSteven.Stats.TearScale[level]
    tear.FallingAcceleration = tear.FallingAcceleration + 0.02 + -0.02 * LittleSteven.Stats.RangeBonus[level]
    tear.Velocity = tear.Velocity * LittleSteven.Stats.ShotSpeedBonus[level]
end

function LittleSteven:OnFamiliarHitNpc(familiar, npc, amount, flags)
    local fData = familiar:GetData()
    if Random:CheckRoll(LittleSteven.Stats.FireBulletHitChance[Sewn_API:GetLevel(fData)], familiar:GetDropRNG()) then
        LittleSteven_fireBullets(familiar, npc, littleStevenBulletPatterns[2])
    end
end
function LittleSteven:OnFamiliarKillNpc(familiar, npc)
    local fData = familiar:GetData()
    if Random:CheckRoll(LittleSteven.Stats.FireBulletKillChance[Sewn_API:GetLevel(fData)], familiar:GetDropRNG()) then
        LittleSteven_fireBullets(familiar, npc, littleStevenBulletPatterns[1])
    end
end

function LittleSteven:OnUltraKingBabyShootTear(familiar, kingBaby, tear, npc)
    tear.TearFlags = tear.TearFlags | TearFlags.TEAR_HOMING
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, LittleSteven.OnFamiliarFireTear, FamiliarVariant.LITTLE_STEVEN)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_HIT_NPC, LittleSteven.OnFamiliarHitNpc, FamiliarVariant.LITTLE_STEVEN)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_KILL_NPC, LittleSteven.OnFamiliarKillNpc, FamiliarVariant.LITTLE_STEVEN)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_ULTRA_KING_BABY_SHOOT_TEAR, LittleSteven.OnUltraKingBabyShootTear, FamiliarVariant.LITTLE_STEVEN)