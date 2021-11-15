local scaleFactor = 0.2
local scaleOffset = 0.67
local function ShootTearsCircular(familiar, amountTears, tearVariant, position, velocity, dmg, flags, notFireFromFamiliar)
    local tearFired = {}
    local spawnerTear = familiar
    tearVariant = tearVariant or TearVariant.BLUE
    position = position or familiar.Position
    velocity = velocity or 5
    if notFireFromFamiliar == true then
        spawnerTear = nil
    end
    local tearOffset = math.random(360) or 0
    for i = 1, amountTears do
        local velo = Vector(velocity, velocity)
        velo = velo:Rotated((360 / amountTears) * i + tearOffset)
        velo = velo:Rotated(tearOffset)
        local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, tearVariant, 0, position, velo, spawnerTear):ToTear()
        tear.Parent = spawnerTear
        if dmg then
            tear.CollisionDamage = dmg
            tear.Scale = scaleFactor * math.log(dmg + 1, 10) + scaleFactor + scaleOffset
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