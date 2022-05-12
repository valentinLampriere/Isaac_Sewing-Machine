local GetDirectionFromAngle = require("sewn_scripts.helpers.get_direction_from_angle")

local AngelicPrism = { }

AngelicPrism.Stats = {
    MinDistanceWithPlayer = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 45,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 30
    },
    MoveTowardPlayerDeltaValue = 1.2,
    AdditionalTearFlags = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = TearFlags.TEAR_SPECTRAL,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = TearFlags.TEAR_SPECTRAL | TearFlags.TEAR_HOMING
    },
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.ANGELIC_PRISM, CollectibleType.COLLECTIBLE_ANGELIC_PRISM)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.ANGELIC_PRISM,
    "While the player fires tears in the direction of the prism, it gets closer to the player#Tears which pass through it turn spectral",
    "Move even closer to the player#Tears which goes through it gain homing", nil, "Angelic Prism"
)

local defaultOrbitDistance = Vector(85, 67.5)

function AngelicPrism:OnFamiliarInit(familiar)
    local fData = familiar:GetData()
    fData.Sewn_angelicPrism_tValue = 0
end

local function HandleSpin(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    local angle = (familiar.Position - familiar.Player.Position):GetAngleDegrees()
    local direction = GetDirectionFromAngle(angle)

    local newOrbit = defaultOrbitDistance - Vector(fData.Sewn_angelicPrism_tValue, fData.Sewn_angelicPrism_tValue)

    if direction == familiar.Player:GetFireDirection() then
        if newOrbit.X > AngelicPrism.Stats.MinDistanceWithPlayer[level] and newOrbit.Y > AngelicPrism.Stats.MinDistanceWithPlayer[level] then
            fData.Sewn_angelicPrism_tValue = fData.Sewn_angelicPrism_tValue + AngelicPrism.Stats.MoveTowardPlayerDeltaValue
        end
    else
        fData.Sewn_angelicPrism_tValue = fData.Sewn_angelicPrism_tValue - AngelicPrism.Stats.MoveTowardPlayerDeltaValue
        if fData.Sewn_angelicPrism_tValue < 0 then
            fData.Sewn_angelicPrism_tValue = 0
        end
    end

    local newOrbit = defaultOrbitDistance - Vector(fData.Sewn_angelicPrism_tValue, fData.Sewn_angelicPrism_tValue)
    familiar.OrbitDistance = newOrbit
    familiar.Velocity = familiar:GetOrbitPosition(familiar.Player.Position + familiar.Player.Velocity) - familiar.Position
end
function AngelicPrism:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    HandleSpin(familiar)

    local tears = Isaac.FindInRadius(familiar.Position, familiar.Size + 5, EntityPartition.TEAR)
    for _, tear in ipairs(tears) do
        tear = tear:ToTear()
        if tear.FrameCount == 1 then
            tear.TearFlags = tear.TearFlags | AngelicPrism.Stats.AdditionalTearFlags[level]
        end
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, AngelicPrism.OnFamiliarInit, FamiliarVariant.ANGELIC_PRISM)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_INIT, AngelicPrism.OnFamiliarInit, FamiliarVariant.ANGELIC_PRISM)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, AngelicPrism.OnFamiliarUpdate, FamiliarVariant.ANGELIC_PRISM)