local CainsOtherEye = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.CAINS_OTHER_EYE, CollectibleType.COLLECTIBLE_CAINS_OTHER_EYE)

CainsOtherEye.Stats = {
    DamageMultiplier = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0.75,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1
    },
    ScaleMultiplier = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.05
    },
    KingBabyTearDamageMultiplier = 0.75,
    KingBabyTearScaleMultiplier = 0.7
}

function CainsOtherEye:OnInit(familiar)
    local fData = familiar:GetData()

    fData.Sewn_cainOtherEye_tear_cooldown = familiar.Player.MaxFireDelay
end

local function GetRandomDiagonalVelocity(rng)
    local roll = rng:RandomInt(4)
    local upVector = Vector(0, -1)

    return upVector:Rotated(45 + 90 * roll)
end

local function FireTear(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    local rng = familiar:GetDropRNG()
    local direction = GetRandomDiagonalVelocity(rng)

    local tearVelocity = direction * (10 * familiar.Player.ShotSpeed)
    local tear = familiar.Player:FireTear(familiar.Position, tearVelocity, true, false, false, familiar.Player, CainsOtherEye.Stats.DamageMultiplier[level])
    tear.Scale = CainsOtherEye.Stats.ScaleMultiplier[level]

    if Sewn_API:IsUltra(fData) then
        tear.TearFlags = tear.TearFlags | TearFlags.TEAR_BOUNCE

        if tear.Variant == TearVariant.BLUE then
            tear:ChangeVariant(TearVariant.BLOOD)
        elseif tear.Variant == TearVariant.CUPID_BLUE then
            tear:ChangeVariant(TearVariant.CUPID_BLOOD)
        elseif tear.Variant == TearVariant.PUPULA then
            tear:ChangeVariant(TearVariant.PUPULA_BLOOD)
        else
            local tearColor = tear.Color
            tearColor:SetColorize(1, 0, 0, 0.5)
            tear:SetColor(tearColor, 0, 0, false, false)
        end
    end
end

function CainsOtherEye:OnUpdate(familiar)
    local fData = familiar:GetData()

    if fData.Sewn_cainOtherEye_tear_cooldown > 0 then
        fData.Sewn_cainOtherEye_tear_cooldown = fData.Sewn_cainOtherEye_tear_cooldown - 1
        return
    end

    if familiar.Player:GetShootingInput():LengthSquared() > 0.1 or familiar.Player:AreOpposingShootDirectionsPressed() == true then
        FireTear(familiar)
        fData.Sewn_cainOtherEye_tear_cooldown = familiar.Player.MaxFireDelay
    end
end

function CainsOtherEye:OnUltraKingBabyShootTear(familiar, kingBaby, tear, npc)
    local rng = kingBaby:GetDropRNG()
    local direction = GetRandomDiagonalVelocity(rng)
    local velocity = direction * tear.Velocity:Length()

    local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, tear.Position, velocity, kingBaby):ToTear()
    tear.CollisionDamage = tear.CollisionDamage * CainsOtherEye.Stats.KingBabyTearDamageMultiplier
    tear.Scale = tear.Scale * CainsOtherEye.Stats.KingBabyTearDamageMultiplier
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_INIT, CainsOtherEye.OnInit, FamiliarVariant.CAINS_OTHER_EYE)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, CainsOtherEye.OnInit, FamiliarVariant.CAINS_OTHER_EYE)

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, CainsOtherEye.OnUpdate, FamiliarVariant.CAINS_OTHER_EYE)

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_ULTRA_KING_BABY_SHOOT_TEAR, CainsOtherEye.OnUltraKingBabyShootTear, FamiliarVariant.CAINS_OTHER_EYE)