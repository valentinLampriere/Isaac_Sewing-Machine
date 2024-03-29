local CColor = require("sewn_scripts.helpers.ccolor")

local LilLoki = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.LIL_LOKI, CollectibleType.COLLECTIBLE_LIL_LOKI)

LilLoki.Stats = {
    DamageBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.5
    },
    TearScale = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.1
    },
    KingBabyAdditionalTearDamage = 2.5
}

function LilLoki:OnFamiliarFireTear(familiar, tear)
    local fData = familiar:GetData()

    tear.CollisionDamage = tear.CollisionDamage * LilLoki.Stats.DamageBonus[Sewn_API:GetLevel(fData)]
    tear.Scale = tear.Scale * LilLoki.Stats.TearScale[Sewn_API:GetLevel(fData)]

    if fData.Sewn_lilLoki_isFirstTear then

        local velocities = {Vector(8, -8), Vector(8, 8), Vector(-8, -8), Vector(-8, 8)}
        for i = 1, 4 do
            local velocity = velocities[i] + familiar.Player.Velocity
            local newTear = Isaac.Spawn(EntityType.ENTITY_TEAR, tear.Variant, tear.SubType, familiar.Position, velocity, familiar):ToTear()
            newTear:SetColor(CColor(1, 0, 0), -1, 1, false, false)
            newTear.Scale = tear.Scale
            newTear.CollisionDamage = tear.CollisionDamage
        end

        fData.Sewn_lilLoki_isFirstTear = false
    end
end
function LilLoki:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()
    if familiar.FireCooldown == 1 then
        fData.Sewn_lilLoki_isFirstTear = true
    end
end

function LilLoki:OnUltraKingBabyShootTear(familiar, kingBaby, tear, npc)
    local velocities = {Vector(8, 0), Vector(0, 8), Vector(-8, 0), Vector(0, -8)}
    for i, velocity in ipairs(velocities) do
        local newTear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, tear.Position, velocity, kingBaby):ToTear()
        newTear:SetColor(CColor(1, 0, 0), -1, 1, false, false)
        newTear.Scale = 0.9
        newTear.CollisionDamage = LilLoki.Stats.KingBabyAdditionalTearDamage
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, LilLoki.OnFamiliarFireTear, FamiliarVariant.LIL_LOKI)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, LilLoki.OnFamiliarUpdate, FamiliarVariant.LIL_LOKI)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_ULTRA_KING_BABY_SHOOT_TEAR, LilLoki.OnUltraKingBabyShootTear, FamiliarVariant.LIL_LOKI)