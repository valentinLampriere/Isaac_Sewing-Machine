local Delay = require("sewn_scripts.helpers.delay")
local SewnMod = require("sewn_scripts.sewn_mod")
local MultidimensionalBaby = { }

MultidimensionalBaby.Stats = {
    [tostring(true)] = {
        PlayerPositionDelay = {
            [Sewn_API.Enums.FamiliarLevel.SUPER] = 25,
            [Sewn_API.Enums.FamiliarLevel.ULTRA] = 2
        }
    },
    [tostring(false)] = {
        PlayerPositionDelay = {
            [Sewn_API.Enums.FamiliarLevel.SUPER] = 50,
            [Sewn_API.Enums.FamiliarLevel.ULTRA] = 30
        }
    }
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.MULTIDIMENSIONAL_BABY, CollectibleType.COLLECTIBLE_MULTIDIMENSIONAL_BABY)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.MULTIDIMENSIONAL_BABY,
    "",
    "", nil, "Multidimensional Baby"
)

local function DuplicateTear(familiar, tear)
    local direction = tear.Velocity:Normalized()
    --local offset = Vector(
    --    direction.X * math.cos(45) - direction.Y * math.sin(45),
    --    direction.Y * math.sin(45) - direction.Y * math.cos(45)
    --)
    --offset = offset + direction
    local offset = direction
    local _tear = Isaac.Spawn(tear.Type, tear.Variant, tear.SubType, tear.Position + offset * 10, tear.Velocity, tear.Parent):ToTear()
    local _tData = _tear:GetData()

    _tear.Mass = tear.Mass
    _tear.Size = tear.Size
    _tear.Friction = tear.Friction
    _tear.TearFlags = tear.TearFlags
    _tear.Height = tear.Height
    _tear.CollisionDamage = tear.CollisionDamage * 0.9
    _tear.Scale = tear.Scale * 0.93
    _tear.FallingAcceleration = tear.FallingAcceleration
    _tear.FallingSpeed = tear.FallingSpeed

    _tData.Sewn_multidimensionaBaby_isOwnTear = true

    return _tear
end

local function HandleTear(familiar, tear)
    local tData = tear:GetData()

    if tData.Sewn_multidimensionaBaby_twinTear then
        print("MULTIDIMENSIONAL")
        DuplicateTear(familiar, tear)
        DuplicateTear(familiar, tData.Sewn_multidimensionaBaby_twinTear)
    end
    --tData.Sewn_multidimensionaBaby_ownTear = true
end

local function CheckMultidimensionalBabyTear(familiar, tear)
    local tData = tear:GetData()
    local tears = Isaac.FindInRadius(familiar.Position, tear.Size + 5, EntityPartition.TEAR)
    for i, _tear in ipairs(tears) do
        if GetPtrHash(_tear) ~= GetPtrHash(tear) then
            local _tData = _tear:GetData()
            if _tear.Variant == tear.Variant and _tData.Sewn_multidimensionaBaby_ownTear == nil then
                _tData.Sewn_multidimensionaBaby_twinTear = tear
                tData.Sewn_multidimensionaBaby_twinTear = _tear
                --tData.Sewn_multidimensionaBaby_ownTear = true
                _tData.Sewn_multidimensionaBaby_ownTear = true
                return false
            end
        end
    end
    if tear ~= nil and tear:Exists() and tData.Sewn_multidimensionaBaby_ownTear == nil then
        if (tear.Position - familiar.Position):LengthSquared() <= (tear.Size + familiar.Size) ^2 then
            return true
        end
    end
    return false
end

local function RemoveFakeCopyTear(familiar, tear)
    local tData = tear:GetData()
    if tData.Sewn_multidimensionaBaby_lastFrameInside == nil then
        return
    end
    local tears = Isaac.FindInRadius(familiar.Position, familiar.Size, EntityPartition.TEAR)
    for i, _tear in ipairs(tears) do
        local _tData = _tear:GetData()
        if _tData.Sewn_multidimensionaBaby_lastFrameInside and _tData.Sewn_multidimensionaBaby_lastFrameInside == tData.Sewn_multidimensionaBaby_lastFrameInside then
            _tear:Remove()
        end
    end
end

function MultidimensionalBaby:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    local player = familiar.Player

    if fData.Sewn_multidimensionaBaby_playersTracker == nil then
        fData.Sewn_multidimensionaBaby_playersTracker = { }
    end

    if fData.Sewn_multidimensionaBaby_playersTracker[player.FrameCount] ~= nil then
        --familiar.Position = fData.Sewn_multidimensionaBaby_playersTracker[player.FrameCount].Position
        --familiar.Velocity = familiar.Velocity * 0 + fData.Sewn_multidimensionaBaby_playersTracker[player.FrameCount].Velocity * 1
        --fData.Sewn_multidimensionaBaby_playersTracker[player.FrameCount - MultidimensionalBaby.Stats[tostring(REPENTANCE ~= nil)].PlayerPositionDelay[level]] = nil
    end

    --fData.Sewn_multidimensionaBaby_playersTracker[player.FrameCount + MultidimensionalBaby.Stats[tostring(REPENTANCE ~= nil)].PlayerPositionDelay[level]] = { Position = player.Position, Velocity = player.Velocity }
    --familiar:MoveDelayed(MultidimensionalBaby.Stats[tostring(REPENTANCE ~= nil)].PlayerPositionDelay[level])

    --[[local tears = Isaac.FindInRadius(familiar.Position, 50, EntityPartition.TEAR)
    for i, tear in ipairs(tears) do
        if tear ~= nil then
            tear = tear:ToTear()
            local tData = tear:GetData()
            if tear.Variant == TearVariant.MULTIDIMENSIONAL and tear.FrameCount == 1 then
                if CheckMultidimensionalBabyTear(familiar, tear) then
                    HandleTear(familiar, tear)
                end
            else
                Delay:DelayFunction(function()
                    if tear.Variant == TearVariant.MULTIDIMENSIONAL and CheckMultidimensionalBabyTear(familiar, tear) then
                        HandleTear(familiar, tear)
                    end
                end, 1, true)
            end
        end
    end--]]

    local tears = Isaac.FindInRadius(familiar.Position, familiar.Size, EntityPartition.TEAR)
    for i, tear in ipairs(tears) do
        local tData = tear:GetData()
        --[[if tData.Sewn_multidimensionaBaby_lastFrameInside == nil then
            tData.Sewn_multidimensionaBaby_lastFrameInside = familiar.FrameCount
        else
            tData.Sewn_multidimensionaBaby_lastFrameInside = tData.Sewn_multidimensionaBaby_lastFrameInside + 1
        end--]]

        --tData.Sewn_multidimensionaBaby_lastFrameInside = tData.Sewn_multidimensionaBaby_lastFrameInside and tData.Sewn_multidimensionaBaby_lastFrameInside + 1 or familiar.FrameCount
        
        fData.Sewn_multidimensionaBaby_tearTracker[GetPtrHash(tear)] = tear:ToTear()
        --[[if tData.Sewn_multidimensionaBaby_tearInitInside ~= nil and fData.Sewn_multidimensionaBaby_tearTracker[GetPtrHash(tear)] == nil and tData.Sewn_multidimensionaBaby_isOwnTear == nil then
            fData.Sewn_multidimensionaBaby_tearTracker[GetPtrHash(tear)] = tear:ToTear()
        end--]]
    end
    for ptr, tear in pairs(fData.Sewn_multidimensionaBaby_tearTracker) do
        if tear ~= nil and tear:Exists() then
            if (tear.Position - familiar.Position):LengthSquared() > (tear.Size + familiar.Size + 2) ^2 then
                Delay:DelayFunction(function ()
                    DuplicateTear(familiar, tear)
                end)
                fData.Sewn_multidimensionaBaby_tearTracker[GetPtrHash(tear)] = nil
            end
        else
            fData.Sewn_multidimensionaBaby_tearTracker[GetPtrHash(tear)] = nil
        end
    end
end

function MultidimensionalBaby:OnFamiliarInit(familiar, isPermanentUpgrade)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    fData.Sewn_multidimensionaBaby_tearTracker = { }
end

function MultidimensionalBaby:OnNewRoom(familiar)
    local fData = familiar:GetData()
    fData.Sewn_multidimensionaBaby_playersTracker = { }
end


function MultidimensionalBaby:PostTearInit(tear)
    local tData = tear:GetData()
    local multidimensionalBabies = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.MULTIDIMENSIONAL_BABY, -1, false, false)
    for _, multidimensionalBaby in ipairs(multidimensionalBabies) do
        multidimensionalBaby = multidimensionalBaby:ToFamiliar()
        if (tear.Position - multidimensionalBaby.Position):LengthSquared() <= (tear.Size + multidimensionalBaby.Size) ^2 then
            tData.Sewn_multidimensionaBaby_tearInitInside = true
        end
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, MultidimensionalBaby.OnFamiliarUpdate, FamiliarVariant.MULTIDIMENSIONAL_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, MultidimensionalBaby.OnFamiliarInit, FamiliarVariant.MULTIDIMENSIONAL_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_INIT, MultidimensionalBaby.OnFamiliarInit, FamiliarVariant.MULTIDIMENSIONAL_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_NEW_ROOM, MultidimensionalBaby.OnNewRoom, FamiliarVariant.MULTIDIMENSIONAL_BABY)
SewnMod:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, MultidimensionalBaby.PostTearInit)