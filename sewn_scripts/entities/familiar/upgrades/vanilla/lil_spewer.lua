local CColor = require("sewn_scripts.helpers.ccolor")
local Delay = require("sewn_scripts.helpers.delay")
local Globals = require("sewn_scripts.core.globals")

local LilSpewer = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.LIL_SPEWER, CollectibleType.COLLECTIBLE_LIL_SPEWER)

LilSpewer.Stats = {
    TearVelocity = 10,
    KingBabyTearCreepSpawnRate = 7,
    KingBabyTearCreepDamage = 0.5
}

local LilSpewerColors = {
    NORMAL = 0,
    WHITE = 1,
    RED = 2,
    BLACK = 3,
    YELLOW = 4
}
local LilSpewerSprites = {
    [LilSpewerColors.NORMAL] = "gfx/familiar/lilSpewer/familiar_125_lilspewer.png",
    [LilSpewerColors.WHITE] = "gfx/familiar/lilSpewer/familiar_125_lilspewer_white.png",
    [LilSpewerColors.RED] = "gfx/familiar/lilSpewer/familiar_125_lilspewer_red.png",
    [LilSpewerColors.BLACK] = "gfx/familiar/lilSpewer/familiar_125_lilspewer_black.png",
    [LilSpewerColors.YELLOW] = "gfx/familiar/lilSpewer/familiar_125_lilspewer_yellow.png"
}

local LilSpewerCreepVariant = {
    [LilSpewerColors.NORMAL] = EffectVariant.PLAYER_CREEP_GREEN,
    [LilSpewerColors.WHITE] = EffectVariant.PLAYER_CREEP_WHITE,
    [LilSpewerColors.RED] = EffectVariant.PLAYER_CREEP_RED,
    [LilSpewerColors.BLACK] = EffectVariant.PLAYER_CREEP_BLACK,
    [LilSpewerColors.YELLOW] = EffectVariant.PLAYER_CREEP_RED,
}

local function GetVelocityFromDirection(direction)
    local velocity = Vector(0, 0)

    if direction == Direction.LEFT then
        velocity.X = -LilSpewer.Stats.TearVelocity
    elseif direction == Direction.RIGHT then
        velocity.X = LilSpewer.Stats.TearVelocity
    elseif direction == Direction.UP then
        velocity.Y = -LilSpewer.Stats.TearVelocity
    elseif direction == Direction.DOWN then
        velocity.Y = LilSpewer.Stats.TearVelocity
    end

    return velocity
end

local LilSpewerTears = {
    [LilSpewerColors.NORMAL] = {
        Damage = 5,
        Color = CColor(1, 1, 0.95, 1, 0.08, 0.04, 0),
        Flags = 0
    },
    [LilSpewerColors.BLACK] = {
        Damage = 3.5,
        Color = CColor(0.1, 0.1, 0.1, 1),
        Flags = TearFlags.TEAR_GISH
    },
    [LilSpewerColors.WHITE] = {
        Damage = 3.5,
        Color = CColor(1, 1, 1, 1, 0.2, 0.15, 0.13),
        Flags = TearFlags.TEAR_SLOW
    },
    [LilSpewerColors.YELLOW] = {
        Damage = 5,
        Color = CColor(1, 1, 0, 1)
    },
    [LilSpewerColors.RED] = {
        Damage = 12.5,
        Scale = 1.25
    }
}


local function DefaultFire(familiar)
    local fData = familiar:GetData()
    local velocity = GetVelocityFromDirection(fData.Sewn_LilSpewer_lastDirection)
    for i = 0, 2 do
        local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, familiar.Position, velocity:Rotated(-20 + 20 * i) + familiar.Velocity * 0.5, familiar):ToTear()
        tear:SetColor(LilSpewerTears[familiar.State].Color, -1, 1, false, false)
        tear.CollisionDamage = LilSpewerTears[familiar.State].Damage
    end
end
local function YellowFire(familiar)
    local fData = familiar:GetData()
    local velocity = GetVelocityFromDirection(fData.Sewn_LilSpewer_lastDirection)
    local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, familiar.Position, velocity + familiar.Velocity * 0.5, familiar):ToTear()
    tear:SetColor(LilSpewerTears[familiar.State].Color, -1, 1, false, false)
    tear.CollisionDamage = LilSpewerTears[familiar.State].Damage
end

local LilSpewerTearAttack = {
    [LilSpewerColors.YELLOW] = function (familiar)
        Delay:DelayFunction(YellowFire, 1, true, familiar)
        Delay:DelayFunction(YellowFire, 3, true, familiar)
        Delay:DelayFunction(YellowFire, 5, true, familiar)
    end,
    [LilSpewerColors.RED] = function (familiar)
        local fData = familiar:GetData()
        local velocity = GetVelocityFromDirection(fData.Sewn_LilSpewer_lastDirection)
        local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLOOD, 0, familiar.Position, velocity + familiar.Velocity * 0.7, familiar):ToTear()
        tear.Scale = LilSpewerTears[familiar.State].Scale
        tear.CollisionDamage = LilSpewerTears[familiar.State].Damage
    end
}

function LilSpewer:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()
    
    if familiar.FireCooldown == -15 then

        local attackFunction = LilSpewerTearAttack[familiar.State] or DefaultFire

        fData.Sewn_LilSpewer_lastDirection = familiar.Player:GetFireDirection()
        if fData.Sewn_LilSpewer_lastDirection == Direction.NO_DIRECTION then
            fData.Sewn_LilSpewer_lastDirection = familiar.Player:GetHeadDirection()
        end

        attackFunction(familiar)
    end
end

local function RandomState(familiar)
    local roll = familiar:GetDropRNG():RandomInt(5)
    
    if roll == familiar.State then
        roll = RandomState(familiar)
    end
    return roll
end

function LilSpewer:OnFamiliarUpgrade_Ultra(familiar, isPermanentUpgrade)
    local fData = familiar:GetData()
    local sprite = familiar:GetSprite()
    fData.Sewn_lilSpewer_fireFrame = -1
    fData.Sewn_lilSpewer_firstState = familiar.State
    fData.Sewn_lilSpewer_secondState = RandomState(familiar)
    
    sprite:ReplaceSpritesheet(1, LilSpewerSprites[fData.Sewn_lilSpewer_secondState])
    sprite:LoadGraphics()
end
function LilSpewer:OnFamiliarUpdate_Ultra(familiar)
    local fData = familiar:GetData()
    
    if familiar.FireCooldown == -15 and fData.Sewn_lilSpewer_fireFrame + 1 ~= familiar.FrameCount then
        -- Change his state
        familiar.State = fData.Sewn_lilSpewer_secondState
        -- Reset the cooldown to 0 (ready to fire)
        familiar.FireCooldown = 0
        -- Fire puddle with the new state
        familiar:Shoot()
        --Fire aditionnal tears
        
        -- On next frame, reset the state of lil' spewer
        Delay:DelayFunction(function ()
            familiar.State = fData.Sewn_lilSpewer_firstState
        end, 1)
        
        fData.Sewn_lilSpewer_fireFrame = familiar.FrameCount
    end

    -- If lil spewer change his state (the player use a pill)
    if familiar.FireCooldown > 0 and fData.Sewn_lilSpewer_firstState ~= familiar.State then
        LilSpewer:OnFamiliarUpgrade_Ultra(familiar)
    end
    
    local sprite = familiar:GetSprite()
    if sprite.FlipX == true then
        sprite:ReplaceSpritesheet(0, LilSpewerSprites[fData.Sewn_lilSpewer_secondState])
        sprite:LoadGraphics()
    else
        sprite:ReplaceSpritesheet(0, LilSpewerSprites[fData.Sewn_lilSpewer_firstState])
        sprite:LoadGraphics()
    end
end

function LilSpewer:OnFamiliarLoseUpgrade(familiar, losePermanentUpgrade)
    local sprite = familiar:GetSprite()
    sprite:ReplaceSpritesheet(1, "")
    sprite:LoadGraphics()
end

function LilSpewer:OnUltraKingBabyShootTear(familiar, kingBaby, tear, npc)
    local tData = tear:GetData()
    tData.Sewn_lilSpewer_isKingBabyTear = true
    tData.Sewn_lilSpewer_spewerColor = familiar.State
end
function LilSpewer:OnUltraKingBabyTearUpdate(familiar, tear)
    local tData = tear:GetData()
    local creepVariant = LilSpewerCreepVariant[tData.Sewn_lilSpewer_spewerColor] or EffectVariant.CREEP_GREEN
    if tData.Sewn_lilSpewer_isKingBabyTear ~= true then
        return
    end

    if tear.FrameCount % LilSpewer.Stats.KingBabyTearCreepSpawnRate == 0 then
        local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, creepVariant, 0, tear.Position, Globals.V0, familiar):ToEffect()

        -- Case just for yellow creep (as it doesn't exists as EffectVariant)
        if tData.Sewn_lilSpewer_spewerColor == LilSpewerColors.YELLOW then
            creep:SetColor(CColor(1, 1, 1, 1, 1, 1, 0), 0, 1, false, false)
        end

        creep.CollisionDamage = LilSpewer.Stats.KingBabyTearCreepDamage
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, LilSpewer.OnFamiliarUpdate, FamiliarVariant.LIL_SPEWER)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_LOSE_UPGRADE, LilSpewer.OnFamiliarLoseUpgrade, FamiliarVariant.LIL_SPEWER)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, LilSpewer.OnFamiliarUpgrade_Ultra, FamiliarVariant.LIL_SPEWER, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, LilSpewer.OnFamiliarUpdate_Ultra, FamiliarVariant.LIL_SPEWER, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_TEAR_UPDATE, LilSpewer.OnUltraKingBabyTearUpdate, FamiliarVariant.KING_BABY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_ULTRA_KING_BABY_SHOOT_TEAR, LilSpewer.OnUltraKingBabyShootTear, FamiliarVariant.LIL_SPEWER)