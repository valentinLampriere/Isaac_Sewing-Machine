local DemonBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.DEMON_BABY, CollectibleType.COLLECTIBLE_DEMON_BABY)

DemonBaby.Stats = {
    Range = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 150,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 180
    },
    FireRate = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 10,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 8
    }
}

local animationNames = {"FloatShootDown", "FloatShootUp", "FloatShootSide"}

local function GetDirectionFromAngle(angle)
    if angle == nil then return Direction.NO_DIRECTION end
    if angle > 45 and angle < 135 then
        return Direction.DOWN
    elseif angle > 135 and angle < 180 or angle > -180 and angle < -135 then
        return Direction.LEFT
    elseif angle > -135 and angle < -45 then
        return Direction.UP
    elseif angle > -45 and angle < 0 or angle > 0 and angle < 45 then
        return Direction.RIGHT
    end
    return Direction.NO_DIRECTION
end

local function FireAtNpc(familiar, npc)
    local fData = familiar:GetData()
    local sprite = familiar:GetSprite()

    if familiar.FireCooldown == 0 then
        local npcPositionOffset = npc.Position + npc.Velocity * 5
        local velo = (npcPositionOffset:Normalized() - familiar.Position)
        velo = velo:Normalized() * 8
        local newTear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLOOD, 0, familiar.Position, velo, familiar):ToTear()
        newTear.CollisionDamage = 3
        newTear.Parent = familiar
        newTear.TearFlags = newTear.TearFlags | TearFlags.TEAR_SPECTRAL
        familiar.FireCooldown = DemonBaby.Stats.FireRate[Sewn_API:GetLevel(fData)]
        newTear:GetData().Sewn_demonBaby_isCustomTear = true
        --sewnFamiliars:toBabyBenderTear(demonBaby, newTear)
        
        
        local angle = (npc.Position - familiar.Position):GetAngleDegrees()
        local direction = GetDirectionFromAngle(angle)
        if direction == Direction.DOWN then
            fData.Sewn_demonBaby_lastDirection = animationNames[1]
            fData.Sewn_demonBaby_flipX = false
        elseif direction == Direction.LEFT then
            fData.Sewn_demonBaby_lastDirection = animationNames[3]
            fData.Sewn_demonBaby_flipX = true
        elseif direction == Direction.UP then
            fData.Sewn_demonBaby_lastDirection = animationNames[2]
            fData.Sewn_demonBaby_flipX = false
        elseif direction == Direction.RIGHT then
            fData.Sewn_demonBaby_lastDirection = animationNames[3]
            fData.Sewn_demonBaby_flipX = false
        end
    end
    
    if fData.Sewn_demonBaby_lastDirection ~= nil and familiar.FireCooldown > 0 then
        sprite:Play(fData.Sewn_demonBaby_lastDirection, true)
        sprite.FlipX = fData.Sewn_demonBaby_flipX
    end
end

function DemonBaby:OnFamiliarUpdateFireTear(familiar)
    local fData = familiar:GetData()
    
    -- Removing tears from Demon Baby
    for _, tear in pairs(Isaac.FindByType(EntityType.ENTITY_TEAR, TearVariant.BLOOD, -1, false, false)) do
        tear = tear:ToTear()
        if tear.SpawnerEntity ~= nil and GetPtrHash(tear.SpawnerEntity) == GetPtrHash(familiar) then
        --if tear.SpawnerType == EntityType.ENTITY_FAMILIAR and tear.SpawnerVariant == FamiliarVariant.DEMON_BABY then
            if tear.FrameCount == 0 and tear:GetData().Sewn_demonBaby_isCustomTear == nil then
                tear:Remove()
            end
        end
    end
    local closestNpc = nil
    local closestNpc_distanceSqrt = 999999

    local npcs = Isaac.FindInRadius(familiar.Position, DemonBaby.Stats.Range[Sewn_API:GetLevel(fData)], EntityPartition.ENEMY)
    for _, npc in pairs(npcs) do
        if npc:IsVulnerableEnemy() and not npc:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
            local _distanceSqrt = (npc.Position - familiar.Position):LengthSquared()
            if _distanceSqrt < closestNpc_distanceSqrt then
                closestNpc_distanceSqrt = _distanceSqrt
                closestNpc = npc
            end
        end
    end

    if closestNpc ~= nil then
        FireAtNpc(familiar, closestNpc)
    end

    if familiar.FireCooldown > 0 then
        familiar.FireCooldown = familiar.FireCooldown - 1
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, DemonBaby.OnFamiliarUpdateFireTear, FamiliarVariant.DEMON_BABY)
