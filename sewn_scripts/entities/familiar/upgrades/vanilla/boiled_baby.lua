local BurstTears = require("sewn_scripts.helpers.burst_tears")
local Random = require("sewn_scripts.helpers.random")

local BoiledBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.BOILED_BABY, CollectibleType.COLLECTIBLE_BOILED_BABY)

BoiledBaby.Stats = {
    AdditionalTearsMin = 1,
    AdditionalTearsMax = 6,
    BaseTearsDamage = 3,
    BigTearsChance = 30,
    BigTearsDamage = 6.25,
    BigTearsSizeMultiplier = 1.11,
    FireTearCooldownMin = 5,
    FireTearCooldownMax = 30,
}

local function GetDirectionPlayerFire(familiar, strength, randomStrength, familiarVelocityInfluenceStrength)
    strength = strength or 5
    randomStrength = randomStrength or 0
    familiarVelocityInfluenceStrength = familiarVelocityInfluenceStrength or 0.5

    local velo = Vector(0, 0)
    local dir = familiar.Player:GetFireDirection()
    if dir == Direction.LEFT then
        velo.X = -strength + (math.random() - 0.5) * randomStrength
        velo.Y = (math.random() - 0.5) * randomStrength
    elseif dir == Direction.RIGHT then
        velo.X = strength + (math.random() - 0.5) * randomStrength
        velo.Y = (math.random() - 0.5) * randomStrength
    elseif dir == Direction.UP then
        velo.X = (math.random() - 0.5) * randomStrength
        velo.Y = -strength + (math.random() - 0.5) * randomStrength
    elseif dir == Direction.DOWN then
        velo.X = (math.random() - 0.5) * randomStrength
        velo.Y = strength + (math.random() - 0.5) * randomStrength
    else
        velo.X = (math.random() - 0.5) * randomStrength
        velo.Y = (math.random() - 0.5) * randomStrength
    end

    velo.X = velo.X + familiar.Velocity.X * familiarVelocityInfluenceStrength
    velo.Y = velo.Y + familiar.Velocity.Y * familiarVelocityInfluenceStrength

    return velo, dir
end


function BoiledBaby:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()
    local sprite = familiar:GetSprite()
    
    if sprite:IsEventTriggered("Shoot") then
        local rollTears = familiar:GetDropRNG():RandomInt(BoiledBaby.Stats.AdditionalTearsMax - BoiledBaby.Stats.AdditionalTearsMin) + BoiledBaby.Stats.AdditionalTearsMin
        local tears = BurstTears(familiar, rollTears, BoiledBaby.Stats.BaseTearsDamage, 7, false, TearVariant.BLOOD)
        for _, tear in ipairs(tears) do
            if Random:CheckRoll(BoiledBaby.Stats.BigTearsChance) then
                tear.CollisionDamage = BoiledBaby.Stats.BigTearsDamage
                tear.Scale = tear.Scale * BoiledBaby.Stats.BigTearsSizeMultiplier
            end
            tear.FallingSpeed = math.random() * -15 - 3
            tear.FallingAcceleration = 0.8
        end
    end
end

function BoiledBaby:OnFamiliarUpgraded_Ultra(familiar, isPermanentUpgrade)
    local fData = familiar:GetData()
    fData.Sewn_boiledBaby_tearsCooldown = 0
end
function BoiledBaby:OnFamiliarUpdate_Ultra(familiar)
    local fData = familiar:GetData()
    if fData.Sewn_boiledBaby_tearsCooldown <= 0 then
        local velo, direction = GetDirectionPlayerFire(familiar, 8, 7, 1)
        local damage = familiar:GetDropRNG():RandomFloat() * (BoiledBaby.Stats.BigTearsDamage - BoiledBaby.Stats.BaseTearsDamage) + BoiledBaby.Stats.BaseTearsDamage

        if familiar.Player:GetShootingInput():LengthSquared() == 0 then
            return
        end
        local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLOOD, 0, familiar.Position, velo, familiar):ToTear()

        tear.CollisionDamage = damage
        tear.Scale = 1 + math.sqrt(damage)/BoiledBaby.Stats.BigTearsDamage-0.3

        tear.Height = tear.Height - 20
        tear.FallingSpeed = math.random() * -15 - 3
        tear.FallingAcceleration = 0.8

        fData.Sewn_boiledBaby_tearsCooldown = math.random(BoiledBaby.Stats.AdditionalTearsMax - BoiledBaby.Stats.AdditionalTearsMin) + BoiledBaby.Stats.AdditionalTearsMin
    else
        fData.Sewn_boiledBaby_tearsCooldown = fData.Sewn_boiledBaby_tearsCooldown - 1
    end
end

function BoiledBaby:OnUltraKingBabyFireTear(familiar, kingBaby, tear)
    if tear.Variant == TearVariant.BLUE then
        tear:ChangeVariant(TearVariant.BLOOD)
    elseif tear.Variant == TearVariant.CUPID_BLUE then
        tear:ChangeVariant(TearVariant.CUPID_BLOOD)
    elseif tear.Variant == TearVariant.PUPULA then
        tear:ChangeVariant(TearVariant.PUPULA_BLOOD)
    elseif tear.Variant == TearVariant.GODS_FLESH then
        tear:ChangeVariant(TearVariant.GODS_FLESH_BLOOD)
    elseif tear.Variant == TearVariant.NAIL then
        tear:ChangeVariant(TearVariant.NAIL_BLOOD)
    elseif tear.Variant == TearVariant.GLAUCOMA then
        tear:ChangeVariant(TearVariant.GLAUCOMA_BLOOD)
    elseif tear.Variant == TearVariant.EYE then
        tear:ChangeVariant(TearVariant.EYE_BLOOD)
    end
    tear.TearFlags = tear.TearFlags | TearFlags.TEAR_BURSTSPLIT
end


Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, BoiledBaby.OnFamiliarUpdate, FamiliarVariant.BOILED_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, BoiledBaby.OnFamiliarUpgraded_Ultra, FamiliarVariant.BOILED_BABY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, BoiledBaby.OnFamiliarUpdate_Ultra, FamiliarVariant.BOILED_BABY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_ULTRA_KING_BABY_FIRE_TEAR, BoiledBaby.OnUltraKingBabyFireTear, FamiliarVariant.BOILED_BABY)