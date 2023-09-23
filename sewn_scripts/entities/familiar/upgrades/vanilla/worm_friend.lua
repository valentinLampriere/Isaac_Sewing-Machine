local WormFriend = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.WORM_FRIEND, CollectibleType.COLLECTIBLE_WORM_FRIEND)

WormFriend.Stats = {
    SuckBulletRadius = 80,
    SuckImpact = 0.5, -- [0, 1]
    SuckStrength = 8,
    CooldownReduction = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 50,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 50
    },
    BulletDamage = 1,
    AdditionalDamageMultiplier = { -- Apply this first
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.25
    },
    AdditionalDamageFlat = { -- Add this after the multiplication
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1
    },
}

local WormFriendState = {
    UNDERGROUND = 0,
    GRAB = 1,
    RELEASE = 2
}

local function HandleCollidingBullets(familiar)
    if familiar.Target == nil then
        return
    end

    local bullets = Isaac.FindInRadius(familiar.Position, familiar.Size, EntityPartition.BULLET)
    for _, bullet in ipairs(bullets) do
        familiar.Target:TakeDamage(WormFriend.Stats.BulletDamage, 0, EntityRef(bullet), 2)
        bullet:Die()
    end
end

local function HandleRadiusBullets(familiar)
    local fData = familiar:GetData()
    fData.Sewn_wormFriend_catchBullets = Isaac.FindInRadius(familiar.Position, WormFriend.Stats.SuckBulletRadius, EntityPartition.BULLET)
    for _, bullet in ipairs(fData.Sewn_wormFriend_catchBullets) do
        local bulletToFamiliarNormalized = (familiar.Position - bullet.Position):Normalized()
        bullet.Velocity = bullet.Velocity * (1 - WormFriend.Stats.SuckImpact) + (bulletToFamiliarNormalized * WormFriend.Stats.SuckStrength) * WormFriend.Stats.SuckImpact
    end
end

local function HandleBulletsOnRelease(familiar)
    local fData = familiar:GetData()

    if fData.Sewn_wormFriend_catchBullets == nil then
        return
    end

    for _, bullet in ipairs(fData.Sewn_wormFriend_catchBullets) do
        bullet = bullet:ToProjectile()
        bullet.FallingSpeed = bullet.FallingSpeed * 5
    end

    fData.Sewn_wormFriend_catchBullets = nil
end

local function ReduceCooldown(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    if fData.Sewn_wormFriend_previousFireCooldown == nil then
        fData.Sewn_wormFriend_previousFireCooldown = familiar.FireCooldown
        return
    end

    if fData.Sewn_wormFriend_previousFireCooldown < familiar.FireCooldown then
        -- It finish it attacks and enter cooldown mode.
        familiar.FireCooldown = familiar.FireCooldown - WormFriend.Stats.CooldownReduction[level]
    end

    fData.Sewn_wormFriend_previousFireCooldown = familiar.FireCooldown
end


function WormFriend:OnFamiliarUpgraded(familiar, isPermanentUpgrade)
    Sewn_API:HideCrown(familiar)
end

function WormFriend:OnFamiliarUpdate(familiar)
    ReduceCooldown(familiar)

    if familiar.State == WormFriendState.GRAB then
        Sewn_API:HideCrown(familiar, false)

        HandleCollidingBullets(familiar)
        
        HandleRadiusBullets(familiar)
    elseif familiar.State == WormFriendState.RELEASE then
        Sewn_API:HideCrown(familiar, true)
        HandleBulletsOnRelease(familiar)
    end
end

function WormFriend:OnEntityTakeDamage(familiar, entity, amount, flags, source, countdown)
    if flags & DamageFlag.DAMAGE_CLONES == DamageFlag.DAMAGE_CLONES then
        return
    end

    if familiar.State ~= WormFriendState.GRAB then
        return
    end
    
    if familiar.Target == nil or entity == nil then
        return
    end

    if GetPtrHash(familiar.Target) ~= GetPtrHash(entity) then
        return
    end
    
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    local damage = amount * WormFriend.Stats.AdditionalDamageMultiplier[level] + WormFriend.Stats.AdditionalDamageFlat[level]
    entity:TakeDamage(damage, flags | DamageFlag.DAMAGE_CLONES, source, countdown)
    return false
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, WormFriend.OnFamiliarUpgraded, FamiliarVariant.WORM_FRIEND)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, WormFriend.OnFamiliarUpdate, FamiliarVariant.WORM_FRIEND)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ENTITY_TAKE_DAMAGE, WormFriend.OnEntityTakeDamage, FamiliarVariant.WORM_FRIEND)