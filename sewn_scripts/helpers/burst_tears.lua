local function BurstTears(familiar, amountTears, damage, force, differentSize, tearVariant, tearFlags, position)
    local spawnedTears = {}
    tearVariant = tearVariant or TearVariant.BLUE
    tearFlags = tearFlags or 0
    position = position or familiar.Position
    differentSize = differentSize or false
    force = force or 5
    damage = damage or 3.5

    for i = 1, amountTears do
        local velocity = Vector(0, 0)
        velocity.X = math.random() + math.random(force + 1 * 2) - force
        velocity.Y = math.random() + math.random(force + 1 * 2) - force
        local t = Isaac.Spawn(EntityType.ENTITY_TEAR, tearVariant, 0, position, velocity, familiar):ToTear()
        --sewnFamiliars:toBabyBenderTear(familiar, t)
        if differentSize == true then
            local sizeMulti = math.random() * 0.4 + 0.7
            t.Scale = sizeMulti
        end
        t.TearFlags = t.TearFlags | tearFlags
        t.FallingSpeed = -18
        t.FallingAcceleration = 1.5
        t.CollisionDamage = damage
        --sewnFamiliars:toBabyBenderTear(familiar, t)

        table.insert(spawnedTears, t)
    end
    return spawnedTears
end

return BurstTears