local FindCloserNpc = require("sewn_scripts.helpers.find_closer_npc")
local IsSpawnedBy = require("sewn_scripts.helpers.is_spawned_by")
local GetDirectionFromAngle = require("sewn_scripts.helpers.get_direction_from_angle")
local DemonBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.DEMON_BABY, CollectibleType.COLLECTIBLE_DEMON_BABY)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.DEMON_BABY,
    "Fires automatically through obstacles",
    "{{ArrowUp}} Range up#{{ArrowUp}} Tears Up", nil, "Demon Baby"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.DEMON_BABY,
    "眼泪变为幽灵眼泪",
    "{{ArrowUp}} 射程增加#{{ArrowUp}} 射速提升", nil, "恶魔宝宝","zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.DEMON_BABY,
    "Стреляет автоматически сквозь препятствия",
    "{{ArrowUp}} Дальность +#{{ArrowUp}} Скорострельность +", nil, "Малыш Демон", "ru"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.DEMON_BABY,
    "Tire automatiquement à travers les obstacles",
    "{{ArrowUp}} Portée#{{ArrowUp}} Débit", nil, "Bébé Démoniaque", "fr"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.DEMON_BABY,
    "Dispara automáticamente a través de las paredes",
    "{{ArrowUp}} ++ Alcance#{{ArrowUp}} + Lágrimas", nil, "Bebé Demonio", "spa"
)

DemonBaby.Stats = {
    Range = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 150,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 180
    },
    FireRate = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 10,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 8
    }
}

local animationNames = {"FloatShootDown", "FloatShootUp", "FloatShootSide"}

local function FireAtNpc(familiar, npc)
    local fData = familiar:GetData()
    local sprite = familiar:GetSprite()

    if familiar.FireCooldown == 0 then
        local npcPositionOffset = npc.Position + npc.Velocity * 5
        local velo = (npcPositionOffset - familiar.Position)
        velo = velo:Normalized() * 8
        local newTear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLOOD, 0, familiar.Position, velo, familiar):ToTear()
        newTear.CollisionDamage = 3
        newTear.Parent = familiar
        newTear.TearFlags = newTear.TearFlags | TearFlags.TEAR_SPECTRAL
        familiar.FireCooldown = DemonBaby.Stats.FireRate[Sewn_API:GetLevel(fData)]
        newTear:GetData().Sewn_demonBaby_isCustomTear = true
        --sewnFamiliars:toBabyBenderTear(demonBaby, newTear)
        
        
        local angle = (npc.Position - familiar.Position):GetAngleDegrees()
        local direction = GetDirectionFromAngle(angle)
        if direction == Direction.DOWN then
            fData.Sewn_demonBaby_lastDirection = animationNames[1]
            fData.Sewn_demonBaby_flipX = false
        elseif direction == Direction.LEFT then
            fData.Sewn_demonBaby_lastDirection = animationNames[3]
            fData.Sewn_demonBaby_flipX = true
        elseif direction == Direction.UP then
            fData.Sewn_demonBaby_lastDirection = animationNames[2]
            fData.Sewn_demonBaby_flipX = false
        elseif direction == Direction.RIGHT then
            fData.Sewn_demonBaby_lastDirection = animationNames[3]
            fData.Sewn_demonBaby_flipX = false
        end
    end
    
    if fData.Sewn_demonBaby_lastDirection ~= nil and familiar.FireCooldown > 0 then
        sprite:Play(fData.Sewn_demonBaby_lastDirection, true)
        sprite.FlipX = fData.Sewn_demonBaby_flipX
    end
end

function DemonBaby:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()
    
    -- Removing tears from Demon Baby
    for _, tear in pairs(Isaac.FindByType(EntityType.ENTITY_TEAR, TearVariant.BLOOD, -1, false, false)) do
        tear = tear:ToTear()
        if IsSpawnedBy(tear, familiar) then
            if tear.FrameCount == 0 and tear:GetData().Sewn_demonBaby_isCustomTear == nil then
                tear:Remove()
            end
        end
    end
    local closestNpc = FindCloserNpc(familiar.Position, DemonBaby.Stats.Range[Sewn_API:GetLevel(fData)])
    
    if closestNpc ~= nil then
        FireAtNpc(familiar, closestNpc)
    end

    if familiar.FireCooldown > 0 then
        familiar.FireCooldown = familiar.FireCooldown - 1
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, DemonBaby.OnFamiliarUpdate, FamiliarVariant.DEMON_BABY)
