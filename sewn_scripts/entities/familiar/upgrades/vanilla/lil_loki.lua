local CColor = require("sewn_scripts.helpers.ccolor")

local LilLoki = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.LIL_LOKI, CollectibleType.COLLECTIBLE_LIL_LOKI)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.LIL_LOKI,
    "Fires in 8 directions",
    "{{ArrowUp}} Damage Up", nil, "Lil Loki"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.LIL_LOKI,
    "发射 8 向眼泪",
    "{{ArrowUp}} 攻击提升", nil, "洛基宝宝","zh_cn"
)
Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.LIL_LOKI,
    nil,
    "Damage Up (x1.5)"
)

LilLoki.Stats = {
    DamageBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.5
    },
    TearScale = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.1
    }
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
            --sewnFamiliars:toBabyBenderTear(familiar, newTear)
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

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, LilLoki.OnFamiliarFireTear, FamiliarVariant.LIL_LOKI)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, LilLoki.OnFamiliarUpdate, FamiliarVariant.LIL_LOKI)