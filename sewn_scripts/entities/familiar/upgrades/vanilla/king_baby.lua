local FollowersHelper = require("sewn_scripts.lib.followers_helper")
local Globals = require("sewn_scripts.core.globals")
local Enums = require("sewn_scripts.core.enums")
local FindCloserNpc = require("sewn_scripts.helpers.find_closer_npc")
local CustomCallbacksHandler = require("sewn_scripts.callbacks.custom_callbacks_handler")
local CColor = require("sewn_scripts.helpers.ccolor")

local KingBaby = { }

KingBaby.Stats = {
    FireCooldown = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 24,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 20,
    },
    TearSpeed = 12
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.KING_BABY, CollectibleType.COLLECTIBLE_KING_BABY)

local function FireTear(familiar)
    local fData = familiar:GetData()
    local rng = familiar:GetDropRNG()
    local angle = rng:RandomFloat() * 360
    local distance = rng:RandomFloat() * 20 + 20
    local tear = Isaac.Spawn(2, 0, 0, familiar.Position + Vector.FromAngle(angle) * distance, Globals.V0, familiar):ToTear()
    local tData = tear:GetData()
    tear:AddTearFlags(TearFlags.TEAR_SPECTRAL)
    tData.Sewn_kingBaby_isSummonTear = true

    if Sewn_API:IsUltra(fData) then
        CustomCallbacksHandler:Evaluate(Enums.ModCallbacks.POST_ULTRA_KING_BABY_FIRE_TEAR, familiar, tear)
    end
end

function KingBaby:OnPlayStopped(familiar, sprite)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    if familiar.FireCooldown <= 0 then
        familiar.FireCooldown = KingBaby.Stats.FireCooldown[level]
        FireTear(familiar)
    end

    familiar.FireCooldown = familiar.FireCooldown - 1
end

function KingBaby:OnFamiliarTearUpdate(familiar, tear)
    local tData = tear:GetData()
    
    if tData.Sewn_kingBaby_isSummonTear ~= true then
        -- Not summon by King Baby
        return
    end

    local player = familiar.Player
	local frame = tear.FrameCount

    if frame <= 8 then
        local shootingDirection = player:GetShootingInput()

        if shootingDirection:LengthSquared() > 0.1 then
            tData.Sewn_kingBaby_lastAvailableDirection = shootingDirection
        end
    end

    if frame == 1 then
		tear.FallingSpeed = -10
		tear.FallingAcceleration = 0.2
		tear.Height = -15
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.WATER_RIPPLE, 0, tear.Position, Globals.V0, tear)
	elseif frame >= 5 and frame <= 7 then
		tear.FallingSpeed = 0
		tear.FallingAcceleration = 0
		tear.Height = -50
	elseif frame == 8 then
        local fData = familiar:GetData()
        local closerNpc = FindCloserNpc(familiar.Position)
		if closerNpc ~= nil then
			tear.Velocity = (closerNpc.Position - tear.Position):Normalized() * KingBaby.Stats.TearSpeed
		else
            local shootingDirection = tData.Sewn_kingBaby_lastAvailableDirection or player:GetShootingInput()
            local movementDirection = player.Velocity
			tear.Velocity = shootingDirection * KingBaby.Stats.TearSpeed + movementDirection
		end
        
        if Sewn_API:IsUltra(fData) then
            CustomCallbacksHandler:Evaluate(Enums.ModCallbacks.POST_ULTRA_KING_BABY_SHOOT_TEAR, familiar, tear, closerNpc)
        end

		tear.FallingSpeed = 2
	end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_PLAY_ANIM, KingBaby.OnPlayStopped, FamiliarVariant.KING_BABY, nil, "StoppedUp", "StoppedDown", "StoppedSide")
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_TEAR_UPDATE, KingBaby.OnFamiliarTearUpdate, FamiliarVariant.KING_BABY)



-- Non upgradable familiars but still compatible with King Baby :
-- They are here because they do not have their own file.

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_ULTRA_KING_BABY_FIRE_TEAR, function (_, familiar, kingBaby, tear)
    tear:SetColor(CColor(0.4, 0.97, 0.5), -1, 1, false, false)
    tear.TearFlags = tear.TearFlags | TearFlags.TEAR_POISON
    if tear.Variant ~= TearVariant.BOOGER then
        tear:ChangeVariant(TearVariant.BOOGER)
    end
end, FamiliarVariant.BOBS_BRAIN)

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_ULTRA_KING_BABY_FIRE_TEAR, function (_, familiar, kingBaby, tear)
    tear.CollisionDamage = tear.CollisionDamage * 1.25
    if tear.Variant == TearVariant.BLUE then
        tear:ChangeVariant(TearVariant.BONE)
    end
end, FamiliarVariant.JAW_BONE)

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_ULTRA_KING_BABY_FIRE_TEAR, function (_, familiar, kingBaby, tear)
    tear.CollisionDamage = tear.CollisionDamage - 0.75
    tear.Scale = tear.Scale * 0.85
    kingBaby.FireCooldown = kingBaby.FireCooldown - 7
end, FamiliarVariant.ISAACS_HEAD)