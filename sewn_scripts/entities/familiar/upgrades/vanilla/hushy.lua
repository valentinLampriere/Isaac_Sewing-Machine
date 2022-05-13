local Debug = require("sewn_scripts.debug.debug")

local Hushy = { }

Hushy.Stats = {
    TearsFrameDelay = 1
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.HUSHY, CollectibleType.COLLECTIBLE_HUSHY)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.HUSHY,
    "{{ArrowUp}} Damage Up",
    "{{ArrowUp}} Damage Up", nil, "Hushy"
)

local function HandleContinuumTears(familiar)
    local fData = familiar:GetData()
    if fData.Sewn_hushy_tearDelay == nil then
        fData.Sewn_hushy_offsetA = 0
        fData.Sewn_hushy_offsetB = 0
        fData.Sewn_hushy_tearDelay = Hushy.Stats.TearsFrameDelay
    end

    if fData.Sewn_hushy_tearDelay <= 0 then
        local normalizedDirection = Vector(
            math.cos(familiar.FrameCount * fData.Sewn_hushy_offsetA * fData.Sewn_hushy_offsetB),
            math.sin(familiar.FrameCount * fData.Sewn_hushy_offsetA * fData.Sewn_hushy_offsetB)
        )

        Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, familiar.Position, normalizedDirection * 6, familiar)
        fData.Sewn_hushy_tearDelay = Hushy.Stats.TearsFrameDelay
    end

    fData.Sewn_hushy_tearDelay = fData.Sewn_hushy_tearDelay - 1
    fData.Sewn_hushy_offsetA = fData.Sewn_hushy_offsetA + 0.001
    fData.Sewn_hushy_offsetB = fData.Sewn_hushy_offsetB + 0.01
end

function Hushy:OnFamiliarUpdate(familiar)
    local player = familiar.Player

    if player:GetShootingInput():LengthSquared() > 0 then
        HandleContinuumTears(familiar)
    end
end


Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, Hushy.OnFamiliarUpdate, FamiliarVariant.HUSHY)