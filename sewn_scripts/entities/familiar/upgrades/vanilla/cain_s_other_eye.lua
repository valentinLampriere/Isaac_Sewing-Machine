local Delay = require("sewn_scripts.helpers.delay")

local CainsOtherEye = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.CAINS_OTHER_EYE, CollectibleType.COLLECTIBLE_CAINS_OTHER_EYE)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.CAINS_OTHER_EYE,
    "Fires 2 tears instead of 1#Tears gain a Rubber Cement effect {{Collectible".. CollectibleType.COLLECTIBLE_RUBBER_CEMENT .."}}",
    "{{ArrowUp}}Range Up#Fires 4 tears", nil, "Cain's other Eye"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.CAINS_OTHER_EYE,
    "发射 2 颗眼泪而非 1 颗 # 眼泪具有 {{Collectible".. CollectibleType.COLLECTIBLE_RUBBER_CEMENT .."}} 橡胶胶水特效",
    "发射 4 颗眼泪 #射程增加", nil, "该隐的另一只眼","zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.CAINS_OTHER_EYE,
    "Стреляет 2 слезы вместо 1#Слёзы получают эффект Резинового Клея {{Collectible".. CollectibleType.COLLECTIBLE_RUBBER_CEMENT .."}} ",
    "{{ArrowUp}} Дальность +#Стреляет 4 слезы", nil, "Другой Глаз Каина", "ru"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.CAINS_OTHER_EYE,
    "Tire 2 larmes au lieu d'une#Les larmes gagnent l'effet de Colle Caoutchouc {{Collectible".. CollectibleType.COLLECTIBLE_RUBBER_CEMENT .."}}",
    "{{ArrowUp}} Portée#Tire 4 larmes", nil, "Œil Gauche de Caïn", "fr"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.CAINS_OTHER_EYE,
    "Dispara dos lágrimas en lugar de una#Las lágrimas reciben el efecto de Cemento Elástico {{Collectible".. CollectibleType.COLLECTIBLE_RUBBER_CEMENT .."}} ",
    "Dispara cuatro lágrimas#+ Alcance", nil, "El Otro Ojo De Caín", "spa"
)

CainsOtherEye.Stats = {
    AdditionalTears = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 3
    },
    DelayBetweenTears = 2
}

local function FireTear(familiar, tear)
    local newTear = Isaac.Spawn(EntityType.ENTITY_TEAR, tear.Variant, tear.SubType, familiar.Position, tear.Velocity, familiar):ToTear()
    local tData = newTear:GetData()
    newTear.CollisionDamage = tear.CollisionDamage
    newTear.TearFlags = tear.TearFlags
    newTear.Scale = tear.Scale
    newTear.TearFlags = tear.TearFlags | TearFlags.TEAR_BOUNCE
    newTear.FallingAcceleration = -0.05
    
    tData.Sewn_cainsOtherEyeTear = true
end

function CainsOtherEye:FamiliarFireTear(familiar, tear)
    local tData = tear:GetData()
    if tData.Sewn_cainsOtherEyeTear == true then return end
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    
    tear.TearFlags = tear.TearFlags | TearFlags.TEAR_BOUNCE
    
    for i = 1, CainsOtherEye.Stats.AdditionalTears[level] do
        Delay:DelayFunction(FireTear, i * CainsOtherEye.Stats.DelayBetweenTears, true, familiar, tear)
    end
end

function CainsOtherEye:FamiliarFireTear_Ultra(familiar, tear)
    tear.FallingAcceleration = -0.05
end


Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, CainsOtherEye.FamiliarFireTear_Ultra, FamiliarVariant.CAINS_OTHER_EYE, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, CainsOtherEye.FamiliarFireTear, FamiliarVariant.CAINS_OTHER_EYE)