local Abel = { }

Abel.Stats = {
    AmountOfTears = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 6,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 8
    },
    TearDistanceFromAbel = 5,
    TearSpawnCooldown = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 15,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 10
    },
    TearMaxDistance = 10
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.ABEL, CollectibleType.COLLECTIBLE_ABEL)

function Abel:OnFamiliarInit(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    
    fData.Sewn_abel_tears = { }
    fData.Sewn_abel_tearCooldown = Abel.Stats.TearSpawnCooldown[level]
end

local function TrySpawnTear(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    if #fData.Sewn_abel_tears >= Abel.Stats.AmountOfTears[level] then
        return
    end

    if fData.Sewn_abel_tearCooldown > 0 then
        fData.Sewn_abel_tearCooldown = fData.Sewn_abel_tearCooldown - 1
        return
    end

    local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, familiar.Position, familiar.Velocity, familiar):ToTear()
    
    tear.FallingSpeed = 0
    tear.FallingAcceleration = -0.1

    table.insert(fData.Sewn_abel_tears, tear)

    fData.Sewn_abel_tearCooldown = Abel.Stats.TearSpawnCooldown[level]
end

local function UpdateAbelTear(familiar, tear, index)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    local familiarToTear = tear.Position - familiar.Position
    local familiarToTearDirection = familiarToTear:Normalized()

    local amountTears = Abel.Stats.AmountOfTears[level]

    local targetPosition = familiar.Position + Vector(
        math.cos(tear.FrameCount * 0.1),
        math.sin(tear.FrameCount * 0.1)
    )
    targetPosition = targetPosition:Rotated((360 / amountTears) * index)

    if familiarToTear:LengthSquared() < Abel.Stats.TearMaxDistance ^ 2 then
        targetPosition = targetPosition + familiarToTearDirection
    end

    tear.Position = targetPosition
    tear.Velocity = targetPosition - tear.Position
end

function Abel:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()
    
    TrySpawnTear(familiar)

    for i, tear in ipairs(fData.Sewn_abel_tears) do
        UpdateAbelTear(familiar, tear, i)
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_INIT, Abel.OnFamiliarInit, FamiliarVariant.ABEL)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, Abel.OnFamiliarInit, FamiliarVariant.ABEL)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, Abel.OnFamiliarUpdate, FamiliarVariant.ABEL)