local Enums = require("sewn_scripts.core.enums")

local CubeBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.CUBE_BABY, CollectibleType.COLLECTIBLE_CUBE_BABY)

CubeBaby.Stats = {
    CreepSpawnRate = 50,
    CreepCooldown = 1,
    CreepDamage = 1.5,
    MaxSpeed = 500,
    UltraAuraScale = 1.5
}

local function SpawnCreep(familiar)
    local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL, 0, familiar.Position, Vector.Zero, familiar):ToEffect()
    creep.CollisionDamage = CubeBaby.Stats.CreepDamage
    creep:Update()
end

local function SpawnAura(familiar)
    local fData = familiar:GetData()
    local aura = Isaac.Spawn(EntityType.ENTITY_EFFECT, Enums.EffectVariant.CUBE_BABY_AURA, 0, familiar.Position, Vector.Zero, familiar):ToEffect()

    if Sewn_API:IsUltra(fData) then
        aura.Scale = CubeBaby.Stats.UltraAuraScale
        aura.SpriteScale = Vector(CubeBaby.Stats.UltraAuraScale, CubeBaby.Stats.UltraAuraScale)
    end

    return aura
end

function CubeBaby:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()

    if fData.Sewn_cubeBaby_aura == nil or not fData.Sewn_cubeBaby_aura:Exists() then
        fData.Sewn_cubeBaby_aura = SpawnAura(familiar)
    end
    
    -- Follow Cube Baby
    fData.Sewn_cubeBaby_aura.Position = familiar.Position
    fData.Sewn_cubeBaby_aura.Velocity = familiar.Velocity
end

function CubeBaby:OnFamiliarUpdate_Ultra(familiar)
    local fData = familiar:GetData()

    if fData.Sewn_cubeBaby_creepCooldown == 0 then
        local speed = math.ceil(familiar.Velocity:LengthSquared())
        if speed > CubeBaby.Stats.MaxSpeed - 1 then speed = CubeBaby.Stats.MaxSpeed - 1 end
        if familiar:GetDropRNG():RandomInt(CubeBaby.Stats.MaxSpeed - speed) < CubeBaby.Stats.CreepSpawnRate then
            SpawnCreep(familiar)
        end
        fData.Sewn_cubeBaby_creepCooldown = CubeBaby.Stats.CreepCooldown
    elseif fData.Sewn_cubeBaby_creepCooldown > 0 then
        fData.Sewn_cubeBaby_creepCooldown = fData.Sewn_cubeBaby_creepCooldown - 1
    end
end

function CubeBaby:RemoveAura(familiar)
    local fData = familiar:GetData()

    if fData.Sewn_cubeBaby_aura ~= nil then
        fData.Sewn_cubeBaby_aura:Remove()
        fData.Sewn_cubeBaby_aura = nil
    end
end

function CubeBaby:OnFamiliarUpgraded(familiar)
    local fData = familiar:GetData()

    if fData.Sewn_cubeBaby_aura ~= nil then
        fData.Sewn_cubeBaby_aura:Remove()
        fData.Sewn_cubeBaby_aura = nil
    end

    fData.Sewn_cubeBaby_creepCooldown = 0
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, CubeBaby.OnFamiliarUpdate, FamiliarVariant.CUBE_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, CubeBaby.OnFamiliarUpdate_Ultra, FamiliarVariant.CUBE_BABY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, CubeBaby.OnFamiliarUpgraded, FamiliarVariant.CUBE_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.PRE_ADD_FAMILIAR_IN_SEWING_MACHINE, CubeBaby.RemoveAura, FamiliarVariant.CUBE_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_LOSE_UPGRADE, CubeBaby.RemoveAura, FamiliarVariant.CUBE_BABY)