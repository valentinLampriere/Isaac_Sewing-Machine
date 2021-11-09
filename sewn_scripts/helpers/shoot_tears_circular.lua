local function ShootTearsCircular(familiar, amountTears, tearVariant, position, velocity, dmg, flags, hasRandomOffset, notFireFromFamiliar)
    local tearFired = {}
    local spawnerTear = familiar
    tearVariant = tearVariant or TearVariant.BLUE
    position = position or familiar.Position
    velocity = velocity or 5
    if notFireFromFamiliar == true then
        spawnerTear = nil
    end
    local tearOffset = hasRandomOffset and math.random(360) or 0
    for i = 1, amountTears do
        local velo = Vector(velocity, velocity)
        velo = velo:Rotated((360 / amountTears) * i + tearOffset)
        velo = velo:Rotated(tearOffset)
        local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, tearVariant, 0, position, velo, spawnerTear):ToTear()
        tear.Parent = spawnerTear
        if dmg then
            tear.CollisionDamage = dmg
        end
        if flags then
            tear.TearFlags = tear.TearFlags | flags
        end
        --sewnFamiliars:toBabyBenderTear(familiar, tear)
        
        table.insert(tearFired, tear)
    end
    return tearFired
end

return ShootTearsCircular