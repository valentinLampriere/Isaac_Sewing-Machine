local Enums = require("sewn_scripts.core.enums")
local Globals = require("sewn_scripts.core.globals")
local Random = require("sewn_scripts.helpers.random")

local LostSoul = { }

LostSoul.Stats = {
    [Sewn_API.Enums.FamiliarLevel.SUPER] = 0.5,
    [Sewn_API.Enums.FamiliarLevel.ULTRA] = 0.5
}

LostSoul.State = {
    NORMAL = 1,
    PRE_SPAWN = 2,
    SPAWN = 3,
    DEAD = 4
}

LostSoul.Reward = {
    ITEM = 1,
    ETERNAL_HEARTS = 2,
    SOUL_HEARTS = 3
}

local HolyMantleBreakEntity = {
    Type = 1000,
    Variant = 16,
    SubType = 11
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.LOST_SOUL, CollectibleType.COLLECTIBLE_LOST_SOUL)

local function SpawnMantleEffect(familiar)
    local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, Enums.EffectVariant.LOST_SOUL_HOLY_MANTLE, 0, familiar.Position, familiar.Velocity, familiar):ToEffect()
    effect.DepthOffset = -5
    return effect
end

local function BreaksMantle(familiar)
    local fData = familiar:GetData()
    familiar.State = LostSoul.State.NORMAL

    fData.Sewn_lostSoul_holyMantleEffect:Remove()
    fData.Sewn_lostSoul_holyMantleEffect = nil
    fData.Sewn_lostSoul_hasHolyMantle = false

    Isaac.Spawn(HolyMantleBreakEntity.Type, HolyMantleBreakEntity.Variant, HolyMantleBreakEntity.SubType, familiar.Position, Globals.V0, nil)

    
    Globals.SFX:Stop(SoundEffect.SOUND_ISAAC_HURT_GRUNT)
    Globals.SFX:Play(SoundEffect.SOUND_HOLY_MANTLE)
    Globals.SFX:AdjustPitch(SoundEffect.SOUND_HOLY_MANTLE, 1)
end

local function HandleDying(familiar)
    local fData = familiar:GetData()

    if familiar.State == LostSoul.State.DEAD then
        if fData.Sewn_lostSoul_holyMantleEffect ~= nil then
            BreaksMantle(familiar)
        end

        if fData.Sewn_crown_hide ~= true then
            fData.Sewn_crown_hide = true
        end
    end
end

local function HandleRespawning(familiar)
    local fData = familiar:GetData()

    if familiar.State ~= LostSoul.State.DEAD then
        if fData.Sewn_crown_hide == true then
            fData.Sewn_crown_hide = false
        end
    end
end

local function HandleHolyMantleEffect(familiar)
    local fData = familiar:GetData()

    if familiar.State == LostSoul.State.DEAD then
        return
    end

    if fData.Sewn_lostSoul_hasHolyMantle == true then
        if fData.Sewn_lostSoul_holyMantleEffect == nil or fData.Sewn_lostSoul_holyMantleEffect:Exists() == false then
            fData.Sewn_lostSoul_holyMantleEffect = SpawnMantleEffect(familiar)
        end

        fData.Sewn_lostSoul_holyMantleEffect.Position = familiar.Position
        fData.Sewn_lostSoul_holyMantleEffect.Velocity = familiar.Velocity
    end
end

local function GetRewards()
    local pickups = Isaac.FindByType(EntityType.ENTITY_PICKUP, -1, -1, false, false)

    local eternalHeartsRewardPickups = { }
    local soulHeartsRewardPickups = { }
    for i, pickup in ipairs(pickups) do
        if pickup.FrameCount < 2 then
            pickup = pickup:ToPickup()
            if pickup.Variant == PickupVariant.PICKUP_COLLECTIBLE then
                return LostSoul.Reward.ITEM, pickup
            end

            if pickup.Variant == PickupVariant.PICKUP_HEART then
                if pickup.SubType == HeartSubType.HEART_ETERNAL then
                    table.insert(eternalHeartsRewardPickups, pickup)

                    if #eternalHeartsRewardPickups == 2 then
                        return LostSoul.Reward.ETERNAL_HEARTS, eternalHeartsRewardPickups
                    end
                end
                
                if pickup.SubType == HeartSubType.HEART_SOUL then
                    table.insert(soulHeartsRewardPickups, pickup)

                    if #soulHeartsRewardPickups == 3 then
                        return LostSoul.Reward.SOUL_HEARTS, soulHeartsRewardPickups
                    end
                end
            end
        end
    end
end

local function TrySpawnBetterRewards()
    local rewardType, reward = GetRewards()

    if rewardType == LostSoul.Reward.ITEM then
        local currentItem = reward.SubType
        local itemPool = Globals.Game:GetItemPool()
        local itemConfig = Isaac.GetItemConfig()
        local attempt = 0
        local bestItemFound = currentItem
        local pool = itemPool:GetPoolForRoom(RoomType.ROOM_ANGEL, Globals.Game:GetSeeds():GetStartSeed())

        while itemConfig:GetCollectible(currentItem).Quality < 3 and attempt < 10 do
            currentItem = itemPool:GetCollectible(pool, false, nil, reward.SubType) -- removing from pool set to false
    
            if itemConfig:GetCollectible(currentItem).Quality > itemConfig:GetCollectible(bestItemFound).Quality then
                bestItemFound = currentItem
            end
    
            attempt = attempt + 1
            
            if attempt > 5 then
                pool = ItemPoolType.POOL_TREASURE
            end
        end
        
        if reward.SubType == currentItem then
            return
        end
    
        reward:Remove()
    
        local newItem = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, bestItemFound, reward.Position, Globals.V0, nil)
        newItem:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
        itemPool:RemoveCollectible(bestItemFound)
    elseif rewardType == LostSoul.Reward.SOUL_HEARTS then
        local position = Globals.Room:FindFreePickupSpawnPosition(reward[1].Position)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_SOUL, position, Globals.V0, nil)
    elseif rewardType == LostSoul.Reward.ETERNAL_HEARTS then
        local position = Globals.Room:FindFreePickupSpawnPosition(reward[1].Position)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_ETERNAL, position, Globals.V0, nil)
    end
end

function LostSoul:OnFamiliarInit(familiar)
    local fData = familiar:GetData()

    Sewn_API:AddCrownOffset(familiar, Vector(0, 5))

    fData.Sewn_lostSoul_holyMantleEffect = nil
    fData.Sewn_lostSoul_hasHolyMantle = nil
    fData.Sewn_lostSoul_previousState = familiar.State
    fData.Sewn_lostSoul_hasRespawn = false
end

function LostSoul:OnFamiliarUpgraded(familiar, isPermanentUpgrade)
    LostSoul:OnFamiliarInit(familiar)

    if isPermanentUpgrade ~= true then
        return
    end

    local fData = familiar:GetData()
    fData.Sewn_lostSoul_hasHolyMantle = true
end

function LostSoul:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()

    HandleDying(familiar)
    HandleRespawning(familiar)

    HandleHolyMantleEffect(familiar)

    if familiar.State == LostSoul.State.SPAWN and fData.Sewn_lostSoul_previousState ~= LostSoul.State.SPAWN then
        TrySpawnBetterRewards()
    end

    fData.Sewn_lostSoul_previousState = familiar.State
end

function LostSoul:OnFamiliarClearRoom(familiar)
    if Globals.Room:GetType() == RoomType.ROOM_BOSS then
        return
    end

    if familiar.State ~= LostSoul.State.DEAD then
        return
    end

    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    if Random:CheckRoll(LostSoul.Stats.RespawnChance[level], familiar:GetDropRNG() == true) then
        familiar.Visible = true
        familiar.State = LostSoul.State.NORMAL
        fData.Sewn_lostSoul_hasRespawn = true
    end
end

function LostSoul:OnFamiliarNewRoom(familiar)
    local fData = familiar:GetData()

    if fData.Sewn_lostSoul_hasRespawn == false then
        fData.Sewn_lostSoul_hasHolyMantle = true
    end
end

function LostSoul:PreAddInMachine(familiar, machine)
    local fData = familiar:GetData()
    local mData = machine:GetData().SewingMachineData
    mData.Sewn_lostSoul_state = familiar.State

    if fData.Sewn_lostSoul_holyMantleEffect ~= nil then
        fData.Sewn_lostSoul_holyMantleEffect:Remove()
    end
end

function LostSoul:GetFromSewingMachine(familiar, player, machine, isUpgraded, newLevel)
    local mData = machine:GetData().SewingMachineData

    if mData.Sewn_lostSoul_state ~= nil then
        familiar.State = mData.Sewn_lostSoul_state
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_INIT, LostSoul.OnFamiliarInit, FamiliarVariant.LOST_SOUL)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, LostSoul.OnFamiliarUpgraded, FamiliarVariant.LOST_SOUL)

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, LostSoul.OnFamiliarUpdate, FamiliarVariant.LOST_SOUL)

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_CLEAN_ROOM, LostSoul.OnFamiliarClearRoom, FamiliarVariant.LOST_SOUL)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_NEW_ROOM, LostSoul.OnFamiliarNewRoom, FamiliarVariant.LOST_SOUL, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.PRE_ADD_FAMILIAR_IN_SEWING_MACHINE, LostSoul.PreAddInMachine, FamiliarVariant.LOST_SOUL)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_GET_FAMILIAR_FROM_SEWING_MACHINE, LostSoul.GetFromSewingMachine, FamiliarVariant.LOST_SOUL)