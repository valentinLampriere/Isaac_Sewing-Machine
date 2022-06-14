local Globals = require("sewn_scripts.core.globals")

local Hushy = { }

Hushy.Stats = {
    AmountCircleTears = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 15,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 15
    },
    CircleTearsDamage = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 3,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 3.5
    },
    AttackCircleCooldown = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 120,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 120
    },
    CollisionDamageBonusMultiplier = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 0.5
    },
    MinisaacCooldown = function(familiar, floorAmountSpawnMinisaac)
        return 30 * (8 + floorAmountSpawnMinisaac ^ 1.5)
    end,
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.HUSHY, CollectibleType.COLLECTIBLE_HUSHY)

if REPENTANCE then
    Sewn_API:AddFamiliarDescription(
        FamiliarVariant.HUSHY,
        "#Fire 15 tears in a random circular pattern every 4 seconds.#Tears deal 3 damage.",
        "#Spawn minisaac after charging for few seconds (only in rooms with enemies).#{{ArrowUp}} Damage Up", nil, "Hushy"
    )

    Sewn_API:AddEncyclopediaUpgrade(
        FamiliarVariant.HUSHY,
        nil, nil,
        "In AB+, there are no minisaac so the ultra upgrade spawn a friendly boil monster instead."
    )
else
    Sewn_API:AddFamiliarDescription(
        FamiliarVariant.HUSHY,
        "#Fire 15 tears in a random circular pattern every 4 seconds.#Tears deal 3 damage.",
        "#Spawn a boil friendly monster every few seconds (only in rooms with enemies).#{{ArrowUp}} Damage Up", nil, "Hushy"
    )

    Sewn_API:AddEncyclopediaUpgrade(
        FamiliarVariant.HUSHY,
        nil, nil,
        "In Repentance the ultra upgrade spawn a tiny Isaac familiar (known as Minisaac) instead of a boil monster."
    )
end

local function HandleAttackCircleTears(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    
    if fData.Sewn_hushy_circleAttackCooldown > 0 then
        fData.Sewn_hushy_circleAttackCooldown = fData.Sewn_hushy_circleAttackCooldown - 1
        return
    end

    local amountTearsMax = Hushy.Stats.AmountCircleTears[level]
    local tearsDamage = Hushy.Stats.CircleTearsDamage[level]
    local attackCooldown = Hushy.Stats.AttackCircleCooldown[level]
    
    if fData.Sewn_hushy_circleAttackFiredTears < amountTearsMax then
        
        local normalizedDirection = Vector(
            math.cos((math.pi * 2 + fData.Sewn_hushy_circleAttackOffset % amountTearsMax) / amountTearsMax * fData.Sewn_hushy_circleAttackFiredTears),
            math.sin((math.pi * 2 + fData.Sewn_hushy_circleAttackOffset % amountTearsMax) / amountTearsMax * fData.Sewn_hushy_circleAttackFiredTears)
        ):Normalized()

        local bullet = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_TEAR, 0, familiar.Position, normalizedDirection * 5, familiar):ToProjectile()
        bullet:AddProjectileFlags(ProjectileFlags.HIT_ENEMIES | ProjectileFlags.NO_WALL_COLLIDE | ProjectileFlags.SINE_VELOCITY | ProjectileFlags.CONTINUUM | ProjectileFlags.CANT_HIT_PLAYER)
        bullet.CollisionDamage = tearsDamage - 5.0
        bullet.FallingAccel = -0.075
        
        fData.Sewn_hushy_circleAttackFiredTears = fData.Sewn_hushy_circleAttackFiredTears + 1
    else
        fData.Sewn_hushy_circleAttackCooldown = attackCooldown
        fData.Sewn_hushy_circleAttackFiredTears = 0
        fData.Sewn_hushy_circleAttackPatternIndex = nil
    end
end

local function SpawnMinisaac(familiar)
    local fData = familiar:GetData()
    
    if REPENTANCE then
        local minisaac = familiar.Player:AddMinisaac(familiar.Position, true)
    else
        local blueBoil = Isaac.Spawn(EntityType.ENTITY_HUSH_BOIL, 0, 0, familiar.Position, Globals.V0, familiar)
        blueBoil:AddEntityFlags(EntityFlag.FLAG_APPEAR | EntityFlag.FLAG_CHARM | EntityFlag.FLAG_NO_TARGET | EntityFlag.FLAG_FRIENDLY)
    end

    fData.Sewn_hushy_floorMinisaacSpawned = fData.Sewn_hushy_floorMinisaacSpawned + 1
end

function Hushy:FamiliarInit(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    fData.Sewn_hushy_circleAttackCooldown = Hushy.Stats.AttackCircleCooldown[level]
    fData.Sewn_hushy_circleAttackFiredTears = 0
    fData.Sewn_hushy_circleAttackOffset = 0
    fData.Sewn_hushy_floorMinisaacSpawned = 0
    fData.Sewn_hushy_minisaacCooldown = Hushy.Stats.MinisaacCooldown(familiar, fData.Sewn_hushy_floorMinisaacSpawned)
end

function Hushy:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    local player = familiar.Player

    if player:GetShootingInput():LengthSquared() > 0 then
        HandleAttackCircleTears(familiar)

        if Sewn_API:IsUltra(fData) then
            if Globals.Room:GetAliveEnemiesCount() > 0 then
                if fData.Sewn_hushy_minisaacCooldown <= 0 then
                    SpawnMinisaac(familiar)
                    fData.Sewn_hushy_minisaacCooldown = Hushy.Stats.MinisaacCooldown(familiar, fData.Sewn_hushy_floorMinisaacSpawned)
                else
                    fData.Sewn_hushy_minisaacCooldown = fData.Sewn_hushy_minisaacCooldown - 1
                end
            end
        end
    else
        fData.Sewn_hushy_minisaacCooldown = Hushy.Stats.MinisaacCooldown(familiar, fData.Sewn_hushy_floorMinisaacSpawned)
        fData.Sewn_hushy_circleAttackFiredTears = 0
        fData.Sewn_hushy_circleAttackCooldown = Hushy.Stats.AttackCircleCooldown[level]
        fData.Sewn_hushy_circleAttackPatternIndex = nil
    end

    fData.Sewn_hushy_circleAttackOffset = fData.Sewn_hushy_circleAttackOffset + 0.1
end

function Hushy:OnFamiliarHitNPC(familiar, npc, damageAmount, damageFlags, entityRef, damageCountdown)
    if entityRef.Type == EntityType.ENTITY_FAMILIAR then
        local fData = familiar:GetData()
        local level = Sewn_API:GetLevel(fData)
        local damageMultiplier = Hushy.Stats.CollisionDamageBonusMultiplier[level]

        npc:TakeDamage(damageAmount * damageMultiplier, DamageFlag.DAMAGE_CLONES, EntityRef(familiar), damageCountdown)
    end
end

function Hushy:OnFamiliarNewLevel(familiar)
    local fData = familiar:GetData()
    fData.Sewn_hushy_floorMinisaacSpawned = 0
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, Hushy.FamiliarInit, FamiliarVariant.HUSHY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_INIT, Hushy.FamiliarInit, FamiliarVariant.HUSHY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, Hushy.OnFamiliarUpdate, FamiliarVariant.HUSHY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_HIT_NPC, Hushy.OnFamiliarHitNPC, FamiliarVariant.HUSHY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_NEW_LEVEL, Hushy.OnFamiliarNewLevel, FamiliarVariant.HUSHY)