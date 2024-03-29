local Random = require("sewn_scripts.helpers.random")
local Globals = require("sewn_scripts.core.globals")

local DryBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.DRY_BABY, CollectibleType.COLLECTIBLE_DRY_BABY)


DryBaby.Stats = {
    NecronomiconChance = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 7,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 20
    },
}

function DryBaby:familiarCollide(familiar, collider)
    if collider.Type == EntityType.ENTITY_PROJECTILE then
        if Random:CheckRoll(DryBaby.Stats.NecronomiconChance[Sewn_API:GetLevel(familiar:GetData())]) then
            local sprite = familiar:GetSprite()
            sprite:Play("Hit")
        end
    end
end
function DryBaby:PlayHitAnim(familiar, sprite)
    if sprite:GetFrame() < 23 then return end
    local fData = familiar:GetData()
    for i, bullet in pairs(Isaac.FindInRadius(familiar.Position, 1000, EntityPartition.BULLET)) do
        if Sewn_API:IsUltra(fData) then
            Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BONE_SPUR, 0, bullet.Position, Globals.V0, familiar)
        end
        bullet:Die()
    end
end
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.PRE_FAMILIAR_COLLISION, DryBaby.familiarCollide, FamiliarVariant.DRY_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_PLAY_ANIM, DryBaby.PlayHitAnim, FamiliarVariant.DRY_BABY, nil, "Hit")