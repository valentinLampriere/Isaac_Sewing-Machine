local Globals = require("sewn_scripts.core.globals")
local Enums = require("sewn_scripts.core.enums")
local Delay = require("sewn_scripts.helpers.delay")

local LilAbaddon = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.LIL_ABADDON, CollectibleType.COLLECTIBLE_LIL_ABADDON)

LilAbaddon.Stats = {
    SwirlRate = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 60,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 50
    },
    MaxSwirl = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 3,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 4
    },
    LaserDamageMultiplier = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1.5,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.5
    },
    SwirlLaserRadius = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 50,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 70
    },
    SwirlLaserDamage = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 3,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 3.5
    },
    SwirlLaserTimeout = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 18,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 23
    },
}

local function SpawnSwirl(familiar)
    local fData = familiar:GetData()
    local swirl = Isaac.Spawn(EntityType.ENTITY_EFFECT, Enums.EffectVariant.LIL_ABADDON_BRIMSTONE_SWIRL, 0, familiar.Position, Globals.V0, familiar)

    if #fData.Sewn_lilAbaddon_swirls >= LilAbaddon.Stats.MaxSwirl[Sewn_API:GetLevel(fData)] then
        fData.Sewn_lilAbaddon_swirls[1]:Remove()
        table.remove(fData.Sewn_lilAbaddon_swirls, 1)
    end

    table.insert(fData.Sewn_lilAbaddon_swirls, swirl)
end

local function FireLaser(lilAbaddon, position, velocity, radius, damage, timeout, tearFlags, size)
    local fData = lilAbaddon:GetData()

    local laser = lilAbaddon.Player:FireTechXLaser(position, velocity or Globals.V0, radius, lilAbaddon, 1)
    local lData = laser:GetData()

    Delay:DelayFunction(function ()
        Globals.SFX:Stop(SoundEffect.SOUND_BLOOD_LASER_SMALL)
        Globals.SFX:Stop(SoundEffect.SOUND_LASERRING)
    end, 1)

    lData.Sewn_lilAbaddon_customLaser = true
    lData.Sewn_lilAbaddon_timeout = timeout
    laser.Variant = Enums.LaserVariant.LASER_BRIMSTONE
    --laser.SubType = 3
    laser.CollisionDamage = damage
    laser.TearFlags = tearFlags
    laser.Size = size

    laser:GetSprite():ReplaceSpritesheet(0, "/gfx/effects/effect_darkring.png")
    laser:GetSprite():LoadGraphics()
    
    return laser
end

local function SpawnLasersFromSwirl(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    for _, swirl in ipairs(fData.Sewn_lilAbaddon_swirls) do
        FireLaser(familiar, swirl.Position, Globals.V0, LilAbaddon.Stats.SwirlLaserRadius[level], LilAbaddon.Stats.SwirlLaserDamage[level], LilAbaddon.Stats.SwirlLaserTimeout[level], TearFlags.TEAR_NORMAL, 8)
        swirl:GetSprite():Play("Death")
    end
    fData.Sewn_lilAbaddon_swirls = {}
end

function LilAbaddon:ResetSwirls(familiar)
    local fData = familiar:GetData()
    fData.Sewn_lilAbaddon_swirls = { }
end

function LilAbaddon:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    
    if familiar.FireCooldown % LilAbaddon.Stats.SwirlRate[level] == 0 and (Sewn_API:IsUltra(fData) or familiar.FireCooldown < 0) then
        SpawnSwirl(familiar)
    end

    local lasers = Isaac.FindByType(7, Enums.LaserVariant.LASER_BRIMSTONE, -1, false, true)
    for _, laser in ipairs(lasers) do
        local lData = laser:GetData()
        laser = laser:ToLaser()

        if laser.SpawnerEntity ~= nil and GetPtrHash(laser.SpawnerEntity) == GetPtrHash(familiar) then -- lilAbaddon's laser
            if laser.FrameCount == 1 then
                laser.CollisionDamage = laser.CollisionDamage * LilAbaddon.Stats.LaserDamageMultiplier[level]
            end
        end
        
        if lData.Sewn_lilAbaddon_customLaser == true then
            local laserFadeoutFrame = 5
            -- Custom Timeout because EntityLaser.Timeout is buggy with ring lasers
            if laser.FrameCount == lData.Sewn_lilAbaddon_timeout - laserFadeoutFrame then
                laser.Timeout = laserFadeoutFrame
            end
        end
    end
end

function LilAbaddon:OnFamiliarShootAnim(familiar, sprite)
    local fData = familiar:GetData()
    if sprite:GetFrame() > 0 then return end
    
    SpawnLasersFromSwirl(familiar)
end


Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, LilAbaddon.ResetSwirls, FamiliarVariant.LIL_ABADDON)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_NEW_ROOM, LilAbaddon.ResetSwirls, FamiliarVariant.LIL_ABADDON)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, LilAbaddon.OnFamiliarUpdate, FamiliarVariant.LIL_ABADDON)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_PLAY_ANIM, LilAbaddon.OnFamiliarShootAnim, FamiliarVariant.LIL_ABADDON, nil, "FloatShootDown", "FloatShootUp", "FloatShootSide")