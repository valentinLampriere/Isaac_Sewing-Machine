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

-- Sewn_API:AddFamiliarDescription(
--     FamiliarVariant.DRY_BABY,
--     "{{ArrowUp}} Increases chance to trigger Necronomicon effect#When it triggers the effect, enemy projectiles in the room are destroyed",
--     "{{ArrowUp}} Increases chance to trigger Necronomicon effect even more!#When it triggers the effect, enemy projectiles in the room are turned into bone shards", nil, "Dry Baby"
-- )
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.DRY_BABY,
    "{{ArrowUp}} 更容易触发死灵之书效果 #触发效果时清除所有敌方子弹",
    "更加容易触发死灵书效果 #触发效果时将所有敌方子弹转换为可阻挡弹幕的漂浮骨头", nil, "枯骨宝宝","zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.DRY_BABY,
    "{{ArrowUp}} Увеличивает шанс эффекта Некрономикона#При срабатывании также уничтожает все вражеские снаряды в комнате",
    "{{ArrowUp}} Увеличивает шанс эффекта Некрономикона еще больше!#При срабатывании также превращает все вражеские снаряды в комнате в костяшки", nil, "Высушенный Малыш", "ru"
)
-- Sewn_API:AddFamiliarDescription(
--     FamiliarVariant.DRY_BABY,
--     "{{ArrowUp}} Augmente les chances de déclencher l'effet du Necronomicon#Lorsque l'effet se déclenche, détruit tous les projectiles",
--     "{{ArrowUp}} Augmente davantage les chances de déclencher l'effet du Necronomicon#Lorsque l'effet se déclenche, transforme tous les projectiles en os", nil, "Bébé Désséché", "fr"
-- )
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.DRY_BABY,
    "{{ArrowUp}} Aumenta la probabilidad de hacer el efecto del Necronomicón#Al hacer este efecto, todos los proyectiles en la habitación se destruyen",
    "Aumenta aún más la probabilidad de hacer el efecto del Necronomicón#Al hacer este efecto, todos los proyectiles en la habitación se convierten en huesos", nil, "Bebé Seco", "spa"
)

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