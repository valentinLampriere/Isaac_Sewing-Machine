sewingMachineMod.sewnFamiliars = {}
sewnFamiliars = sewingMachineMod.sewnFamiliars

require("sewn_scripts.embeddablecallbackhack")
require("sewn_scripts.apioverride")

local game = Game()
local v0 = Vector(0,0)

local ANIMATION_NAMES = {
    SPAWN = {"Spawn"},
    HIT = {"Hit"},
    SHOOT = {"FloatShootDown", "FloatShootUp", "FloatShootSide"},
    STOPPED = {"StoppedDown", "StoppedUp", "StoppedSide"},
    DASH = {"Dashing"},
    DASHSTOP = {"DashStop"},
    ATTACK = {"Attack Up", "Attack Down", "Attack Hori"}
}

local vanillaFollowers = {
	[FamiliarVariant.BROTHER_BOBBY] = true,
	[FamiliarVariant.DEMON_BABY] = true,
	[FamiliarVariant.LITTLE_CHUBBY] = true,
	[FamiliarVariant.LITTLE_GISH] = true,
	[FamiliarVariant.LITTLE_STEVEN] = true,
	[FamiliarVariant.ROBO_BABY] = true,
	[FamiliarVariant.SISTER_MAGGY] = true,
	[FamiliarVariant.GHOST_BABY] = true,
	[FamiliarVariant.HARLEQUIN_BABY] = true,
	[FamiliarVariant.RAINBOW_BABY] = true,
	[FamiliarVariant.ISAACS_HEAD] = true,
	[FamiliarVariant.BOMB_BAG] = true,
	[FamiliarVariant.SACK_OF_PENNIES] = true,
	[FamiliarVariant.LITTLE_CHAD] = true,
	[FamiliarVariant.RELIC] = true,
	[FamiliarVariant.HOLY_WATER] = true,
	[FamiliarVariant.KEY_PIECE_1] = true,
	[FamiliarVariant.KEY_PIECE_2] = true,
	[FamiliarVariant.KEY_FULL] = true,
	[FamiliarVariant.DEAD_CAT] = true,
	[FamiliarVariant.ONE_UP] = true,
	[FamiliarVariant.DRY_BABY] = true,
	[FamiliarVariant.JUICY_SACK] = true,
	[FamiliarVariant.ROTTEN_BABY] = true,
	[FamiliarVariant.HEADLESS_BABY] = true,
	[FamiliarVariant.MYSTERY_SACK] = true,
	[FamiliarVariant.LIL_BRIMSTONE] = true,
	[FamiliarVariant.MONGO_BABY] = true,
	[FamiliarVariant.INCUBUS] = true,
	[FamiliarVariant.FATES_REWARD] = true,
	[FamiliarVariant.LIL_CHEST] = true,
	[FamiliarVariant.CHARGED_BABY] = true,
	[FamiliarVariant.CENSER] = true,
	[FamiliarVariant.RUNE_BAG] = true,
	[FamiliarVariant.SERAPHIM] = true,
	[FamiliarVariant.FARTING_BABY] = true,
	[FamiliarVariant.LIL_LOKI] = true,
	[FamiliarVariant.MILK] = true,
	[FamiliarVariant.TONSIL] = true,
	[FamiliarVariant.BIG_CHUBBY] = true,
	[FamiliarVariant.DEPRESSION] = true,
	[FamiliarVariant.LIL_MONSTRO] = true,
	[FamiliarVariant.ACID_BABY] = true,
	[FamiliarVariant.KING_BABY] = true,
	[FamiliarVariant.SACK_OF_SACKS] = true,
	[FamiliarVariant.BUDDY_IN_A_BOX] = true,
	[FamiliarVariant.LIL_SPEWER] = true,
	[FamiliarVariant.HALLOWED_GROUND] = true
}

------------------------
-- Override functions --
------------------------

-- "AddToFollowers" and "RemoveFromFollowers" usefull for King Baby
local OldAddToFollowers = APIOverride.GetCurrentClassFunction(EntityFamiliar, "AddToFollowers")
APIOverride.OverrideClassFunction(EntityFamiliar, "AddToFollowers", function(fam)
    fam:GetData().Sewn_IsFollower = true
    OldAddToFollowers(fam)
end)
local OldRemoveFromFollowers = APIOverride.GetCurrentClassFunction(EntityFamiliar, "RemoveFromFollowers")
APIOverride.OverrideClassFunction(EntityFamiliar, "RemoveFromFollowers", function(fam)
    fam:GetData().Sewn_IsFollower = false
    OldRemoveFromFollowers(fam)
end)

------------------------------------------------------------
-- Prepare familiars upgrade, stats and custom behaviours --
------------------------------------------------------------

-- FIRE RATE
function sewnFamiliars:setTearRateBonus(familiar, bonus)
    local fData = familiar:GetData()
    fData.Sewn_tearRate_bonus = bonus
end
function sewnFamiliars:setFireRate(familiar, rate)
    local fData = familiar:GetData()
    fData.Sewn_tearRate_set = rate
end
function sewnFamiliars:getTearRateBonus(familiar)
    local fData = familiar:GetData()
    return fData.Sewn_tearRate_bonus or 0
end

-- DAMAGE UP (tear & lasers)
function sewnFamiliars:setDamageTearMultiplier(familiar, multiplier)
    local fData = familiar:GetData()
    fData.Sewn_damageTear_multiplier = multiplier
    sewnFamiliars:setTearSizeMultiplier(familiar, math.sqrt((multiplier/4)*3))
end

-- RANGE UP
function sewnFamiliars:setRangeBonusMultiplier(familiar, multiplier)
    local fData = familiar:GetData()
    fData.Sewn_range_multiplier = multiplier
end

-- SHOT SPEED UP
function sewnFamiliars:setShotSpeedBonusMultiplier(familiar, multiplier)
    local fData = familiar:GetData()
    fData.Sewn_shotSpeed_multiplier = multiplier
end

-- TEAR SIZE
function sewnFamiliars:setTearSizeMultiplier(familiar, multiplier)
    local fData = familiar:GetData()
    fData.Sewn_tearSize_multiplier = multiplier
end

-- TEAR FLAG
function sewnFamiliars:addTearFlag(familiar, newTearFlag, chance)
    local fData = familiar:GetData()
    if fData.Sewn_tearFlags == nil then
        fData.Sewn_tearFlags = 0
    end
    fData.Sewn_tearFlags_chance = chance
    fData.Sewn_tearFlags = fData.Sewn_tearFlags | newTearFlag
end
function sewnFamiliars:removeTearFlag(familiar, tearFlag)
    local fData = familiar:GetData()
    if fData.Sewn_tearFlags == nil then
        fData.Sewn_tearFlags = 0
    end
    fData.Sewn_tearFlags = fData.Sewn_tearFlags & ~tearFlag
end

-- TEAR VARIANT
function sewnFamiliars:changeTearVariant(familiar, tearVariant)
    local fData = familiar:GetData()
    fData.Sewn_tearVariant = tearVariant
end

-- SPRITE SCALE
function sewnFamiliars:spriteScaleMultiplier(familiar, multiplier)
    local fData = familiar:GetData()
    fData.Sewn_spriteScale_multiplier = multiplier
end

-- CUSTOM TEAR INIT
function sewnFamiliars:customFireInit(familiar, functionName)
    local fData = familiar:GetData()
    if fData.Sewn_custom_fireInit == nil then
        fData.Sewn_custom_fireInit = {}
    end
    table.insert(fData.Sewn_custom_fireInit, functionName)
end

-- CUSTOM TEAR COLLISION
function sewnFamiliars:customTearCollision(familiar, functionName)
    local fData = familiar:GetData()
    if fData.Sewn_custom_tearCollision == nil then
        fData.Sewn_custom_tearCollision = {}
    end
    table.insert(fData.Sewn_custom_tearCollision, functionName)
end

-- CUSTOM TEAR FALL
function sewnFamiliars:customTearFall(familiar, functionName)
    local fData = familiar:GetData()
    if fData.Sewn_custom_tearFall == nil then
        fData.Sewn_custom_tearFall = {}
    end
    table.insert(fData.Sewn_custom_tearFall, functionName)
end

-- CUSTOM ANIMATION - Used to check if a familiar spawn something
function sewnFamiliars:customAnimation(familiar, functionName, animation_s)
    local fData = familiar:GetData()
    if fData.Sewn_custom_animation == nil then
        fData.Sewn_custom_animation = {}
    end
    
    if animation_s == nil then
        fData.Sewn_custom_animation["Spawn"] = functionName
    elseif type(animation_s) == "table" then
        for _, anim in pairs(animation_s) do
            fData.Sewn_custom_animation[anim] = functionName
        end
    elseif type(animation_s) == "string" then
        fData.Sewn_custom_animation[animation_s] = functionName
    end
end

-- CUSTOM UPDATE
function sewnFamiliars:customUpdate(familiar, functionName)
    local fData = familiar:GetData()
    if fData.Sewn_custom_update == nil then
        fData.Sewn_custom_update = {}
    end
    table.insert(fData.Sewn_custom_update, functionName)
end

-- CUSTOM COLLISION
function sewnFamiliars:customCollision(familiar, functionName)
    local fData = familiar:GetData()
    if fData.Sewn_custom_collision == nil then
        fData.Sewn_custom_collision = {}
    end
    table.insert(fData.Sewn_custom_collision, functionName)
end

-- CUSTOM NEW ROOM
function sewnFamiliars:customNewRoom(familiar, functionName)
    local fData = familiar:GetData()
    if fData.Sewn_custom_newRoom == nil then
        fData.Sewn_custom_newRoom = {}
    end
    table.insert(fData.Sewn_custom_newRoom, functionName)
end

-- CUSTOM EVALUATE CACHE
function sewnFamiliars:customCache(familiar, functionName)
    local fData = familiar:GetData()
    if fData.Sewn_custom_cache == nil then
        fData.Sewn_custom_cache = {}
    end
    table.insert(fData.Sewn_custom_cache, functionName)
end

-- CUSTOM CLEAN AWARD
function sewnFamiliars:customCleanAward(familiar, functionName)
    local fData = familiar:GetData()
    if fData.Sewn_custom_cleanAward == nil then
        fData.Sewn_custom_cleanAward = {}
    end
    table.insert(fData.Sewn_custom_cleanAward, functionName)
end

-- CUSTOM PLAYER TAKE DAMAGE
function sewnFamiliars:customPlayerTakeDamage(familiar, functionName)
    local fData = familiar:GetData()
    if fData.Sewn_custom_playerTakeDamage == nil then
        fData.Sewn_custom_playerTakeDamage = {}
    end
    table.insert(fData.Sewn_custom_playerTakeDamage, functionName)
end

-- CUSTOM HIT ENEMY
function sewnFamiliars:customHitEnemy(familiar, functionName)
    local fData = familiar:GetData()
    if fData.Sewn_custom_hitEnemy == nil then
        fData.Sewn_custom_hitEnemy = {}
    end
    table.insert(fData.Sewn_custom_hitEnemy, functionName)
end
-- CUSTOM KILL ENEMY
function sewnFamiliars:customKillEnemy(familiar, functionName)
    local fData = familiar:GetData()
    if fData.Sewn_custom_killEnemy == nil then
        fData.Sewn_custom_killEnemy = {}
    end
    table.insert(fData.Sewn_custom_killEnemy, functionName)
end

-- Remove custom familiar datas
function sewingMachineMod:resetFamiliarData(familiar, keepValues)
    local fData = familiar:GetData()
    if keepValues == nil then keepValues = {} end
    for key, value in pairs(fData) do
        if type(key) == "string" and string.sub(key, 1, 4) == "Sewn" then
            local keepValue = false
            for _, value in pairs(keepValues) do
                if value == key then
                    keepValue = true
                end
            end
            if keepValue == false then
                if key ~= "Sewn_upgradeState" and key ~= "Sewn_Init" and key ~= "Sewn_collisionDamage" and key ~= "Sewn_upgradeFunction" and key ~= "Sewn_newRoomVisited" then
                    fData[key] = nil
                end
                if key == "Sewn_custom_cache" and familiar.Player then
                    familiar.Player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
                    familiar.Player:EvaluateItems()
                end
            end
        end
    end
end


function sewnFamiliars:familiarFollowTrail(familiar, position, forceChildLeash)
    if familiar == nil or familiar.Type ~= EntityType.ENTITY_FAMILIAR then
        return
    end
    if familiar.Player and (familiar.Player:HasTrinket(TrinketType.TRINKET_CHILD_LEASH) or forceChildLeash == true) and (familiar.Position-position):LengthSquared() > 9 then
        familiar:FollowPosition(position + (familiar.Position-position):Resized(3))
    elseif (familiar.Position-position):LengthSquared() > 625 then
        familiar:FollowPosition(position + (familiar.Position-position):Resized(25))
    else
        familiar:FollowPosition(familiar.Position)
    end
    familiar.Velocity = familiar.Velocity*1.9
end

function sewnFamiliars:shootTearsCircular(familiar, amountTears, tearVariant, position, velocity, dmg, flags, notFireFromFamiliar)
    local tearFired = {}
    local spawnerTear = familiar
    local player = familiar.Player
    tearVariant = tearVariant or TearVariant.BLOOD
    position = position or familiar.Position
    velocity = velocity or Vector(5, 5)
    if notFireFromFamiliar == true then
        spawnerTear = nil
    end
    local tearOffset = sewingMachineMod.rng:RandomInt(360)
    for i = 1, amountTears do
        local velo = Vector(5, 5)
        velo = velo:Rotated((360 / amountTears) * i + tearOffset)
        velo = velo:Rotated(tearOffset)
        local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, tearVariant, 0, position, velo, spawnerTear):ToTear()
        if dmg then
            tear.CollisionDamage = dmg
        end
        if flags then
            tear.TearFlags = tear.TearFlags | flags
        end
        sewnFamiliars:toBabyBenderTear(familiar, tear)
        
        table.insert(tearFired, tear)
    end
    return tearFired
end


function sewnFamiliars:burstTears(familiar, amountTears, damage, force, differentSize, tearVariant, tearFlags, position)
    local player = familiar.Player
    tearVariant = tearVariant or TearVariant.BLOOD
    tearFlags = tearFlags or 0
    position = position or familiar.Position
    differentSize = differentSize or false
    force = force or 5
    damage = damage or 3.5
    for i = 1, amountTears do
        local velocity = Vector(0, 0)
        velocity.X = sewingMachineMod.rng:RandomFloat() + sewingMachineMod.rng:RandomInt(force * 2) - force
        velocity.Y = sewingMachineMod.rng:RandomFloat() + sewingMachineMod.rng:RandomInt(force * 2) - force
        local t = Isaac.Spawn(EntityType.ENTITY_TEAR, tearVariant, 0, position, velocity, familiar):ToTear()
        sewnFamiliars:toBabyBenderTear(familiar, t)
        if differentSize == true then
            local sizeMulti = sewingMachineMod.rng:RandomFloat() * 0.4 + 0.7
            t.Scale = sizeMulti
        end
        t.TearFlags = tearFlags
        t.FallingSpeed = -18
        t.FallingAcceleration = 1.5
        t.CollisionDamage = damage
        sewnFamiliars:toBabyBenderTear(familiar, t)
    end
end

function sewnFamiliars:spawnBonesOrbitals(boneFamiliar, min, max, force)
    min = min or 1
    max = max or 1
    force = force or 15.0

    local amount = math.random(min, max)
    for i = 1, amount do
        local velo = Vector(math.random(-force, force), math.random(-force, force))
        local bone = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BONE_ORBITAL, 0, boneFamiliar.Position, v0, boneFamiliar)
        bone.Velocity = velo
    end
end

function sewnFamiliars:toBabyBenderTear(familiar, tear)
    local player = familiar.Player
    if player ~= nil and player:HasTrinket(TrinketType.TRINKET_BABY_BENDER) then
        tear.TearFlags = tear.TearFlags | TearFlags.TEAR_HOMING
        tear:SetColor(Color(0.4, 0.15, 0.38, 1, 55, 5, 95), -1, 2, false, false)
    end
end

function sewnFamiliars:spawnFromPool(familiar, itemPoolType)
    local itemFromPool = game:GetItemPool():GetCollectible(itemPoolType, true, game:GetSeeds():GetNextSeed())
    local pos = Isaac.GetFreeNearPosition(familiar.Position, 35)
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, itemFromPool, pos, v0, familiar.Player)
end

function sewnFamiliars:getDirectionFromAngle(angle)
    if angle == nil then return Direction.NO_DIRECTION end
    if angle > 45 and angle < 135 then
        return Direction.DOWN
    elseif angle > 135 and angle < 180 or angle > -180 and angle < -135 then
        return Direction.LEFT
    elseif angle > -135 and angle < -45 then
        return Direction.UP
    elseif angle > -45 and angle < 0 or angle > 0 and angle < 45 then
        return Direction.RIGHT
    end
    return Direction.NO_DIRECTION
end

-----------------------
-- Shooter Familiars --
-----------------------

-- BROTHER BOBBY
function sewnFamiliars:upBrotherBobby(familiar)
    local fData = familiar:GetData()
    if familiar.Variant == FamiliarVariant.BROTHER_BOBBY or (familiar.Variant == FamiliarVariant.MONGO_BABY and fData.Sewn_mongoCopy == FamiliarVariant.BROTHER_BOBBY) then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:setDamageTearMultiplier(familiar, 2)
        end
        if sewingMachineMod:isUltra(fData) then
            sewnFamiliars:setDamageTearMultiplier(familiar, 2.3)
            sewnFamiliars:setTearRateBonus(familiar, 8)
        end
    end
end

-- SISTER MAGGY
function sewnFamiliars:upSisterMaggy(familiar)
    local fData = familiar:GetData()
    if familiar.Variant == FamiliarVariant.SISTER_MAGGY or (familiar.Variant == FamiliarVariant.MONGO_BABY and fData.Sewn_mongoCopy == FamiliarVariant.SISTER_MAGGY) then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:setTearRateBonus(familiar, 15)
        end
        if sewingMachineMod:isUltra(fData) then
            sewnFamiliars:setTearRateBonus(familiar, 20)
            sewnFamiliars:setDamageTearMultiplier(familiar, 1.2)
        end
    end
end

-- GHOST BABY
function sewnFamiliars:upGhostBaby(familiar)
    local fData = familiar:GetData()
    
    if familiar.Variant == FamiliarVariant.GHOST_BABY or (familiar.Variant == FamiliarVariant.MONGO_BABY and fData.Sewn_mongoCopy == FamiliarVariant.GHOST_BABY) then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:addTearFlag(familiar, TearFlags.TEAR_PIERCING)
            sewnFamiliars:changeTearVariant(familiar, TearVariant.PUPULA)
        end
        if sewingMachineMod:isSuper(fData) then
            sewnFamiliars:setDamageTearMultiplier(familiar, 1.25)
            sewnFamiliars:setTearSizeMultiplier(familiar, 2)
        end
        if sewingMachineMod:isUltra(fData) then
            sewnFamiliars:setDamageTearMultiplier(familiar, 1.5)
            sewnFamiliars:setTearSizeMultiplier(familiar, 3)
        end
    end
end

-- ROBO BABY
function sewnFamiliars:upRoboBaby(familiar)
    local fData = familiar:GetData()
    if familiar.Variant == FamiliarVariant.ROBO_BABY or (familiar.Variant == FamiliarVariant.MONGO_BABY and fData.Sewn_mongoCopy == FamiliarVariant.ROBO_BABY) then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:setTearRateBonus(familiar, 10)
        end
        if sewingMachineMod:isUltra(fData) then
            sewnFamiliars:setTearRateBonus(familiar, 20)
        end
    end
end

-- LITTLE GISH
function sewnFamiliars:upLittleGish(familiar)
    local fData = familiar:GetData()
    
    if familiar.Variant == FamiliarVariant.LITTLE_GISH or (familiar.Variant == FamiliarVariant.MONGO_BABY and fData.Sewn_mongoCopy == FamiliarVariant.LITTLE_GISH) then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:setTearRateBonus(familiar, 3)
            sewnFamiliars:customFireInit(familiar, sewnFamiliars.custom_fireInit_littleGish)
            sewnFamiliars:customTearCollision(familiar, sewnFamiliars.custom_tearCollision_littleGish)
            sewnFamiliars:customTearFall(familiar, sewnFamiliars.custom_tearCollision_littleGish)
        end
        if sewingMachineMod:isUltra(fData) then
            sewnFamiliars:setTearRateBonus(familiar, 9)
        end
    end
end
function sewnFamiliars:custom_fireInit_littleGish(familiar, tear)  
    local fData = familiar:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        tear:GetData().Sewn_gish_creep = true
    end
end
function sewnFamiliars:custom_tearCollision_littleGish(familiar, tear, collider)    
    local fData = familiar:GetData()
    if tear:GetData().Sewn_gish_creep == true then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_BLACK, 0, tear.Position, v0, familiar):ToEffect()
            if sewingMachineMod:isUltra(fData) then
                creep.Size = creep.Size * 2
                creep.SpriteScale = creep.SpriteScale * 2
            end
        end
    end
end

-- SERAPHIM
function sewnFamiliars:upSeraphim(familiar)
    local fData = familiar:GetData()
    if familiar.Variant == FamiliarVariant.SERAPHIM then
        if sewingMachineMod:isSuper(fData) then
            sewnFamiliars:addTearFlag(familiar, TearFlags.TEAR_LIGHT_FROM_HEAVEN, 15)
        end
        if sewingMachineMod:isUltra(fData) then
            sewnFamiliars:addTearFlag(familiar, TearFlags.TEAR_LIGHT_FROM_HEAVEN, 25)
            sewnFamiliars:setTearRateBonus(familiar, 3)
        end
    end
end

-- HARLEQUIN BABY
function sewnFamiliars:upHarlequinBaby(familiar)
    local fData = familiar:GetData()
    if familiar.Variant == FamiliarVariant.HARLEQUIN_BABY or (familiar.Variant == FamiliarVariant.MONGO_BABY and fData.Sewn_mongoCopy == FamiliarVariant.HARLEQUIN_BABY) then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customFireInit(familiar, sewnFamiliars.custom_fireInit_harlequinBaby)
            sewnFamiliars:customUpdate(familiar, sewnFamiliars.custom_update_harlequinBaby)
        end
        if sewingMachineMod:isUltra(fData) then
            sewnFamiliars:setDamageTearMultiplier(familiar, 1.5)
            sewnFamiliars:setTearSizeMultiplier(familiar, 1.2)
        end
    end
end

function sewnFamiliars:custom_update_harlequinBaby(familiar)
    local fData = familiar:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        if familiar.FireCooldown == 1 then
            fData.Sewn_harlequin_isFirstTear = true
        end
    end
end
function sewnFamiliars:custom_fireInit_harlequinBaby(familiar, tear)
    local fData = familiar:GetData()
    local player = familiar.Player:ToPlayer()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        local velocity
        if fData.Sewn_harlequin_isFirstTear == nil or fData.Sewn_harlequin_isFirstTear then
            velocity = tear.Velocity:Rotated(10)
        else
            velocity = tear.Velocity:Rotated(-10)
        end
    
        local newTear = Isaac.Spawn(EntityType.ENTITY_TEAR, tear.Variant, tear.SubType, familiar.Position, velocity, familiar):ToTear()
        sewnFamiliars:toBabyBenderTear(familiar, newTear)
        newTear.Scale = tear.Scale
        newTear.CollisionDamage = tear.CollisionDamage
        
        fData.Sewn_harlequin_isFirstTear = false
    end
end

-- LIL LOKI
function sewnFamiliars:upLilLoki(familiar)
    local fData = familiar:GetData()
    if familiar.Variant == FamiliarVariant.LIL_LOKI then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customFireInit(familiar, sewnFamiliars.custom_fireInit_lilLoki)
            sewnFamiliars:customUpdate(familiar, sewnFamiliars.custom_update_lilLoki)
        end
        if sewingMachineMod:isUltra(fData) then
            sewnFamiliars:setDamageTearMultiplier(familiar, 1.5)
        end
    end
end
function sewnFamiliars:custom_update_lilLoki(familiar)
    local fData = familiar:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        if familiar.FireCooldown == 1 then
            fData.Sewn_lilLoki_isFirstTear = true
        end
    end
end
function sewnFamiliars:custom_fireInit_lilLoki(familiar, tear)
    local fData = familiar:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        if fData.Sewn_lilLoki_isFirstTear == nil or fData.Sewn_lilLoki_isFirstTear then
            local velocities = {Vector(8, -8), Vector(8, 8), Vector(-8, -8), Vector(-8, 8)}
            for i = 1, 4 do
                local velocity = velocities[i] + familiar.Player.Velocity
                local newTear = Isaac.Spawn(EntityType.ENTITY_TEAR, tear.Variant, tear.SubType, familiar.Position, velocity, familiar):ToTear()
                newTear:SetColor(Color(1,0,0,1,0,0,0), -1, 1, false, false)
                newTear.Scale = tear.Scale
                newTear.CollisionDamage = tear.CollisionDamage
                sewnFamiliars:toBabyBenderTear(familiar, newTear)
            end
            fData.Sewn_lilLoki_isFirstTear = false
        end
    end
end

-- BUDDY IN A BOX
function sewnFamiliars:upBuddyInABox(familiar)
    local fData = familiar:GetData()
    if familiar.Variant == FamiliarVariant.BUDDY_IN_A_BOX then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customFireInit(familiar, sewnFamiliars.custom_fireInit_BuddyInABox)
            sewnFamiliars:setTearRateBonus(familiar, 3)
        end
        if sewingMachineMod:isUltra(fData) then
            sewnFamiliars:setTearRateBonus(familiar, 6)
        end
    end
end
function sewnFamiliars:custom_fireInit_BuddyInABox(familiar, tear)
    local fData = familiar:GetData()
    local roll
    
    if fData.Sewn_temporaryTearFlag == nil then
        fData.Sewn_temporaryTearFlag = {}
    end
    for _, flag in ipairs(fData.Sewn_temporaryTearFlag) do
        sewnFamiliars:removeTearFlag(familiar, flag)
    end
    local nbFlags = 0
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        nbFlags = nbFlags + 1
    end
    if sewingMachineMod:isUltra(fData) then
        nbFlags = nbFlags + 1
    end
    for i = 1, nbFlags do
        roll = sewingMachineMod.rng:RandomInt(60)
        repeat
            roll = sewingMachineMod.rng:RandomInt(60)
        until 1<<roll ~= TearFlags.TEAR_EXPLOSIVE
        sewnFamiliars:addTearFlag(familiar, 1<<roll)
        
        table.insert(fData.Sewn_temporaryTearFlag, 1<<roll)
    end
end


-- RAINBOW BABY
function sewnFamiliars:upRainbowBaby(familiar)
    local fData = familiar:GetData()
    if familiar.Variant == FamiliarVariant.RAINBOW_BABY or (familiar.Variant == FamiliarVariant.MONGO_BABY and fData.Sewn_mongoCopy == FamiliarVariant.RAINBOW_BABY) then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:setTearRateBonus(familiar, 10)
        end
        if sewingMachineMod:isUltra(fData) then
            sewnFamiliars:setTearRateBonus(familiar, 20)
        end
    end
end

-- LITTLE STEVEN
function sewnFamiliars:upLittleSteven(familiar)
    local fData = familiar:GetData()
    if familiar.Variant == FamiliarVariant.LITTLE_STEVEN or (familiar.Variant == FamiliarVariant.MONGO_BABY and fData.Sewn_mongoCopy == FamiliarVariant.LITTLE_STEVEN) then
        if sewingMachineMod:isSuper(fData) then
            sewnFamiliars:setRangeBonusMultiplier(familiar, 1.5)
            sewnFamiliars:setShotSpeedBonusMultiplier(familiar, 0.8)
            sewnFamiliars:setDamageTearMultiplier(familiar, 1.5)
        end
        if sewingMachineMod:isUltra(fData) then
            sewnFamiliars:setRangeBonusMultiplier(familiar, 2)
            sewnFamiliars:setShotSpeedBonusMultiplier(familiar, 0.8)
            sewnFamiliars:setDamageTearMultiplier(familiar, 2)
            sewnFamiliars:setTearRateBonus(familiar, 8)
        end
    end
end

-- HEADLESS BABY
function sewnFamiliars:upHeadlessBaby(familiar)
    local fData = familiar:GetData()
    if familiar.Variant == FamiliarVariant.HEADLESS_BABY then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customUpdate(familiar, sewnFamiliars.custom_update_headlessBaby)
        end
    end
end
function sewnFamiliars:custom_update_headlessBaby(familiar)
    local fData = familiar:GetData()
    local player = familiar.Player
    local creepDamage = 2.5
    
    if sewingMachineMod:isUltra(fData) then
        if familiar.FireCooldown == 0 then
            if player:GetShootingInput():Length() > 0 then
                local nbTears = sewingMachineMod.rng:RandomInt(7) + 3
                sewnFamiliars:burstTears(familiar, nbTears)
                familiar.FireCooldown = 45
            end
        else
            familiar.FireCooldown = familiar.FireCooldown - 1
        end
        creepDamage = 3
    end
    
    for _, creep in pairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, -1, false, true)) do
        if creep.FrameCount == 0 and creep.SpawnerType == EntityType.ENTITY_FAMILIAR and creep.SpawnerVariant == FamiliarVariant.HEADLESS_BABY then
            local cData = creep:GetData()
            if not cData.Sewn_creepIsScaled then
                creep.Size = creep.Size * 1.5
                creep.SpriteScale = creep.SpriteScale * 1.5
                creep.CollisionDamage = creepDamage
                cData.Sewn_creepIsScaled = true
            end
        end
    end
end


-- ROBO BABY 2.0
function sewnFamiliars:upRoboBaby2(familiar)
    local fData = familiar:GetData()
    if familiar.Variant == FamiliarVariant.ROBO_BABY_2 then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customUpdate(familiar, sewnFamiliars.custom_update_roboBaby2)
            sewnFamiliars:customNewRoom(familiar, sewnFamiliars.custom_newRoom_roboBaby2)
        end
    end
end
function sewnFamiliars:custom_update_roboBaby2(familiar)
    local fData = familiar:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        if math.abs(familiar.Velocity.X) > 0.5 or math.abs(familiar.Velocity.Y) > 0.5 then
            if fData.Sewn_roboBaby2_continiousLaser == nil then
                fData.Sewn_roboBaby2_continiousLaser = Isaac.Spawn(EntityType.ENTITY_LASER, 2, 0, familiar.Position, v0, familiar):ToLaser()
            end
        else
            if fData.Sewn_roboBaby2_continiousLaser ~= nil then
                fData.Sewn_roboBaby2_continiousLaser:Remove()
                fData.Sewn_roboBaby2_continiousLaser = nil
            end
        end
        if fData.Sewn_roboBaby2_continiousLaser ~= nil then
            local angle = math.atan(familiar.Velocity.Y, familiar.Velocity.X) * 180 / math.pi;
            
            fData.Sewn_roboBaby2_continiousLaser.Angle = angle
            fData.Sewn_roboBaby2_continiousLaser.CollisionDamage = 0.33
            fData.Sewn_roboBaby2_continiousLaser.MaxDistance = 100
            fData.Sewn_roboBaby2_continiousLaser.Position = familiar.Position
            fData.Sewn_roboBaby2_continiousLaser.PositionOffset = Vector(-5, -30)
        end
    end
    if sewingMachineMod:isUltra(fData) then
        if fData.Sewn_roboBaby2_followCooldown == nil then
            fData.Sewn_roboBaby2_followCooldown = 0
        end
        if fData.Sewn_roboBaby2_followCooldown > 0 then
            if fData.Sewn_roboBaby2_followCooldown > 150 then
                local npcs = Isaac.FindInRadius(familiar.Position, 150, EntityPartition.ENEMY)
                
                for i, npc in pairs(npcs) do
                    if npcs[i]:IsVulnerableEnemy() then
                        sewnFamiliars:familiarFollowTrail(familiar, npcs[i].Position)
                        break
                    end
                end
            end
            fData.Sewn_roboBaby2_followCooldown = fData.Sewn_roboBaby2_followCooldown - 1
        else
            fData.Sewn_roboBaby2_followCooldown = sewingMachineMod.rng:RandomInt(300) + 150
        end
    end
end
function sewnFamiliars:custom_newRoom_roboBaby2(familiar, room)
    local fData = familiar:GetData()
    if familiar.Variant == FamiliarVariant.ROBO_BABY_2 then
        if sewingMachineMod:isSuper(fData) then
            fData.Sewn_roboBaby2_continiousLaser = nil
        end
    end
end


-- FATE'S REWARD
function sewnFamiliars:upFatesReward(familiar)
    local fData = familiar:GetData()
    if familiar.Variant == FamiliarVariant.FATES_REWARD then
        if sewingMachineMod:isSuper(fData) then
            sewnFamiliars:setDamageTearMultiplier(familiar, 1.2)
            sewnFamiliars:setTearRateBonus(familiar, 15)
        end
        if sewingMachineMod:isUltra(fData) then
            local rate = familiar.Player.MaxFireDelay + math.floor(familiar.Player.MaxFireDelay / 2)
            if rate > 45 then
                rate = 45
            end
            sewnFamiliars:setDamageTearMultiplier(familiar, 1.2)
            sewnFamiliars:setFireRate(familiar, rate)
            sewnFamiliars:customCache(familiar, sewnFamiliars.custom_cache_fatesReward)
        end
    end
end
function sewnFamiliars:custom_cache_fatesReward(familiar, cacheFlag)
    local fData = familiar:GetData()
    if sewingMachineMod:isUltra(fData) then
        local rate = familiar.Player.MaxFireDelay + math.floor(familiar.Player.MaxFireDelay / 2)
        if rate > 45 then
            rate = 45
        end
        if cacheFlag == CacheFlag.CACHE_FIREDELAY then
            sewnFamiliars:setFireRate(familiar, rate)
        end
    end
end


-- MONGO BABY
function sewnFamiliars:upMongoBaby(mongoBaby)
    local fData = mongoBaby:GetData()
    if mongoBaby.Variant == FamiliarVariant.MONGO_BABY then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customFireInit(mongoBaby, sewnFamiliars.custom_fireInit_mongoBaby)
            sewnFamiliars:customAnimation(mongoBaby, sewnFamiliars.custom_animation_mongoBaby, ANIMATION_NAMES.SHOOT)
        end
    end
end
function sewnFamiliars:custom_animation_mongoBaby(mongoBaby)
    mongoBaby:GetData().Sewn_mongoCopy = FamiliarVariant.ROTTEN_BABY
    sewnFamiliars:custom_animation_rottenBaby(mongoBaby)
end
function sewnFamiliars:custom_fireInit_mongoBaby(mongoBaby, tear)
    local fData = mongoBaby:GetData()
    sewnFamiliars:mongoBaby_reset(mongoBaby)
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        local nbTears = 0
        
        -- Count tears for Harlequin Baby        
        for _, t in pairs(Isaac.FindByType(EntityType.ENTITY_TEAR, -1, -1, false, false)) do
            t = t:ToTear()
            if t.SpawnerType == EntityType.ENTITY_FAMILIAR and t.SpawnerVariant == FamiliarVariant.MONGO_BABY then
                if t.FrameCount <= 1 then
                    nbTears = nbTears + 1
                end
            end
        end
        
        -- If he fire several tears, means he copy Harlequin Baby
        if nbTears > 1 then
            fData.Sewn_mongoCopy = FamiliarVariant.HARLEQUIN_BABY
            sewnFamiliars:upHarlequinBaby(mongoBaby)
            sewnFamiliars:setTearRateBonus(mongoBaby, sewnFamiliars:getTearRateBonus(mongoBaby) -10)
        elseif tear.TearFlags & TearFlags.TEAR_GISH == TearFlags.TEAR_GISH then
            fData.Sewn_mongoCopy = FamiliarVariant.LITTLE_GISH
            sewnFamiliars:upLittleGish(mongoBaby)
        elseif tear.TearFlags & TearFlags.TEAR_SPECTRAL == TearFlags.TEAR_SPECTRAL then
            fData.Sewn_mongoCopy = FamiliarVariant.GHOST_BABY
            sewnFamiliars:upGhostBaby(mongoBaby)
        elseif tear.TearFlags & TearFlags.TEAR_HOMING == TearFlags.TEAR_HOMING then
            fData.Sewn_mongoCopy = FamiliarVariant.LITTLE_STEVEN
            sewnFamiliars:upLittleSteven(mongoBaby)
        else
            tear.CollisionDamage = tear.CollisionDamage + 3
            tear.Scale = tear.Scale + 0.1
        end
        
        -- reduce tear rate bonus because mongo baby tear rate is good enough, no need to increase it to much
        if fData.Sewn_tearRate_bonus ~= nil then
            sewnFamiliars:setTearRateBonus(mongoBaby, math.floor(fData.Sewn_tearRate_bonus / 3))
        end
    end
end
function sewnFamiliars:mongoBaby_reset(mongoBaby)
    local fData = mongoBaby:GetData()
    mongoBaby.Variant = FamiliarVariant.MONGO_BABY
    fData.Sewn_tearFlags = nil
    fData.Sewn_tearVariant = nil
    fData.Sewn_tearRate_bonus = nil
    fData.Sewn_damageTear_multiplier = nil
    fData.Sewn_tearSize_multiplier = nil
    fData.Sewn_range_multiplier = nil
    fData.Sewn_shotSpeed_multiplier = nil
    fData.Sewn_mongoCopy = nil
    fData.Sewn_custom_tearCollision = nil
    --Remove additional custom tear init function
    table.remove(fData.Sewn_custom_fireInit, 2)
end


-- LIL BRIMSTONE
function sewnFamiliars:upLilBrimstone(familiar)
    local fData = familiar:GetData()
    if familiar.Variant == FamiliarVariant.LIL_BRIMSTONE then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:setDamageTearMultiplier(familiar, 1.33)
        end
        if sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customFireInit(familiar, sewnFamiliars.custom_fireInit_LilBrimstone)
        end
    end
end
function sewnFamiliars:custom_fireInit_LilBrimstone(familiar, laser)
    local fData = familiar:GetData()
    laser = laser:ToLaser()
    if sewingMachineMod:isUltra(fData) then
        laser:SetTimeout(laser.Timeout * 2)
    end
end

-- LIL MONSTRO
function sewnFamiliars:upLilMonstro(familiar)
    local fData = familiar:GetData()
    if familiar.Variant == FamiliarVariant.LIL_MONSTRO then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customFireInit(familiar, sewnFamiliars.custom_fireInit_lilMonstro)
        end
    end
end
function sewnFamiliars:custom_fireInit_lilMonstro(familiar, tear)
    local fData = familiar:GetData()
    -- Have a chance to fire additional tears (~= amount of tears x 1.5)
    if sewingMachineMod:isUltra(fData) then
        local rollNewTear = sewingMachineMod.rng:RandomInt(101)
        if rollNewTear < 35 then
            local velocity = Vector(sewingMachineMod.rng:RandomFloat() - 0.5, sewingMachineMod.rng:RandomFloat() - 0.5) + tear.Velocity
            
            local newTear = Isaac.Spawn(EntityType.ENTITY_TEAR, tear.Variant, tear.SubType, familiar.Position, velocity, familiar):ToTear()
            sewnFamiliars:toBabyBenderTear(familiar, newTear)
            
            newTear.FallingSpeed = tear.FallingSpeed
            newTear.FallingAcceleration = tear.FallingAcceleration
        end
    end
    -- Have a chance to fire teeth
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        local rollTooth = sewingMachineMod.rng:RandomInt(101)
        if rollTooth < 10 then
            if tear.Variant ~= TearVariant.TOOTH then
                tear:ChangeVariant(TearVariant.TOOTH)
            end
            tear.CollisionDamage = tear.CollisionDamage * 3.2
        end
    end
end

-- DEMON BABY
function sewnFamiliars:upDemonBaby(familiar)
    local fData = familiar:GetData()
    if familiar.Variant == FamiliarVariant.DEMON_BABY then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            fData.Sewn_demonBaby_lastDirection = nil
            fData.Sewn_demonBaby_flipX = false
            sewnFamiliars:addTearFlag(familiar, TearFlags.TEAR_SPECTRAL)
            sewnFamiliars:customUpdate(familiar, sewnFamiliars.custom_update_demonBaby)
        end
    end
end
function sewnFamiliars:custom_update_demonBaby(familiar)
    local fData = familiar:GetData()
    local sprite = familiar:GetSprite()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        
        local range = 160
        
        if sewingMachineMod:isUltra(fData) then
            range = 200
        end
        
        -- Removing tears from Demon Baby
        for _, tear in pairs(Isaac.FindByType(EntityType.ENTITY_TEAR, TearVariant.BLOOD, -1, false, false)) do
            if tear.SpawnerType == EntityType.ENTITY_FAMILIAR and tear.SpawnerVariant == FamiliarVariant.DEMON_BABY then
                if tear.Position:DistanceSquared(familiar.Position) < 5^2 then
                    if tear.FrameCount == 0 then
                        tear:Remove()
                    end
                end
            end
        end
        for _, npc in pairs(Isaac.FindInRadius(familiar.Position, range, EntityPartition.ENEMY)) do
            if npc:IsVulnerableEnemy() then
                if familiar.FireCooldown == 0 then
                    local velo = (npc.Position - familiar.Position)
                    velo = velo:Normalized() * 8
                    local newTear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLOOD, 0, familiar.Position, velo, familiar):ToTear()
                    newTear.CollisionDamage = 3
                    newTear.Parent = familiar
                    familiar.FireCooldown = 10
                    sewnFamiliars:toBabyBenderTear(familiar, newTear)
                    
                    
                    local angle = (npc.Position - familiar.Position):GetAngleDegrees()
                    local direction = sewnFamiliars:getDirectionFromAngle(angle)
                    if direction == Direction.DOWN then
                        fData.Sewn_demonBaby_lastDirection = ANIMATION_NAMES.SHOOT[1]
                        fData.Sewn_demonBaby_flipX = false
                    elseif direction == Direction.LEFT then
                        fData.Sewn_demonBaby_lastDirection = ANIMATION_NAMES.SHOOT[3]
                        fData.Sewn_demonBaby_flipX = true
                    elseif direction == Direction.UP then
                        fData.Sewn_demonBaby_lastDirection = ANIMATION_NAMES.SHOOT[2]
                        fData.Sewn_demonBaby_flipX = false
                    elseif direction == Direction.RIGHT then
                        fData.Sewn_demonBaby_lastDirection = ANIMATION_NAMES.SHOOT[3]
                        fData.Sewn_demonBaby_flipX = false
                    end
                end
                
                if fData.Sewn_demonBaby_lastDirection ~= nil and familiar.FireCooldown > 0 then
                    sprite:Play(fData.Sewn_demonBaby_lastDirection, true)
                    sprite.FlipX = fData.Sewn_demonBaby_flipX
                    break
                end
            end
        end
        if familiar.FireCooldown > 0 then
            familiar.FireCooldown = familiar.FireCooldown - 1
        end
    end
end

-- ABEL
function sewnFamiliars:upAbel(familiar)
    local fData = familiar:GetData()
    if familiar.Variant == FamiliarVariant.ABEL then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:setDamageTearMultiplier(familiar, 1.75)
            familiar.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
            sewnFamiliars:customCollision(familiar, sewnFamiliars.custom_collision_abel)
        end
        if sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customNewRoom(familiar, sewnFamiliars.custom_newRoom_abel)
        end
    end
end
function sewnFamiliars:custom_collision_abel(familiar, collider)
    local fData = familiar:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        if collider.Type == EntityType.ENTITY_PROJECTILE then
            collider:Die()
        end
    end
    if sewingMachineMod:isUltra(fData) then
        if fData.Sewn_custom_abel_enterRoomFrame == nil or fData.Sewn_custom_abel_enterRoomFrame + 30 < game:GetFrameCount() then
            familiar.CollisionDamage = fData.Sewn_collisionDamage + math.sqrt(familiar.Position:Distance(familiar.Player.Position)) / 2
        end
    end
end
function sewnFamiliars:custom_newRoom_abel(familiar, room)
    local fData = familiar:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        fData.Sewn_custom_abel_enterRoomFrame = game:GetFrameCount()
    else
        familiar.CollisionDamage = fData.Sewn_collisionDamage
    end
end

-- PAPA FLY
function sewnFamiliars:upPapaFly(papaFly)
    local fData = papaFly:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        sewnFamiliars:customCollision(papaFly, sewnFamiliars.custom_collision_papaFly)
        if sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customAnimation(papaFly, sewnFamiliars.custom_animation_papaFly, "Attack")
        end
    end
end
function sewnFamiliars:custom_collision_papaFly(papaFly, collider)
    local fData = papaFly:GetData()
    if collider.Type == EntityType.ENTITY_PROJECTILE then
        local roll = rng:RandomInt(101)
        local chance = 20
        if sewingMachineMod:isUltra(fData) then
            chance = 33
        end
        if roll < chance then
            -- Spawn a Nugget Pooter
            papaFly.Player:UseActiveItem(CollectibleType.COLLECTIBLE_BROWN_NUGGET, false, false, false, false)
            
            -- Set the position to the Papa Fly position
            for _, nuggetPooter in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BROWN_NUGGET_POOTER, -1, false, false)) do
                if nuggetPooter.FrameCount == 0 then
                    nuggetPooter.Position = papaFly.Position
                end
            end
        end
        
        collider:Die()
    end
end
function sewnFamiliars:custom_animation_papaFly(papaFly)
    local fData = papaFly:GetData()
    if papaFly:GetSprite():GetFrame() > 5 then
        for _, tear in pairs(Isaac.FindInRadius(papaFly.Position, 5, EntityPartition.TEAR)) do
            tear = tear:ToTear()
            if sewingMachineMod:isUltra(fData) then
                tear.FallingAcceleration = -0.05
            end
            
            if tear.FrameCount == 1 and tear.SpawnerType == EntityType.ENTITY_FAMILIAR and tear.SpawnerVariant == FamiliarVariant.PAPA_FLY and tear:GetData().Sewn_papaFly_isAdditionalTear == nil then
                for i = 1, 2 do
                    local rotate = 15
                    if i == 2 then
                        rotate = -15
                    end
                    local newTear = Isaac.Spawn(EntityType.ENTITY_TEAR, tear.Variant, tear.SubType, tear.Position, tear.Velocity:Rotated(rotate), papaFly):ToTear()
                    newTear:GetData().Sewn_papaFly_isAdditionalTear = true
                    newTear.CollisionDamage = tear.CollisionDamage
                    newTear.Height = tear.Height
                    newTear.FallingSpeed = tear.FallingSpeed
                    newTear.FallingAcceleration = tear.FallingAcceleration
                end
            end
        end
    end
end

-------------------------
-- ORBITALS FAMILIARS --
-------------------------

-- SACRIFICIAL DAGGER
function sewnFamiliars:upSacrificialDagger(sacrificialDagger)
    local fData = sacrificialDagger:GetData()
    if sacrificialDagger.Variant == FamiliarVariant.SACRIFICIAL_DAGGER then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customCollision(sacrificialDagger, sewnFamiliars.custom_collision_sacrificialDagger)
            if sewingMachineMod:isUltra(fData) then
                sacrificialDagger.CollisionDamage = fData.Sewn_collisionDamage + 3
            end
        else
            sacrificialDagger.CollisionDamage = fData.Sewn_collisionDamage
        end
    end
end
function sewnFamiliars:custom_collision_sacrificialDagger(sacrificialDagger, collider)
    local fData = sacrificialDagger:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        if collider:IsVulnerableEnemy() and not collider:IsBoss() then
            collider:AddEntityFlags(EntityFlag.FLAG_BLEED_OUT)
        end
    end
end

-- GUARDIAN ANGEL
function sewnFamiliars:upGuardianAngel(guardianAngel)
    local fData = guardianAngel:GetData()
    if guardianAngel.Variant == FamiliarVariant.GUARDIAN_ANGEL then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            guardianAngel.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
            sewnFamiliars:customUpdate(guardianAngel, sewnFamiliars.custom_update_guardianAngel)
            sewnFamiliars:customCollision(guardianAngel, sewnFamiliars.custom_collision_guardianAngel)
            sewnFamiliars:customNewRoom(guardianAngel, sewnFamiliars.custom_newRoom_guardianAngel)
            fData.Sewn_guardianAngel_state = 0
            fData.Sewn_guardianAngel_blockTimer = 0
            fData.Sewn_guardianAngel_collideTear = {}
        else
            fData.Sewn_guardianAngel_state = 0
            guardianAngel.CollisionDamage = fData.Sewn_collisionDamage
            guardianAngel:SetColor(Color(1,1,1,1,0,0,0), -1, 1, false, false)
        end
    end
end
function sewnFamiliars:custom_newRoom_guardianAngel(guardianAngel, room)
    local fData = guardianAngel:GetData()
    fData.Sewn_guardianAngel_collideTear = {}
end
function sewnFamiliars:custom_update_guardianAngel(guardianAngel)
    local fData = guardianAngel:GetData()
    for _, tear in pairs(Isaac.FindInRadius(guardianAngel.Position, guardianAngel.Size, EntityPartition.TEAR)) do
        if fData.Sewn_guardianAngel_collideTear[GetPtrHash(tear)] == nil then
            tear.CollisionDamage = tear.CollisionDamage + (tear.CollisionDamage / 5) * fData.Sewn_guardianAngel_state
            fData.Sewn_guardianAngel_collideTear[GetPtrHash(tear)] = true
            
            local cOffset = 25 * fData.Sewn_guardianAngel_state
            tear:SetColor(Color(1,1,1,1,cOffset,cOffset,cOffset), -1, 1, false, false)
        end
    end
end
function sewnFamiliars:custom_collision_guardianAngel(guardianAngel, collider)
    local fData = guardianAngel:GetData()
    if collider.Type == EntityType.ENTITY_PROJECTILE and fData.Sewn_guardianAngel_blockTimer + 5 < game:GetFrameCount() then
            
        fData.Sewn_guardianAngel_blockTimer = game:GetFrameCount()
        
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            fData.Sewn_guardianAngel_state = fData.Sewn_guardianAngel_state + 1
            
            if fData.Sewn_guardianAngel_state >= 4 then
                fData.Sewn_guardianAngel_state = 0
            end
            
            local rOffset = 50 * fData.Sewn_guardianAngel_state
            local gOffset = 10  * fData.Sewn_guardianAngel_state
            guardianAngel:SetColor(Color(1,1,1,1,rOffset,gOffset,0), -1, 1, false, false)
        end
        if sewingMachineMod:isUltra(fData) then
            rollTear = sewingMachineMod.rng:RandomInt(5)
            if rollTear == 0 then
                local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, 0, 0, collider.Position, -collider.Velocity, guardianAngel):ToTear()
                tear.TearFlags =  tear.TearFlags| TearFlags.TEAR_HOMING
                tear.CollisionDamage = 5
                tear.Scale = 1.4
                tear:SetColor(Color(0.2,0.2,0.1,1,180,180,180), -1, 1, false, false)
            end
        end
    end
end

-- SWORN PROTECTOR
function sewnFamiliars:upSwornProtector(swornProtector)
    local fData = swornProtector:GetData()
    if swornProtector.Variant == FamiliarVariant.SWORN_PROTECTOR then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            swornProtector.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
            sewnFamiliars:customCollision(swornProtector, sewnFamiliars.custom_collision_swornProtector)
            fData.Sewn_swornProtector_laserState = 0
            fData.Sewn_swornProtector_nbProjectileBlockedSinceLastDrop = 0
            fData.Sewn_swornProtector_blockTimer = 0
        else
            fData.Sewn_swornProtector_laserState = 0
            swornProtector:SetColor(Color(1,1,1,1,0,0,0), -1, 1, false, false)
        end
    end
end
function sewnFamiliars:custom_collision_swornProtector(swornProtector, collider)
    local fData = swornProtector:GetData()
    if collider.Type == EntityType.ENTITY_PROJECTILE and fData.Sewn_swornProtector_blockTimer + 15 < game:GetFrameCount() then -- If it's a projectile AND last projectile touch was 15 frame backward
        
        fData.Sewn_swornProtector_blockTimer = game:GetFrameCount()
        
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            rollSoulHeartDrop = sewingMachineMod.rng:RandomInt(20)
            if rollSoulHeartDrop == 0 and fData.Sewn_swornProtector_nbProjectileBlockedSinceLastDrop >= 10 then
                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_HALF_SOUL, swornProtector.Position, v0, swornProtector)
                fData.Sewn_swornProtector_nbProjectileBlockedSinceLastDrop = 0
            end
            fData.Sewn_swornProtector_nbProjectileBlockedSinceLastDrop = fData.Sewn_swornProtector_nbProjectileBlockedSinceLastDrop + 1
        end
        if sewingMachineMod:isUltra(fData) then
            
            fData.Sewn_swornProtector_laserState = fData.Sewn_swornProtector_laserState + 1
                
            if fData.Sewn_swornProtector_laserState >= 6 then
                local angle = collider.Velocity:GetAngleDegrees() - 180
                local offsetLasers = 0
                if sewingMachineMod.rng:RandomInt(2) == 0 then
                    offsetLasers = 45
                end
                    
                for i = 1, 4 do
                    -- Laser variant = 8 -> Lite Light laser
                    local laser = EntityLaser.ShootAngle(8, swornProtector.Position + Vector(0, -20), 90 * i + offsetLasers, 4, v0, swornProtector):ToLaser()
                    laser.Radius = 30
                    sewnFamiliars:toBabyBenderTear(swornProtector, laser)
                end
                fData.Sewn_swornProtector_laserState = 0
            end
            
            local rOffset = 5 * fData.Sewn_swornProtector_laserState
            local bOffset = 15  * fData.Sewn_swornProtector_laserState
            swornProtector:SetColor(Color(1,1,1,1,rOffset,0,bOffset), -1, 1, false, false)
        end
    end
end

-- BLOODSHOT EYE
function sewnFamiliars:upBloodshotEye(bloodshotEye)
    local fData = bloodshotEye:GetData()
    if bloodshotEye.Variant == FamiliarVariant.BLOODSHOT_EYE then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customUpdate(bloodshotEye, sewnFamiliars.custom_update_bloodshotEye)
        end
    end
end
function sewnFamiliars:custom_update_bloodshotEye(bloodshotEye)
    local fData = bloodshotEye:GetData()
    for _, tear in pairs(Isaac.FindInRadius(bloodshotEye.Position, bloodshotEye.Size, EntityPartition.TEAR)) do
        tear = tear:ToTear()
        if tear ~= nil and tear.FrameCount == 1 and tear.SpawnerType == EntityType.ENTITY_FAMILIAR and tear.SpawnerVariant == FamiliarVariant.BLOODSHOT_EYE then
            tear.CollisionDamage = 5
            tear.Scale = 1.06
            if sewingMachineMod:isSuper(fData) then
                if tear:GetData().Sewn_bloodshotEye_additionalTear ~= true then
                    for i = 1, 2 do
                        local velo
                        if i == 1 then
                            velo = tear.Velocity:Rotated(-25)
                        else
                            velo = tear.Velocity:Rotated(25)
                        end
                        local addTear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLOOD, 0, tear.Position, velo, bloodshotEye):ToTear()
                        sewnFamiliars:toBabyBenderTear(bloodshotEye, addTear)
                        addTear:GetData().Sewn_bloodshotEye_additionalTear = true
                    end
                end
            elseif sewingMachineMod:isUltra(fData) then
                local laser = EntityLaser.ShootAngle(1, bloodshotEye.Position, tear.Velocity:GetAngleDegrees(), 7, Vector(0,-20), bloodshotEye)
                sewnFamiliars:toBabyBenderTear(bloodshotEye, laser)
                if bloodshotEye.Player.Position.Y > bloodshotEye.Position.Y then
                    laser.DepthOffset = -1
                else
                    laser.DepthOffset = 1
                end
                laser:SetTimeout(4)
                laser.CollisionDamage = 3
                tear:Remove()
            end
        end
    end
end

-- ANGELIC PRISM
function sewnFamiliars:upAngelicPrism(angelicPrism)
    local fData = angelicPrism:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        angelicPrism:AddToOrbit(2)
        sewnFamiliars:customUpdate(angelicPrism, sewnFamiliars.custom_update_angelicPrism)
        sewnFamiliars:customNewRoom(angelicPrism, sewnFamiliars.custom_newRoom_angelicPrism)
        fData.Sewn_angelicPrism_collideTear = {}
    end
end
function sewnFamiliars:custom_newRoom_angelicPrism(angelicPrism, room)
    local fData = angelicPrism:GetData()
    fData.Sewn_angelicPrism_collideTear = {}
end
function sewnFamiliars:custom_update_angelicPrism(angelicPrism)
    local fData = angelicPrism:GetData()
    for _, tear in pairs(Isaac.FindInRadius(angelicPrism.Position, angelicPrism.Size + 10, EntityPartition.TEAR)) do
        if fData.Sewn_angelicPrism_collideTear[GetPtrHash(tear)] == nil then
            tear = tear:ToTear()
            
            if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
                tear.TearFlags = tear.TearFlags | TearFlags.TEAR_SPECTRAL
                if sewingMachineMod:isUltra(fData) then
                    if tear.Variant == TearVariant.BLUE then
                        tear:ChangeVariant(TearVariant.CUPID_BLUE)
                    elseif tear.Variant == TearVariant.BLOOD then
                        tear:ChangeVariant(TearVariant.CUPID_BLOOD)
                    end
                    tear.TearFlags = tear.TearFlags | TearFlags.TEAR_PIERCING
                    tear.TearFlags = tear.TearFlags | TearFlags.TEAR_HOMING
                end
            end
            fData.Sewn_angelicPrism_collideTear[GetPtrHash(tear)] = true
        end
    end
end

function sewnFamiliars:upMarshmallow(marshmallow)
    local fData = marshmallow:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        sewnFamiliars:customFireInit(marshmallow, sewnFamiliars.custom_fireInit_marshmallow)
        if sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customCleanAward(marshmallow, sewnFamiliars.custom_cleanAward_marshmallow)
        end
    end
end
function sewnFamiliars:custom_fireInit_marshmallow(marshmallow, tear)
    if tear:GetData().Sewn_marshmallow_additionalTear == true then
        return
    end
    local data = {FAMILIAR = marshmallow, TEAR = tear}
    sewingMachineMod:delayFunction(sewnFamiliars.marshmallow_copyTear, 1, data)
end
function sewnFamiliars:marshmallow_copyTear(data)
    local marshmallow = data.FAMILIAR
    local tear = data.TEAR
    for i = 1, 2 do
        local velo
        if i == 1 then
            velo = tear.Velocity:Rotated(-15)
        else
            velo = tear.Velocity:Rotated(15)
        end
        
        local addTear = Isaac.Spawn(EntityType.ENTITY_TEAR, tear.Variant, 0, tear.Position, velo, marshmallow):ToTear()
        addTear.TearFlags = tear.TearFlags
        addTear.CollisionDamage = tear.CollisionDamage
        addTear.Scale = tear.Scale
        addTear:SetColor(tear:GetColor(), -1, 10, false, false)
        sewnFamiliars:toBabyBenderTear(marshmallow, addTear)
        tear:GetData().Sewn_marshmallow_additionalTear = true
    end
end
function sewnFamiliars:marshmallow_upgradeState(marshmallow, state)
    local sprite = marshmallow:GetSprite()
    if state == 0 then
		marshmallow.State = 0
		sprite:Play("Normal", false)
	elseif state == 1 then
		marshmallow.State = 1
		sprite:Play("Fire", false)
	elseif state == 2 then
		marshmallow.State = 2
		sprite:Play("FireRed", false)
	elseif state == 3 then
		marshmallow.State = 3
		sprite:Play("FireBlue", false)
	elseif state == 4 then
		marshmallow.State = 4
		sprite:Play("FirePurple", false)
	end
end
function sewnFamiliars:custom_cleanAward_marshmallow(marshmallow)
    local roll = sewingMachineMod.rng:RandomInt(100) + 1
    if roll < 30 then
        if marshmallow.State < 4 then
            sewnFamiliars:marshmallow_upgradeState(marshmallow, marshmallow.State + 1)
        end
    end
end

-------------------------
-- THROWABLE FAMILIARS --
-------------------------

-- BOB'S BRAIN
function sewnFamiliars:upBobsBrain(bobsBrain)
    local fData = bobsBrain:GetData()
    if bobsBrain.Variant == FamiliarVariant.BOBS_BRAIN then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customUpdate(bobsBrain, sewnFamiliars.custom_update_bobsBrain)
        end
    end
end
function sewnFamiliars:bobsBrain_getBack(bobsBrain)
    local fData = bobsBrain:GetData()
    local sprite = bobsBrain:GetSprite()
    bobsBrain.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ENEMIES
    -- Remove Slowing effect
    fData.Sewn_custom_bobsBrain_stickNpc:ClearEntityFlags(EntityFlag.FLAG_SLOW)
    fData.Sewn_custom_bobsBrain_stickNpc = nil
    fData.Sewn_custom_bobsBrain_stickDistance = nil
    fData.Sewn_custom_bobsBrain_stickFrame = nil
    bobsBrain.FireCooldown = 0
    
    sprite:Play("Float")
    sprite.PlaybackSpeed = 1
end
function sewnFamiliars:custom_update_bobsBrain(bobsBrain)
    local fData = bobsBrain:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then 
        -- When it explodes
        if bobsBrain.State == 1 then
            local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_GREEN, 0, bobsBrain.Position, v0, bobsBrain):ToEffect()
            creep.Size = 3
            creep.SpriteScale = Vector(3, 3)
            creep.Timeout = 50
            creep:SetColor(Color(0, 0, 0, 1, 0, 0, 25), -1, 0, false, false)
            
            -- hide the crown
            sewingMachineMod:hideCrown(bobsBrain, true)
        end
        if bobsBrain.FireCooldown > 30 then
            -- show the crown
            sewingMachineMod:hideCrown(bobsBrain, false)
        end
    end
    
    if sewingMachineMod:isUltra(fData) then
        --Remove bob's brain collision so it do no more hit enemies
        bobsBrain.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
        local sprite = bobsBrain:GetSprite()
        -- If the brain has been thrown (and it is not sticked to an enemy)
        if bobsBrain.FireCooldown == -1 and fData.Sewn_custom_bobsBrain_stickNpc == nil then
            local npcs = Isaac.FindInRadius(bobsBrain.Position, bobsBrain.Size - 5, EntityPartition.ENEMY)
            for _, npc in pairs(npcs) do
                if npc:IsVulnerableEnemy() then
                    fData.Sewn_custom_bobsBrain_stickNpc = npc
                    fData.Sewn_custom_bobsBrain_stickDistance = bobsBrain.Position - npc.Position
                    fData.Sewn_custom_bobsBrain_stickFrame = game:GetFrameCount()
                    sprite:Play("Stick")
                    
                    npc:AddEntityFlags(EntityFlag.FLAG_SLOW)
                end
            end
        end
        if fData.Sewn_custom_bobsBrain_stickNpc ~= nil then
            bobsBrain.Velocity = Vector(0, 0)
            bobsBrain.Position = fData.Sewn_custom_bobsBrain_stickNpc.Position + fData.Sewn_custom_bobsBrain_stickDistance
            if fData.Sewn_custom_bobsBrain_stickFrame + 30 < game:GetFrameCount() then
                sprite.PlaybackSpeed = 1.5
                if fData.Sewn_custom_bobsBrain_stickFrame + 60 < game:GetFrameCount() then
                    sprite.PlaybackSpeed = 2
                    if fData.Sewn_custom_bobsBrain_stickFrame + 90 < game:GetFrameCount() then
                        -- Add velocity, so it move against the enemy to explode
                        bobsBrain:AddVelocity(-fData.Sewn_custom_bobsBrain_stickDistance)
                        sewnFamiliars:bobsBrain_getBack(bobsBrain)
                    end
                end
            end
            
            -- If the enemy where the brain sticks is dead before it explodes, or if the enemy jumps
            if fData.Sewn_custom_bobsBrain_stickNpc and (fData.Sewn_custom_bobsBrain_stickNpc:IsDead() or fData.Sewn_custom_bobsBrain_stickNpc.EntityCollisionClass == EntityCollisionClass.ENTCOLL_NONE) then
                sewnFamiliars:bobsBrain_getBack(bobsBrain)
            end
        end
    end
end

-- LIL GURDY
function sewnFamiliars:upLilGurdy(lilGurdy)
    local fData = lilGurdy:GetData()
    if lilGurdy.Variant == FamiliarVariant.LIL_GURDY then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customAnimation(lilGurdy, sewnFamiliars.custom_animationDashStop_lilGurdy, ANIMATION_NAMES.DASHSTOP)
        end
        if sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customAnimation(lilGurdy, sewnFamiliars.custom_animationDash_lilGurdy, ANIMATION_NAMES.DASH)
        end
    end
end
function sewnFamiliars:custom_lilGurdy_shootTears(lilGurdy)
    local nbTears = sewingMachineMod.rng:RandomInt(8) + 2
    sewnFamiliars:shootTearsCircular(lilGurdy, nbTears, nil, nil, nil, 5, TearFlags.TEAR_SPECTRAL)
end
function sewnFamiliars:custom_animationDashStop_lilGurdy(lilGurdy)
    local fData = lilGurdy:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        if lilGurdy:GetSprite():GetFrame() == 0 then
            sewnFamiliars:custom_lilGurdy_shootTears(lilGurdy)
            sewingMachineMod:delayFunction(sewnFamiliars.custom_lilGurdy_shootTears, 15, lilGurdy)
            sewingMachineMod:delayFunction(sewnFamiliars.custom_lilGurdy_shootTears, 25, lilGurdy)
        end
    end
end
function sewnFamiliars:custom_animationDash_lilGurdy(lilGurdy)
    local fData = lilGurdy:GetData()
    if sewingMachineMod:isUltra(fData) then
        local creepPerFrame = 2
        if lilGurdy.Velocity:Length() < 20 then
            creepPerFrame = 5
            if lilGurdy.Velocity:Length() < 10 then
                creepPerFrame = 8
            end
        end
        if lilGurdy.FrameCount % creepPerFrame == 0 then
            local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, lilGurdy.Position, v0, lilGurdy)
            creep.CollisionDamage = 1
        end
    end
end

-- JAW BONE
function sewnFamiliars:upJawBone(jawBone)
    local fData = jawBone:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        fData.Sewn_jawBone_colliderCooldown = {}
        sewnFamiliars:customUpdate(jawBone, sewnFamiliars.custom_update_jawBone)
        sewnFamiliars:customCollision(jawBone, sewnFamiliars.custom_collision_jawBone)
        sewnFamiliars:customNewRoom(jawBone, sewnFamiliars.custom_newRoom_jawBone)
        
        jawBone.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL

        if sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customCache(jawBone, sewnFamiliars.custom_cache_jawBone)
            jawBone.CollisionDamage = jawBone.Player.Damage * 3 + 3.5
        end
    end
end
function sewnFamiliars:custom_cache_jawBone(jawBone, cacheFlag)
    if cacheFlag == CacheFlag.CACHE_DAMAGE then
        jawBone.CollisionDamage = jawBone.Player.Damage * 3 + 2
    end
end
function sewnFamiliars:custom_newRoom_jawBone(jawBone, room)
    local fData = jawBone:GetData()
    fData.Sewn_jawBone_colliderCooldown = {}
end
function sewnFamiliars:custom_collision_jawBone(jawBone, collider)
    local fData = jawBone:GetData()
    if jawBone:GetSprite():IsPlaying("Throw") and collider:IsVulnerableEnemy() then
        if collider.HitPoints - jawBone.CollisionDamage <= 0 then
            if fData.Sewn_jawBone_colliderCooldown[GetPtrHash(collider)] == nil or fData.Sewn_jawBone_colliderCooldown[GetPtrHash(collider)] + 60 < jawBone.FrameCount then
                sewnFamiliars:spawnBonesOrbitals(jawBone, 0, 2)
                fData.Sewn_jawBone_colliderCooldown[GetPtrHash(collider)] = jawBone.FrameCount
            end
        end
    end
end

-- LITTLE CHUBBY
function sewnFamiliars:upLittleChubby(littleChubby)
    local fData = littleChubby:GetData()
    
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        sewnFamiliars:customUpdate(littleChubby, sewnFamiliars.custom_update_littleChubby)
        fData.Sewn_custom_littleChubby_lastStickFrame = 0
    end
end
function sewnFamiliars:custom_update_littleChubby(littleChubby)
    local fData = littleChubby:GetData()
    
    if littleChubby.FireCooldown < -1 then
        littleChubby.FireCooldown = 15
    end
    
    if sewingMachineMod:isUltra(fData) then
        -- If little chubby has been thrown AND it do not already stick to an enemy
        if littleChubby.FireCooldown == -1 and fData.Sewn_custom_littleChubby_stickNpc == nil then
            for _, npc in pairs(Isaac.FindInRadius(littleChubby.Position, littleChubby.Size - 2, EntityPartition.ENEMY)) do
                if npc:IsVulnerableEnemy() and fData.Sewn_custom_littleChubby_lastStickFrame + 15 < game:GetFrameCount() then
                    fData.Sewn_custom_littleChubby_stickNpc = npc
                    fData.Sewn_custom_littleChubby_stickDistance = littleChubby.Position - npc.Position
                    fData.Sewn_custom_littleChubby_stickFrame = game:GetFrameCount()
                    fData.Sewn_custom_littleChubby_initialVelocity = littleChubby.Velocity
                end
            end
        end

        -- if little chubby is stick to an enemy
        if fData.Sewn_custom_littleChubby_stickNpc ~= nil then
            -- Really small velocity, so little chubby does not move, but keep his direction
            littleChubby.Velocity = fData.Sewn_custom_littleChubby_initialVelocity * 0.01
            littleChubby.Position = fData.Sewn_custom_littleChubby_stickNpc.Position + fData.Sewn_custom_littleChubby_stickDistance
            
            -- Un-Stick the enemy after half a second, or if the enemy died
            if fData.Sewn_custom_littleChubby_stickFrame + 15 < game:GetFrameCount() or
               fData.Sewn_custom_littleChubby_stickNpc and (fData.Sewn_custom_littleChubby_stickNpc:IsDead() or fData.Sewn_custom_littleChubby_stickNpc.EntityCollisionClass == EntityCollisionClass.ENTCOLL_NONE) then
                fData.Sewn_custom_littleChubby_stickNpc = nil
                
                -- Continue his path
                littleChubby.FireCooldown = -1
                littleChubby.Velocity = fData.Sewn_custom_littleChubby_initialVelocity
                fData.Sewn_custom_littleChubby_lastStickFrame = game:GetFrameCount()
            end
        end
    end
end

-----------------------
-- SPAWNER FAMILIARS --
-----------------------

function sewnFamiliars:familiarIsSpawningFlySpider(familiar, isFly, functionName, removeFlySpider)
    local fData = familiar:GetData()
    local flySpider_variant
    if isFly then
        flySpider_variant = FamiliarVariant.BLUE_FLY
    else
        flySpider_variant = FamiliarVariant.BLUE_SPIDER
    end
    -- Loop through familiar, check for close blue spider
    for _, f in pairs(Isaac.FindInRadius(familiar.Position, 5, EntityPartition.FAMILIAR)) do
        if f.Variant == flySpider_variant and f.FrameCount == 1 then
            if functionName ~= nil then
                local d = {}
                d.customFunction = functionName
                d:customFunction(familiar)
            end
            if removeFlySpider == true then
                f:Remove()
            end
        end
    end
end
function sewnFamiliars:familiarSpawnAdditionalFly(familiar, amountFlies)
    if amountFlies == nil then
        amountFlies = 1
    end
    
    for _, blueFly in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, -1, false, false)) do
        if blueFly:GetData().Sewn_flySpiderParentIndex == GetPtrHash(familiar) then
            return
        end
    end
    
    for i = 1, amountFlies do
        local newBlueFly = familiar.Player:AddBlueFlies(1, familiar.Position, nil)
        newBlueFly:GetData().Sewn_flySpiderParentIndex = GetPtrHash(familiar)
    end
end
function sewnFamiliars:familiarSpawnAdditionalSpider(familiar, amountSpiders)
    if amountSpiders == nil then
        amountSpiders = 1
    end
    
    for _, blueSpider in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_SPIDER, -1, false, false)) do
        if blueSpider:GetData().Sewn_flySpiderParentIndex == GetPtrHash(familiar) then
            return
        end
    end
    
    for i = 1, amountSpiders do
        local newBlueSpider = familiar.Player:AddBlueSpider(familiar.Position)
        newBlueSpider:GetData().Sewn_flySpiderParentIndex = GetPtrHash(familiar)
    end
end
function sewnFamiliars:familiarSpawnAdditionalLocust(familiar, amountLocust, spawnSameLocusts, locustType)
    local rollLocust = sewingMachineMod.rng:RandomInt(5) + 1
    if locustType then
        rollLocust = locustType
    end
    if amountLocust == nil then
        amountLocust = 1
    end
    
    for _, blueFly in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, -1, false, false)) do
        if blueFly:GetData().Sewn_flySpiderParentIndex == GetPtrHash(familiar) then
            return
        end
    end
    
    for i = 1, amountLocust do
        local nb = 1
        if spawnSameLocusts == false and locustType == nil then
            rollLocust = sewingMachineMod.rng:RandomInt(5) + 1
        end
        if rollLocust == 5 then -- Spawn 2 conquest locusts
            nb = 2
        end
        for i = 1, nb do
            local newLocust = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, rollLocust, familiar.Position, v0, familiar)
            newLocust:GetData().Sewn_flySpiderParentIndex = GetPtrHash(familiar)
        end
    end
end


-- ROTTEN BABY
function sewnFamiliars:upRottenBaby(rottenBaby)
    local fData = rottenBaby:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        sewnFamiliars:customAnimation(rottenBaby, sewnFamiliars.custom_animation_rottenBaby, ANIMATION_NAMES.SHOOT)
    end
end
function sewnFamiliars:custom_animation_rottenBaby(rottenBaby)
    local fData = rottenBaby:GetData()
    
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        sewnFamiliars:familiarIsSpawningFlySpider(rottenBaby, true, sewnFamiliars.familiarSpawnAdditionalSpider)
    end
    if sewingMachineMod:isUltra(fData) then
        sewnFamiliars:familiarIsSpawningFlySpider(rottenBaby, true, sewnFamiliars.familiarSpawnAdditionalLocust)
    end
end

-- JUICY SACK
function sewnFamiliars:upJuicySack(juicySack)
    local fData = juicySack:GetData()
    if juicySack.Variant == FamiliarVariant.JUICY_SACK then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customUpdate(juicySack, sewnFamiliars.custom_update_juicySack)
        end
    end
end
function sewnFamiliars:custom_update_juicySack(juicySack)
    local fData = juicySack:GetData()
    local player = juicySack.Player
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        for _, creep in pairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_WHITE, -1, false, true)) do
            if creep.FrameCount == 0 and creep.SpawnerType == EntityType.ENTITY_FAMILIAR and creep.SpawnerVariant == FamiliarVariant.JUICY_SACK then
                local cData = creep:GetData()
                if not cData.Sewn_creepIsScaled then
                    creep.Size = creep.Size * 1.75
                    creep.SpriteScale = creep.SpriteScale * 1.75
                    cData.Sewn_creepIsScaled = true
                end
            end
        end
    end
    if sewingMachineMod:isUltra(fData) then
        if juicySack.FireCooldown == 0 then
            if player:GetShootingInput():Length() > 0 then
                local nbTears = sewingMachineMod.rng:RandomInt(5) + 1
                sewnFamiliars:burstTears(juicySack, nbTears, nil, 4, false, TearVariant.EGG, TearFlags.TEAR_EGG)
                juicySack.FireCooldown = sewingMachineMod.rng:RandomInt(30) + 30
            end
        else
            juicySack.FireCooldown = juicySack.FireCooldown - 1
        end
    end
end

-- SISSY LONGLEGS
function sewnFamiliars:upSissyLonglegs(sissyLonglegs)
    local fData = sissyLonglegs:GetData()
    if sissyLonglegs.Variant == FamiliarVariant.SISSY_LONGLEGS then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customAnimation(sissyLonglegs, sewnFamiliars.custom_animation_sissyLonglegs, ANIMATION_NAMES.SPAWN)
        end
    end
end
function sewnFamiliars:sissyLonglegs_spawnAdditionalSpider(sissyLonglegs)
    local amount = 1
    if sewingMachineMod:isUltra(sissyLonglegs:GetData()) then
        amount = 2
    end
    sewnFamiliars:familiarSpawnAdditionalSpider(sissyLonglegs, amount)
end
function sewnFamiliars:custom_animation_sissyLonglegs(sissyLonglegs)
    local fData = sissyLonglegs:GetData()
    
    if not sewingMachineMod:isSuper(fData) and not sewingMachineMod:isUltra(fData) then
        return
    end
    
    sewnFamiliars:familiarIsSpawningFlySpider(sissyLonglegs, false, sewnFamiliars.sissyLonglegs_spawnAdditionalSpider)
end

-- LITTLE C.H.A.D
function sewnFamiliars:upLittleChad(chad)
    local fData = chad:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        sewnFamiliars:customAnimation(chad, sewnFamiliars.custom_animation_littleChad, ANIMATION_NAMES.SPAWN)
    end
end
function sewnFamiliars:custom_animation_littleChad(chad)
    local fData = chad:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        for _, half_heart in pairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_HALF, false, true)) do
            half_heart = half_heart:ToPickup()
            if half_heart.FrameCount == 2 and half_heart.SpawnerType == EntityType.ENTITY_FAMILIAR and half_heart.SpawnerVariant == FamiliarVariant.LITTLE_CHAD then
                local rollHeart = sewingMachineMod.rng:RandomInt(101)
                local heartFullChance = 33
                local halfSoulHeartChance = 0
                if sewingMachineMod:isUltra(fData) then
                    halfSoulHeartChance = heartFullChance
                end
                if rollHeart < heartFullChance then
                    half_heart:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_FULL, false)
                elseif rollHeart < heartFullChance + halfSoulHeartChance then
                    half_heart:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_HALF_SOUL, false)
                end
            end
        end
    end
end

-- BOMB BAG
function sewnFamiliars:upBombBag(bombBag)
    local fData = bombBag:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        sewnFamiliars:customAnimation(bombBag, sewnFamiliars.custom_animation_bombBag, ANIMATION_NAMES.SPAWN)
        fData.Sewn_bombBag_itemSpawned = 0
    end
end
function sewnFamiliars:custom_animation_bombBag(bombBag)
    local fData = bombBag:GetData()
    for _, bomb in pairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, -1, false, true)) do
        if bomb.FrameCount == 1 and bomb.SpawnerType == EntityType.ENTITY_FAMILIAR and bomb.SpawnerVariant == FamiliarVariant.BOMB_BAG then
            bomb = bomb:ToPickup()
            local roll = sewingMachineMod.rng:RandomInt(100) + 1
            
            local goldenChance = 2
            local doubleChance = 10
            
            if sewingMachineMod:isUltra(fData) then
                goldenChance = 4
                doubleChance = 20
            end
            
            if sewingMachineMod:isUltra(fData) and roll > 90 + fData.Sewn_bombBag_itemSpawned then -- Spawn a bomb item from the BOMB BUM pool
                sewnFamiliars:spawnFromPool(bombBag, ItemPoolType.POOL_BOMB_BUM)
                bomb:Remove()
                fData.Sewn_bombBag_itemSpawned = fData.Sewn_bombBag_itemSpawned + 1
            elseif roll < goldenChance then -- Higher chance to spawn a golden bomb
                bomb:Morph(bomb.Type, bomb.Variant, BombSubType.BOMB_GOLDEN, true)
            elseif roll < doubleChance then -- Higher chance to spawn a double pack bomb
                bomb:Morph(bomb.Type, bomb.Variant, BombSubType.BOMB_DOUBLEPACK, true)
            elseif bomb.SubType == BombSubType.BOMB_TROLL then -- Remove troll bombs
                bomb:Morph(bomb.Type, bomb.Variant, BombSubType.BOMB_NORMAL, true)
            elseif bomb.SubType == BombSubType.BOMB_SUPERTROLL then -- Remove super troll bombs
                bomb:Morph(bomb.Type, bomb.Variant, BombSubType.BOMB_DOUBLEPACK, true)
            end
        end
    end
end

-- SACK OF PENNIES
function sewnFamiliars:upSackOfPennies(sackOfPennies)
    local fData = sackOfPennies:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        sewnFamiliars:customAnimation(sackOfPennies, sewnFamiliars.custom_animation_sackOfPennies, ANIMATION_NAMES.SPAWN)
        fData.Sewn_sackOfPennies_itemSpawned = 0
        fData.Sewn_sackOfPennies_trinkets = {TrinketType.TRINKET_SWALLOWED_PENNY, TrinketType.TRINKET_BUTT_PENNY, TrinketType.TRINKET_COUNTERFEIT_PENNY, TrinketType.TRINKET_BLOODY_PENNY, TrinketType.TRINKET_BURNT_PENNY, TrinketType.TRINKET_PAY_TO_WIN, TrinketType.TRINKET_SILVER_DOLLAR, TrinketType.TRINKET_FLAT_PENNY, TrinketType.TRINKET_ROTTEN_PENNY}
        if sewingMachineMod:isUltra(fData) then
            fData.Sewn_sackOfPennies_items = {{ID = CollectibleType.COLLECTIBLE_DOLLAR, WEIGHT = 1}, {ID = CollectibleType.COLLECTIBLE_3_DOLLAR_BILL, WEIGHT = 3}, {ID = CollectibleType.COLLECTIBLE_QUARTER, WEIGHT = 2}, {ID = CollectibleType.COLLECTIBLE_PAGEANT_BOY, WEIGHT = 4}, {ID = CollectibleType.COLLECTIBLE_DADS_LOST_COIN, WEIGHT = 5}, {ID = CollectibleType.COLLECTIBLE_CROOKED_PENNY, WEIGHT = 4}, {ID = CollectibleType.COLLECTIBLE_EYE_OF_GREED, WEIGHT = 4}, {ID = CollectibleType.COLLECTIBLE_MIDAS_TOUCH, WEIGHT = 3}, {ID = CollectibleType.COLLECTIBLE_MONEY_IS_POWER, WEIGHT = 4}, {ID = CollectibleType.COLLECTIBLE_WOODEN_NICKEL, WEIGHT = 4}}
        end
    end
end
function sewnFamiliars:sackOfPennies_rollItem(sackOfPennies)
    local fData = sackOfPennies:GetData()
    local amount = 0
    local roll
    for _, data in pairs(fData.Sewn_sackOfPennies_items) do
        amount = amount + data.WEIGHT
    end
    roll = sewingMachineMod.rng:RandomInt(amount)
    
    local counter = 0
    for i, item in pairs(fData.Sewn_sackOfPennies_items) do
        if counter <= roll and roll < counter + item.WEIGHT then
            local id = item.ID
            table.remove(fData.Sewn_sackOfPennies_items, i)
            return id
        end
        counter = counter + item.WEIGHT
    end
    
    return -1
end
function sewnFamiliars:custom_animation_sackOfPennies(sackOfPennies)
    local fData = sackOfPennies:GetData()
    for _, coin in pairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, -1, false, true)) do
        if coin.FrameCount == 1 and coin.SpawnerType == EntityType.ENTITY_FAMILIAR and coin.SpawnerVariant == FamiliarVariant.SACK_OF_PENNIES then
            coin = coin:ToPickup()
            local roll = sewingMachineMod.rng:RandomInt(100) + 1
            local dimeChance = 2
            local nickelChance = 6
            local luckyPennyChance = 15
            local doublePennyChance = 20
            local trinketChance = 95
            
            if sewingMachineMod:isUltra(fData) then
                dimeChance = 4
                nickelChance = 10
                luckyPennyChance = 20
                doublePennyChance = 25
                trinketChance = 90
            end
            
            if sewingMachineMod:isUltra(fData) and #fData.Sewn_sackOfPennies_items > 0 and roll > 97 + fData.Sewn_sackOfPennies_itemSpawned then -- Spawn an item from the PENNY pool
                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, sewnFamiliars:sackOfPennies_rollItem(sackOfPennies), sackOfPennies.Position, v0, sackOfPennies)
                coin:Remove()
                fData.Sewn_sackOfPennies_itemSpawned = fData.Sewn_sackOfPennies_itemSpawned + 1
            elseif roll > trinketChance and #fData.Sewn_sackOfPennies_trinkets > 0 then -- Spawn a trinket
                local rollTrinket = sewingMachineMod.rng:RandomInt(#fData.Sewn_sackOfPennies_trinkets) + 1
                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, fData.Sewn_sackOfPennies_trinkets[rollTrinket], sackOfPennies.Position, v0, sackOfPennies)
                coin:Remove()
                table.remove(fData.Sewn_sackOfPennies_trinkets, rollTrinket)
            elseif roll < dimeChance then -- Higher chance to spawn a dime
                coin:Morph(coin.Type, coin.Variant, CoinSubType.COIN_DIME, true)
            elseif roll < nickelChance and not coin.SubType == CoinSubType.COIN_DIME then -- Higher chance to spawn a nickel
                coin:Morph(coin.Type, coin.Variant, CoinSubType.COIN_NICKEL, true)
            elseif roll < luckyPennyChance and not coin.SubType == CoinSubType.COIN_DIME and not coin.SubType == CoinSubType.COIN_NICKEL then -- Higher chance to spawn a lucky penny
                coin:Morph(coin.Type, coin.Variant, CoinSubType.COIN_LUCKYPENNY, true)
            elseif roll < doublePennyChance and coin.SubType == CoinSubType.COIN_PENNY then -- Higher chance to spawn a double penny
                coin:Morph(coin.Type, coin.Variant, CoinSubType.COIN_DOUBLEPACK, true)
            end
        end
    end
end

-- THE RELIC
function sewnFamiliars:upTheRelic(theRelic)
    local fData = theRelic:GetData()
    sewnFamiliars:customCleanAward(theRelic, sewnFamiliars.custom_cleanAward_theRelic)
    if sewingMachineMod:isUltra(fData) then
        sewnFamiliars:customAnimation(theRelic, sewnFamiliars.custom_animation_theRelic, ANIMATION_NAMES.SPAWN)
    end
end
function sewnFamiliars:custom_cleanAward_theRelic(theRelic)
    if theRelic.RoomClearCount % 3 == 0 and theRelic.Player then
        if not theRelic.Player:HasFullHearts() then
            local heartEffect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 0, theRelic.Position-Vector(0, 50), v0, nil)
            theRelic.Player:AddHearts(1)
        end
    end
end
function sewnFamiliars:custom_animation_theRelic(theRelic)
    if theRelic:GetSprite():GetFrame() == 0 then
        local roll = sewingMachineMod.rng:RandomInt(100)
        local pos = sewingMachineMod.currentRoom:FindFreePickupSpawnPosition(theRelic.Position, 0, true)
        if roll < 33 then
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_HALF_SOUL, pos, v0, theRelic)
        elseif roll < 50 then
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_SOUL, pos, v0, theRelic)
        end
    end
end

-----------------------
-- OTHERS FAMILIARS --
-----------------------

-- FARTING BABY
function sewnFamiliars:upFartingBaby(fartingBaby)
    local fData = fartingBaby:GetData()
    if fartingBaby.Variant == FamiliarVariant.FARTING_BABY then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customUpdate(fartingBaby, sewnFamiliars.custom_update_fartingBaby)
        end
    end
end
function sewnFamiliars:custom_update_fartingBaby(fartingBaby)
    local fData = fartingBaby:GetData()
    if sewingMachineMod.currentRoom:IsClear() then
        return
    end
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        if fartingBaby.FrameCount < 5 then
            return
        end
        if fData.Sewn_custom_fartingBaby_randomFartCooldown == nil or fData.Sewn_custom_fartingBaby_randomFartCooldown == 0 then
            local rollMax = 3
            local minCooldown = 250
            if sewingMachineMod:isUltra(fData) then
                minCooldown = 150
                rollMax = 4
            end
            if fData.Sewn_custom_fartingBaby_randomFartCooldown == 0 then
                local rollFart = sewingMachineMod.rng:RandomInt(rollMax)
                if rollFart == 0 then
                    game:Fart(fartingBaby.Position, 75, fartingBaby.Player, 1, 0)
                elseif rollFart == 1 then
                    game:CharmFart(fartingBaby.Position, 75, fartingBaby.Player)
                elseif rollFart == 2 then
                    game:ButterBeanFart(fartingBaby.Position, 75, fartingBaby.Player, true)
                elseif rollFart == 3 then
                    -- Spawn a Burning fart
                    Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.FART, 75, fartingBaby.Position, v0, fartingBaby)
                end
            end
            fData.Sewn_custom_fartingBaby_randomFartCooldown = sewingMachineMod.rng:RandomInt(minCooldown * 1.5) + minCooldown
        else
            fData.Sewn_custom_fartingBaby_randomFartCooldown = fData.Sewn_custom_fartingBaby_randomFartCooldown - 1
        end
    end
end

-- CENSER
function sewnFamiliars:upCenser(censer)
    local fData = censer:GetData()
    if censer.Variant == FamiliarVariant.CENSER then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            fData.Sewn_custom_censer_dazedCooldown = sewingMachineMod.rng:RandomInt(600) + 60
            fData.Sewn_custom_censer_freezeCooldown = sewingMachineMod.rng:RandomInt(600) + 60
            sewnFamiliars:customUpdate(censer, sewnFamiliars.custom_update_censer)
        end
    end
end
function sewnFamiliars:custom_update_censer(censer)
    local fData = censer:GetData()
    
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        if fData.Sewn_custom_censer_dazedCooldown <= 0 or fData.Sewn_custom_censer_freezeCooldown <= 0 then
            local npcs = Isaac.FindInRadius(censer.Position, 150, EntityPartition.ENEMY)
            if #npcs > 0 then
                local amount = math.floor(#npcs / 7) + 1
                for i = 1, amount do
                    local randomNPC = npcs[sewingMachineMod.rng:RandomInt(#npcs) + 1]:ToNPC()
                    if randomNPC:IsVulnerableEnemy() then
                        if fData.Sewn_custom_censer_dazedCooldown <= 0 then
                            npcs[sewingMachineMod.rng:RandomInt(#npcs) + 1]:AddConfusion(EntityRef(censer), math.random(60, 190), true)
                        end
                        if fData.Sewn_custom_censer_freezeCooldown <= 0 then
                            npcs[sewingMachineMod.rng:RandomInt(#npcs) + 1]:AddFreeze(EntityRef(censer), math.random(60, 120))
                        end
                    end
                end
            end
            fData.Sewn_custom_censer_dazedCooldown = sewingMachineMod.rng:RandomInt(400) + 150
            fData.Sewn_custom_censer_freezeCooldown = sewingMachineMod.rng:RandomInt(400) + 150
        end
        fData.Sewn_custom_censer_dazedCooldown = fData.Sewn_custom_censer_dazedCooldown - 1
        fData.Sewn_custom_censer_freezeCooldown = fData.Sewn_custom_censer_freezeCooldown - 1
    end
    if sewingMachineMod:isUltra(fData) then
        for _, bullet in pairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE, -1, -1, false, false)) do
            local projectile = bullet:ToProjectile()
            local pData = projectile:GetData()
            if pData.Sewn_custom_censer_projectileLastPos ~= nil then
                if bullet.Position:Distance(censer.Position) < 160 then
                    local A = pData.Sewn_custom_censer_projectileLastPos
                    local B = projectile.Position
                    local P = censer.Player.Position
                    -- If the player is on the left of the projectile axe
                    local d = (P.X - A.X) * (B.Y - A.Y) - (P.Y - A.Y) * (B.X - A.X)
                    if d < 0 then
                        projectile:AddProjectileFlags(ProjectileFlags.CURVE_LEFT)
                    elseif d > 0 then
                        projectile:AddProjectileFlags(ProjectileFlags.CURVE_RIGHT)
                    else
                        projectile.ProjectileFlags = projectile.ProjectileFlags & ~ProjectileFlags.CURVE_LEFT
                        projectile.ProjectileFlags = projectile.ProjectileFlags & ~ProjectileFlags.CURVE_RIGHT
                    end
                else
                    projectile.ProjectileFlags = projectile.ProjectileFlags & ~ProjectileFlags.CURVE_LEFT
                    projectile.ProjectileFlags = projectile.ProjectileFlags & ~ProjectileFlags.CURVE_RIGHT
                end
            end
            pData.Sewn_custom_censer_projectileLastPos = projectile.Position
        end
    end
end

-- PEEPER
function sewnFamiliars:upPeeper(peeper)
    local fData = peeper:GetData()
    if peeper.Variant == FamiliarVariant.PEEPER then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customUpdate(peeper, sewnFamiliars.custom_update_peeper)
        end
        if sewingMachineMod:isUltra(fData) then
            if peeper.Player ~= nil then -- If familiar have no player, it's because it's the second peeper
                sewnFamiliars:customCache(peeper, sewnFamiliars.custom_cache_peeper)
                
                peeper.Player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
                peeper.Player:EvaluateItems()
            end
        end
    end
end
function sewnFamiliars:custom_update_peeper(peeper)
    local fData = peeper:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        if fData.Sewn_custom_peeper_tearCooldown == nil then
            fData.Sewn_custom_peeper_tearCooldown = sewingMachineMod.rng:RandomInt(100)
            return
        end
        if fData.Sewn_custom_peeper_tearCooldown == 0 then
            sewnFamiliars:shootTearsCircular(peeper, 5, nil, nil, nil, 4)
            fData.Sewn_custom_peeper_tearCooldown = 150
        end
        fData.Sewn_custom_peeper_tearCooldown = fData.Sewn_custom_peeper_tearCooldown - 1
    end
end
function sewnFamiliars:custom_cache_peeper(peeper, cacheFlag)
    local fData = peeper:GetData()
    if cacheFlag == CacheFlag.CACHE_FAMILIARS then
        if sewingMachineMod:isUltra(fData) then
            local secondEye_pos = peeper.Position
            if fData.Sewn_custom_peeper_secondEye ~= nil then
                secondEye_pos = fData.Sewn_custom_peeper_secondEye.Position
            end
            -- Creating a second peeper
            fData.Sewn_custom_peeper_secondEye = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.PEEPER, 0, secondEye_pos, v0, peeper.Player)
            -- Setting this second peeper ULTRA
            fData.Sewn_custom_peeper_secondEye:GetData().Sewn_upgradeState = sewingMachineMod.UpgradeState.ULTRA
            sewnFamiliars:upPeeper(fData.Sewn_custom_peeper_secondEye)
        end
    end
end

-- KING BABY
function sewnFamiliars:upKingBaby(kingBaby)
    local fData = kingBaby:GetData()
    if kingBaby.Variant == FamiliarVariant.KING_BABY then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customUpdate(kingBaby, sewnFamiliars.custom_update_kingBaby)
            sewnFamiliars:customNewRoom(kingBaby, sewnFamiliars.custom_newRoom_kingBaby)
        end
    end
end
function sewnFamiliars:kingBaby_isPlayingStopAnim(kingBaby)
	for _, animation in pairs(ANIMATION_NAMES.STOPPED) do
	    if kingBaby:GetSprite():IsPlaying(animation) then
	    	return true
	    end
	end
	return false
end
function sewnFamiliars:custom_newRoom_kingBaby(kingBaby, room)
    local fData = kingBaby:GetData()
    -- Remove all copy familiars
    local player = kingBaby.Player
    player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
    player:EvaluateItems()
    
    fData.Sewn_kingBaby_cooldown = 30

    fData.Sewn_kingBaby_hasCopyFamiliars = false
end
function sewnFamiliars:kingBaby_updateFamiliarFollowParent(familiar)
    if familiar:GetData().Sewn_kingBaby_isCopyFamiliar then
        local parent = familiar:GetData().Sewn_kingBaby_parentFollower
        sewnFamiliars:familiarFollowTrail(familiar, parent.Position)
	end
end

function sewnFamiliars:kingBaby_isFollower(familiar)
    return familiar:GetData().Sewn_IsFollower == true or vanillaFollowers[familiar.Variant] ~= nil
end
function sewnFamiliars:custom_update_kingBaby(kingBaby)
    local fData = kingBaby:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        if sewnFamiliars:kingBaby_isPlayingStopAnim(kingBaby) then
            if fData.Sewn_kingBaby_cooldown == nil then
                fData.Sewn_kingBaby_cooldown = 0
            elseif fData.Sewn_kingBaby_cooldown > 0 then
                fData.Sewn_kingBaby_cooldown = fData.Sewn_kingBaby_cooldown - 1
            end
            
            if not fData.Sewn_kingBaby_hasCopyFamiliars and fData.Sewn_kingBaby_cooldown == 0 then
                local shouldFollow = kingBaby.Player

                -- Loop through all familiars
                for _, fam in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
                    fam = fam:ToFamiliar()

                    -- Check if the familiar is a follower
                    if sewnFamiliars:kingBaby_isFollower(fam) and fam.Variant ~= kingBaby.Variant then
                        -- Duplicate the familiar
                        local newFam = Isaac.Spawn(fam.Type, fam.Variant, fam.SubType, kingBaby.Player.Position, v0, nil):ToFamiliar()
                        local newFData = newFam:GetData()
                        
                        -- Register the duped familiar
                        newFData.Sewn_kingBaby_parentFollower = shouldFollow -- Store who that familiar should follow
                        newFData.Sewn_kingBaby_isCopyFamiliar = true
                        newFData.Sewn_noUpgrade = true
                        newFam:RemoveFromFollowers() -- Remove it from the normal familiar chain
                        newFam:ClearEntityFlags(EntityFlag.FLAG_APPEAR) -- Disable the "Poof" effect when it appears
                        if not sewingMachineMod:isUltra(fData) then
                            sewnFamiliars:setDamageTearMultiplier(newFam, 0.75)
                        end
                        sewnFamiliars:customUpdate(newFam, sewnFamiliars.kingBaby_updateFamiliarFollowParent)
                        if newFam.Variant == FamiliarVariant.ROTTEN_BABY then
                            sewnFamiliars:customAnimation(newFam, function() sewnFamiliars:familiarIsSpawningFlySpider(newFam, true, nil, true) end, ANIMATION_NAMES.SHOOT)
                        end
                        
                        -- Turn new familiars blue
                        newFam:SetColor(Color(0.5,0.5,1,0.5,0,0,0), -1, 2, false, false)

                        -- Update the last familiar
                        shouldFollow = newFam
                    end
                end

                fData.Sewn_kingBaby_hasCopyFamiliars = true
            end
        else
            if fData.Sewn_kingBaby_hasCopyFamiliars == true then -- King baby was released
                sewingMachineMod:delayFunction(sewnFamiliars.custom_newRoom_kingBaby, 10, kingBaby)
            end
        end
    end
end

-- FLIES - DISTANT ADMIRATION, FOREVER ALONE, FRIEN ZONE, OBESSED FAN, LOST FLY
function sewnFamiliars:upFlies(fly)
    local fData = fly:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        sewnFamiliars:customCache(fly, sewnFamiliars.custom_cache_flies)
        sewnFamiliars:custom_cache_flies(fly, CacheFlag.CACHE_DAMAGE)
        if sewingMachineMod:isSuper(fData) then
            sewnFamiliars:spriteScaleMultiplier(fly, 1.1)
        else
            sewnFamiliars:spriteScaleMultiplier(fly, 1.2)
        end
    else
        fly.CollisionDamage = fData.Sewn_collisionDamage
        sewnFamiliars:spriteScaleMultiplier(fly, 1)
    end
end
function sewnFamiliars:custom_cache_flies(fly, cacheFlag)
    local fData = fly:GetData()
    if cacheFlag == CacheFlag.CACHE_DAMAGE then
        local playerDamage = 3.5
        
        if fly.Player then
            playerDamage = fly.Player.Damage
        end
        
        local sprite = fly:GetSprite()
        if sewingMachineMod:isSuper(fData) then
            fly.CollisionDamage = fData.Sewn_collisionDamage + math.sqrt(playerDamage/4) + 1
        end
        if sewingMachineMod:isUltra(fData) then
            fly.CollisionDamage = fData.Sewn_collisionDamage + math.sqrt(playerDamage/2) + 2
        end
    end
end

-- SPIDER MOD
function sewnFamiliars:upSpiderMod(spiderMod)
    local fData = spiderMod:GetData()
    if spiderMod.Variant == FamiliarVariant.SPIDER_MOD then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customUpdate(spiderMod, sewnFamiliars.custom_update_spiderMod)
            if sewingMachineMod:isUltra(fData) then
                sewnFamiliars:customCleanAward(spiderMod, sewnFamiliars.custom_cleanAward_spiderMod)
            end
        end
    end
end
function sewnFamiliars:custom_cleanAward_spiderMod(spiderMod)
    for _, egg in pairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.SPIDER_MOD_EGG, -1, false, false)) do
        local rollSpider = sewingMachineMod.rng:RandomInt(2)
        if rollSpider == 0 then
            local nbSpiders = sewingMachineMod.rng:RandomInt(4)
            for i = 1, nbSpiders do
                local velocity = Vector(0, 0)
                local force = 30
                velocity.X = sewingMachineMod.rng:RandomFloat() + sewingMachineMod.rng:RandomInt(force * 2) - force
                velocity.Y = sewingMachineMod.rng:RandomFloat() + sewingMachineMod.rng:RandomInt(force * 2) - force
                spiderMod.Player:ThrowBlueSpider(egg.Position, velocity + egg.Position)
            end
        end
        egg:Remove()
        Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.TOOTH_PARTICLE, 0, egg.Position, v0, nil)
    end
end
function sewnFamiliars:custom_update_spiderMod(spiderMod)
    local fData = spiderMod:GetData()
    if sewingMachineMod.currentRoom:IsClear() then
        return
    end
    if spiderMod.FrameCount % 30 == 0 then
        local roll = sewingMachineMod.rng:RandomInt(101)
        if sewingMachineMod:isUltra(fData) then 
            roll = roll + 10 -- higher chance to spawn an egg in ultra
        end
        if roll > 80 then
            for _, egg in pairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.SPIDER_MOD_EGG, -1, false, false)) do
                if egg.Position:DistanceSquared(spiderMod.Position) < 20^2 then
                    return -- Do not spawn eggs close to an other egg
                end
            end
            spiderMod:GetSprite():Play("Appear", false)
            local egg = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.SPIDER_MOD_EGG, 0, spiderMod.Position, v0, spiderMod):ToEffect()
            egg.Timeout = 20 * 30
            -- Flip the egg sprite
            egg.FlipX = sewingMachineMod.rng:RandomInt(2) == 1
            egg:GetData().Sewn_spidermod_eggColliderCooldown = {}
        end
    end
end

-- ISAAC'S HEART
function sewnFamiliars:upIsaacsHeart(isaacsHeart)
    local fData = isaacsHeart:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        isaacsHeart.SizeMulti = Vector(0.8, 0.8)
        --isaacsHeart.Size = 0.8
        if sewingMachineMod:isSuper(fData) then
            sewnFamiliars:customPlayerTakeDamage(isaacsHeart, sewnFamiliars.custom_playerTakeDamage_isaacsHeart_super)
        else
            sewnFamiliars:customPlayerTakeDamage(isaacsHeart, sewnFamiliars.custom_playerTakeDamage_isaacsHeart_ultra)
        end
        sewnFamiliars:customUpdate(isaacsHeart, sewnFamiliars.custom_update_isaacsHeart)
    end
end
function sewnFamiliars:custom_playerTakeDamage_isaacsHeart_super(isaacsHeart, source, amount, flag)
    if source.Type == EntityType.ENTITY_PROJECTILE then
        local rollPrevent = sewingMachineMod.rng:RandomInt(100)
        if rollPrevent < 20 then
            return false
        end
    end
end
function sewnFamiliars:custom_playerTakeDamage_isaacsHeart_ultra(isaacsHeart, source, amount, flag)
    local rollPrevent = sewingMachineMod.rng:RandomInt(100)
    for i = 1, 8 do
        local velo = Vector(5, 5)
        velo = velo:Rotated((360 / 8) * i)
        isaacsHeart.Player:FireTear(isaacsHeart.Position, velo)
    end

    if rollPrevent < 20 then
        return false
    end
end
function sewnFamiliars:custom_update_isaacsHeart(isaacsHeart)
    sewnFamiliars:familiarFollowTrail(isaacsHeart, isaacsHeart.Player.Position, true)
end

-- LEECH
function sewnFamiliars:upLeech(leech)
    local fData = leech:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        sewnFamiliars:customCollision(leech, sewnFamiliars.custom_collision_leech)
        --sewnFamiliars:customUpdate(leech, sewnFamiliars.custom_update_leech)
        if sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customKillEnemy(leech, sewnFamiliars.custom_killEnemy_leech)
        end
    end
end
function sewnFamiliars:custom_collision_leech(leech, collider)
    if collider:IsVulnerableEnemy() then
        if leech.FrameCount % 10 == 0 then
            local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, leech.Position, v0, nil)
            creep.CollisionDamage = 1
        end
    end
end
function sewnFamiliars:custom_leech_burstTears(data)
    sewnFamiliars:burstTears(data.FAMILIAR, data.AMOUNT_TEARS, data.DAMAGE, data.FORCE, data.DIFFERENT_SIZE, data.TEAR_VARIANT, data.TEAR_FLAGS, data.POSITION)
end
function sewnFamiliars:custom_killEnemy_leech(leech, enemy)
    local enemyHP = math.floor(enemy.MaxHitPoints / 2)
    local nbTears = sewingMachineMod.rng:RandomInt(math.min(enemyHP, 15)) + 5
    
    local data = {
        FAMILIAR = leech,
        AMOUNT_TEARS = nbTears, 
        DAMAGE = 3.5,
        FORCE = 8,
        DIFFERENT_SIZE = true,
        TEAR_VARIANT = nil,
        TEAR_FLAGS = nil,
        POSITION = enemy.Position
    }
    sewingMachineMod:delayFunction(sewnFamiliars.custom_leech_burstTears, 1, data)
end

-- BBF
function sewnFamiliars:upBbf(bbf)
    local fData = bbf:GetData()
    if bbf.Variant == FamiliarVariant.BBF then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customUpdate(bbf, sewnFamiliars.custom_update_bbf)
        end
    end
end
function sewnFamiliars:custom_bbf_getNextPowder(powder)
    local powders = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_BLACKPOWDER, -1, false, false)
    if #powders == 0 then
        return nil
    elseif #powders == 1 then
        return powders[1]
    end
    local nextPowder = powders[1]
    for _, powder in pairs(powders) do
        if powder:Exists() and powder.FrameCount < nextPowder.FrameCount then
            nextPowder = powder
        end
    end
    return nextPowder
end
function sewnFamiliars:custom_bbf_setPowderOnFire(powder)
    if powder == nil then
        return
    end
    
    local fire = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HOT_BOMB_FIRE, 0, powder.Position, v0, nil):ToEffect()
    fire.Timeout = 80
    fire.Scale = 0.75
    fire.SpriteScale = Vector(0.75, 0.75)
    
    powder:Remove()
    sewingMachineMod:delayFunction(sewnFamiliars.custom_bbf_setPowderOnFire, 1, sewnFamiliars:custom_bbf_getNextPowder(powder))
end
function sewnFamiliars:custom_update_bbf(bbf)
    local fData = bbf:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        if not fData.Sewn_bbf_hasExplode then
            if bbf.Player.Position:DistanceSquared(bbf.Position) < 100 ^2 and not (bbf.Player:HasCollectible(CollectibleType.COLLECTIBLE_HOST_HAT) or bbf.Player:HasCollectible(CollectibleType.COLLECTIBLE_PYROMANIAC)) then
                bbf.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
                bbf:SetColor(Color(1,1,1,0.5, 0,0,0), 5, 1, true, false)
            else
                bbf.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ENEMIES
            end
        end
        if sewingMachineMod:isUltra(fData) then
            if bbf.FrameCount % 6 == 0 and not fData.Sewn_bbf_hasExplode then
                local bbfPowder = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_BLACKPOWDER, 0, bbf.Position, v0, bbf):ToEffect()
                bbfPowder.Timeout = 50
                fData.Sewn_bbf_lastPowder = bbfPowder
            end
            if fData.Sewn_bbf_hasExplode == true and fData.Sewn_bbf_lastPowder ~= nil then
                sewnFamiliars:custom_bbf_setPowderOnFire(fData.Sewn_bbf_lastPowder)
                fData.Sewn_bbf_lastPowder = nil
            end
        end
    end
    -- If it has explode
    if not fData.Sewn_bbf_hasExplode and bbf.Velocity:LengthSquared() == 0 then
        -- Hide the crown
        sewingMachineMod:hideCrown(bbf, true)
        fData.Sewn_bbf_hasExplode = true
    end
    if fData.Sewn_bbf_hasExplode and bbf.Velocity:LengthSquared() > 0 then
        -- Show the crown
        sewingMachineMod:hideCrown(bbf, false)
        fData.Sewn_bbf_hasExplode = false
    end
end

-- CAIN'S OTHER EYE
function sewnFamiliars:upCainsOtherEye(cainsOtherEye)
    local fData = cainsOtherEye:GetData()
    if cainsOtherEye.Variant == FamiliarVariant.CAINS_OTHER_EYE then
        if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customFireInit(cainsOtherEye, sewnFamiliars.custom_fireInit_cainsOtherEye)
        end
    end
end
function sewnFamiliars:custom_fireInit_cainsOtherEye(cainsOtherEye, tear)
    local fData = cainsOtherEye:GetData()
    
    tear.TearFlags = tear.TearFlags | TearFlags.TEAR_BOUNCE
    
    sewingMachineMod:delayFunction(sewnFamiliars.cainsOtherEye_fireTear, 2, {FAMILIAR = cainsOtherEye, TEAR = tear})
end
function sewnFamiliars:cainsOtherEye_fireTear(param)
    local cainsOtherEye = param.FAMILIAR
    local tear = param.TEAR
    local nbTear = param.NB_TEAR or 1
    
    local nbTearMax = 2
    if sewingMachineMod:isUltra(cainsOtherEye:GetData()) then
        nbTearMax = 4
    end
    
    if nbTear >= nbTearMax then return end
    
    local newTear = Isaac.Spawn(EntityType.ENTITY_TEAR, tear.Variant, tear.SubType, cainsOtherEye.Position, tear.Velocity, cainsOtherEye):ToTear()
    newTear.CollisionDamage = tear.CollisionDamage
    newTear.TearFlags = tear.TearFlags
    newTear.Scale = tear.Scale
    newTear.TearFlags = tear.TearFlags | TearFlags.TEAR_BOUNCE
    if sewingMachineMod:isUltra(cainsOtherEye:GetData()) then
        newTear.FallingAcceleration = -0.05
    end
    sewnFamiliars:toBabyBenderTear(cainsOtherEye, newTear)
    
    param.NB_TEAR = nbTear + 1
    sewingMachineMod:delayFunction(sewnFamiliars.cainsOtherEye_fireTear, 3, param)
end

-- ???'S ONLY FRIEND
function sewnFamiliars:upBlueBabysOnlyFriend(blueBabysOnlyFriend)
    local fData = blueBabysOnlyFriend:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        sewnFamiliars:customUpdate(blueBabysOnlyFriend, sewnFamiliars.custom_update_blueBabysOnlyFriend)
        fData.Sewn_blueBabysOnlyFriend_crushCooldown = math.random(150) + 30
        fData.Sewn_blueBabysOnlyFriend_lastCrush = blueBabysOnlyFriend.FrameCount
    end
end
function sewnFamiliars:custom_update_blueBabysOnlyFriend(blueBabysOnlyFriend)
    local fData = blueBabysOnlyFriend:GetData()
    local sprite = blueBabysOnlyFriend:GetSprite()
    
    if sprite:IsFinished("Crush") then
        sprite:Play("Idle", false)
    end
    if fData.Sewn_blueBabysOnlyFriend_lastCrush + fData.Sewn_blueBabysOnlyFriend_crushCooldown <= blueBabysOnlyFriend.FrameCount then
        local damages = 30 + blueBabysOnlyFriend.Player.Damage
        local range = 60
        
        if sewingMachineMod:isUltra(fData) then
            damages = 45 + blueBabysOnlyFriend.Player.Damage * 2
            range = 90
            -- Destroy rocks
            for i = -20, 20, 20 do
                for j = -20, 20, 20 do
                    local index = sewingMachineMod.currentRoom:GetGridIndex(blueBabysOnlyFriend.Position + Vector(i, j))
                    sewingMachineMod.currentRoom:DestroyGrid(index, true)
                end
            end
            
            local nbParticules = sewingMachineMod.rng:RandomInt(10)+5
            for i = 1, nbParticules do
                local velocity = Vector(math.random() + math.random(-3,3), math.random() + math.random(-3,3))
                if sewingMachineMod.currentLevel:GetStage() == LevelStage.STAGE1_1 or sewingMachineMod.currentLevel:GetStage() == LevelStage.STAGE1_2 then
                    Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.WOOD_PARTICLE, -1, blueBabysOnlyFriend.Position, velocity, nil)
                else
                    Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.ROCK_PARTICLE, -1, blueBabysOnlyFriend.Position,velocity, nil)
                end
            end
        end
        
        sprite:Play("Crush", true)
        
        for _, npc in pairs(Isaac.FindInRadius(blueBabysOnlyFriend.Position, range, EntityPartition.ENEMY)) do
            if npc:IsVulnerableEnemy() then
                npc:AddConfusion(EntityRef(blueBabysOnlyFriend.Player), 60, true)
                npc:TakeDamage(damages, 0, EntityRef(blueBabysOnlyFriend), 0) 
            end
        end
        fData.Sewn_blueBabysOnlyFriend_crushCooldown = math.random(150) + 30
        fData.Sewn_blueBabysOnlyFriend_lastCrush = blueBabysOnlyFriend.FrameCount
    end
end

-- PUNCHING BAG
local PUNCHINGBAG_CHAMPIONS = {STRONG_LIME_GREEN = 1, PURE_MAGENTA = 2, MOSTLY_PURE_VIOLET = 3, VERY_LIGHT_BLUE = 4, VIVID_BLUE = 5}
local PUNCHINGBAG_COLORS = {Color(0.1,0.8,0.2,1,0,0,0), Color(1,0,1,1,0,0,0), Color(0.75,0,1,1,0,0,0), Color(0.5,0.5,1,1,0,0,0), Color(0.2,0.2,1,1,0,0,0)}
function sewnFamiliars:upPunchingBag(punchingBag)
    local fData = punchingBag:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        punchingBag.CollisionDamage = 2
        if sewingMachineMod:isUltra(fData) then
            sewnFamiliars:punchingBag_changeColor(punchingBag)
            sewnFamiliars:customUpdate(punchingBag, sewnFamiliars.custom_update_punchingBag)
            sewnFamiliars:customPlayerTakeDamage(punchingBag, sewnFamiliars.custom_playerTakeDamage_punchingBag)
        end
    end
end
function sewnFamiliars:punchingBag_changeColor(punchingBag)
    local fData = punchingBag:GetData()
    local counterChampions = 0
    -- Count Champion forms
    for _, c in pairs(PUNCHINGBAG_CHAMPIONS) do
        counterChampions = counterChampions + 1
    end
    
    -- Remove pull effect from the MOSTLY PURE VIOLET champion
    for _, effect in pairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.PULLING_EFFECT_2, 0, false, false)) do
        effect:Remove()
    end
    
    fData.Sewn_punchingBag_champion = sewingMachineMod.rng:RandomInt(counterChampions) + 1
    punchingBag:SetColor(PUNCHINGBAG_COLORS[fData.Sewn_punchingBag_champion], -1, 2, false, false)
    
    
    fData.Sewn_punchingBag_championCooldown = (sewingMachineMod.rng:RandomInt(15) + 10) * 30
    fData.Sewn_punchingBag_championLastChange = game:GetFrameCount()
    
    fData.Sewn_punchingBag_pureMagenta_tearCooldown = 0
    fData.Sewn_punchingBag_pureMagenta_lastTear = 0
end
function sewnFamiliars:custom_update_punchingBag(punchingBag)
    local fData = punchingBag:GetData()
    if fData.Sewn_punchingBag_champion == PUNCHINGBAG_CHAMPIONS.STRONG_LIME_GREEN then
        if punchingBag.FrameCount % 15 == 0 then
            local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_GREEN, 0, punchingBag.Position, v0, punchingBag):ToEffect()
            creep.Timeout = 75
        end
    elseif fData.Sewn_punchingBag_champion == PUNCHINGBAG_CHAMPIONS.PURE_MAGENTA then
        if fData.Sewn_punchingBag_pureMagenta_lastTear + fData.Sewn_punchingBag_pureMagenta_tearCooldown < game:GetFrameCount() then
            local velocity = Vector(3, 3)
            velocity = velocity:Rotated(sewingMachineMod.rng:RandomInt(360))
            local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, punchingBag.Position, velocity, punchingBag):ToTear()
            tear.Scale = 1.1
            tear.CollisionDamage = 8
            sewnFamiliars:toBabyBenderTear(punchingBag, tear)
            
            fData.Sewn_punchingBag_pureMagenta_lastTear = game:GetFrameCount()
            fData.Sewn_punchingBag_pureMagenta_tearCooldown = sewingMachineMod.rng:RandomInt(210) + 90
        end
    elseif fData.Sewn_punchingBag_champion == PUNCHINGBAG_CHAMPIONS.MOSTLY_PURE_VIOLET then 
        if fData.Sewn_punchingBag_mostlyPureViolet_pullEffect == nil or not fData.Sewn_punchingBag_mostlyPureViolet_pullEffect:Exists() then
            fData.Sewn_punchingBag_mostlyPureViolet_pullEffect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PULLING_EFFECT_2, 0, punchingBag.Position, v0, punchingBag):ToEffect()
        end
        --fData.Sewn_punchingBag_mostlyPureViolet_pullEffect.Timeout = fData.Sewn_punchingBag_championCooldown
        fData.Sewn_punchingBag_mostlyPureViolet_pullEffect.Velocity = punchingBag.Position - fData.Sewn_punchingBag_mostlyPureViolet_pullEffect.Position
        for _, npc in pairs(Isaac.FindInRadius(punchingBag.Position, 150, EntityPartition.ENEMY)) do
            if npc.Position:DistanceSquared(punchingBag.Position) < 50 ^2 then
                npc.Velocity = npc.Velocity * 0.7 + (punchingBag.Position - npc.Position):Resized(1)
            else
                npc.Velocity = npc.Velocity * 0.9 + (punchingBag.Position - npc.Position):Resized(1)
            end
		end
    end
    -- Change Champion after couple of seconds
    if fData.Sewn_punchingBag_championLastChange + fData.Sewn_punchingBag_championCooldown < game:GetFrameCount() then
        sewnFamiliars:punchingBag_changeColor(punchingBag)
    end
end
function sewnFamiliars:custom_playerTakeDamage_punchingBag(punchingBag, damageSource)
    local fData = punchingBag:GetData()
    if fData.Sewn_punchingBag_champion == PUNCHINGBAG_CHAMPIONS.VERY_LIGHT_BLUE then
        for i = 1, 8 do
            local velo = Vector(5, 5)
            velo = velo:Rotated((360 / 8) * i)
            local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, punchingBag.Position, velo, punchingBag):ToTear()
            tear.Scale = 1.1
            tear.CollisionDamage = 4
            sewnFamiliars:toBabyBenderTear(punchingBag, tear)
        end
    elseif fData.Sewn_punchingBag_champion == PUNCHINGBAG_CHAMPIONS.VIVID_BLUE then
        punchingBag.Player:AddBlueFlies(sewingMachineMod.rng:RandomInt(3)+1, punchingBag.Position, nil)
    end
end

-- HUSHY
function sewnFamiliars:upHushy(hushy)
    local fData = hushy:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        sewnFamiliars:customAnimation(hushy, sewnFamiliars.custom_animation_hushy, "Idle")
        sewnFamiliars:customAnimation(hushy, sewnFamiliars.custom_animationStart_hushy, "Phase2Start")
        fData.Sewn_hushy_cooldown = 30
    end
end

-- Circle tears attack
function sewnFamiliars:hushy_fireCircleProj(hushy)
    local fData = hushy:GetData()
    local rollTear = math.random(6, 10)
    if sewingMachineMod:isUltra(fData) then
        rollTear = math.random(10, 20)
    end
    
    local tearOffset = sewingMachineMod.rng:RandomInt(360)
    for i = 1, rollTear do
        local velo = Vector(4, 4)
        velo = velo:Rotated((360 / rollTear) * i + tearOffset)
        velo = velo:Rotated(tearOffset)
        local proj = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_HUSH, 0, hushy.Position, velo, hushy):ToProjectile()
        proj.FallingAccel = -0.05
        proj:AddProjectileFlags(ProjectileFlags.CANT_HIT_PLAYER)
        proj:AddProjectileFlags(ProjectileFlags.HIT_ENEMIES)
        proj:AddProjectileFlags(ProjectileFlags.SINE_VELOCITY)
        
        fData.Sewn_hushy_cooldown = 60 + sewingMachineMod.rng:RandomInt(60)
    end
end

function sewnFamiliars:hushy_fireTargetedProj(hushy)
    local fData = hushy:GetData()
    local maxAdditionalTears = 1
    if sewingMachineMod:isUltra(fData) then
        maxAdditionalTears = 3
    end
    local amountTears = math.random(0,maxAdditionalTears) * 2 + 5
    for i = 1, amountTears do
        local velo = (hushy.Player.Position - hushy.Position):Normalized() * 8
        velo = velo:Rotated(5*i - 5 * amountTears / 2)
        local proj = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_HUSH, 0, hushy.Position, velo, hushy):ToProjectile()
        proj:AddProjectileFlags(ProjectileFlags.CANT_HIT_PLAYER)
        proj:AddProjectileFlags(ProjectileFlags.HIT_ENEMIES)
        
        fData.Sewn_hushy_cooldown = 60 + sewingMachineMod.rng:RandomInt(30)
    end
end

-- Continuum tears attack
function sewnFamiliars:hushy_fireContinuumTears(hushy)
    local fData = hushy:GetData()

    if fData.Sewn_hushy_continuumTears == nil then
        fData.Sewn_hushy_continuumTears = sewingMachineMod.rng:RandomInt(20) + 10
    end
    local velo = Vector(0, 0)
    local dir = hushy.Player:GetFireDirection()
    if dir == Direction.LEFT then
        velo.X = -5
        velo.Y = (math.random() - 0.5) * 2
    elseif dir == Direction.RIGHT then
        velo.X = 5
        velo.Y = (math.random() - 0.5) * 2
    elseif dir == Direction.UP then
        velo.X = (math.random() - 0.5) * 2
        velo.Y = -5
    elseif dir == Direction.DOWN then
        velo.X = (math.random() - 0.5) * 2
        velo.Y = 5
    end
    local proj = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_HUSH, 0, hushy.Position, velo, hushy):ToProjectile()
    proj.FallingAccel = -0.09
    proj:AddProjectileFlags(ProjectileFlags.CANT_HIT_PLAYER)
    proj:AddProjectileFlags(ProjectileFlags.HIT_ENEMIES)
    proj:AddProjectileFlags(ProjectileFlags.CONTINUUM)
    
    fData.Sewn_hushy_continuumTears = fData.Sewn_hushy_continuumTears - 1
    if fData.Sewn_hushy_continuumTears > 0 then
        fData.Sewn_hushy_cooldown = sewingMachineMod.rng:RandomInt(10) + 7
    else
        fData.Sewn_hushy_continuumTears = nil
        fData.Sewn_hushy_cooldown = 60
    end
end
function sewnFamiliars:custom_animationStart_hushy(hushy)
    local fData = hushy:GetData()
    fData.Sewn_hushy_continuumWaves = nil
end
function sewnFamiliars:custom_animation_hushy(hushy)
    local fData = hushy:GetData()
    if fData.Sewn_hushy_cooldown <= 0 then
        local rollAttack = math.random(1,3)
        if not sewingMachineMod:isUltra(fData) then
            rollAttack = math.random(2,3)
        end
        if fData.Sewn_hushy_continuumTears and fData.Sewn_hushy_continuumTears > 0 or rollAttack == 1 then
            sewnFamiliars:hushy_fireContinuumTears(hushy)
        elseif rollAttack == 2 then
            sewnFamiliars:hushy_fireCircleProj(hushy)
        elseif rollAttack == 3 then
            sewnFamiliars:hushy_fireTargetedProj(hushy)
        end
    else
        fData.Sewn_hushy_cooldown = fData.Sewn_hushy_cooldown - 1
    end
end

-- LIL HARBINGERS
local LIL_HARBINGERS = {
    WAR = 0,
    PESTILENCE = 1,
    FAMINE = 2,
    DEATH = 3,
    CONQUEST = 4
}
function sewnFamiliars:upLilHarbingers(lilHarbinger)
    local fData = lilHarbinger:GetData()
    sewingMachineMod:addCrownOffset(lilHarbinger, Vector(0, 14))
    sewnFamiliars:customUpdate(lilHarbinger, sewnFamiliars.custom_update_lilHarbinger)
    --sewnFamiliars:customUpdate(lilHarbinger, sewnFamiliars.custom_animation_lilHarbinger, ANIMATION_NAMES.SPAWN)
    sewnFamiliars:customPlayerTakeDamage(lilHarbinger, sewnFamiliars.custom_playerTakeDamage_lilHarbinger)

    sewnFamiliars:customAnimation(lilHarbinger, sewnFamiliars.custom_animation_lilHarbinger, ANIMATION_NAMES.SPAWN)

    --fData.Sewn_lilHarbinger_attackCooldown = sewingMachineMod.rng:RandomInt(200) + 100
end

function sewnFamiliars:custom_update_lilHarbinger(lilHarbinger)
    local fData = lilHarbinger:GetData()
    
    if lilHarbinger.SubType == LIL_HARBINGERS.PESTILENCE then
        for _, effect in pairs(Isaac.FindInRadius(lilHarbinger.Position, lilHarbinger.Size, EntityPartition.EFFECT)) do
            if effect.Variant == EffectVariant.PLAYER_CREEP_GREEN and effect.FrameCount == 1 then
                local creep = effect:ToEffect()
                creep.CollisionDamage = creep.CollisionDamage * 1.8
            end
        end
    elseif lilHarbinger.SubType == LIL_HARBINGERS.DEATH then
        if lilHarbinger.State == 1 then
            lilHarbinger.CollisionDamage = 2
        end
    end
    for _, locust in pairs(Isaac.FindInRadius(lilHarbinger.Position, lilHarbinger.Size, EntityPartition.FAMILIAR)) do
        local locustData = locust:GetData()

        if locust.Variant == FamiliarVariant.BLUE_FLY and locust.SubType > 0 and locust.SpawnerType == lilHarbinger.Type and locust.SpawnerVariant == lilHarbinger.Variant and not locustData.Sewn_lilHarbingers_locustInit then
            if lilHarbinger.SubType == LIL_HARBINGERS.CONQUEST then
                sewnFamiliars:customCollision(locust, sewnFamiliars.lilHarbinger_conquestLocust_collision)
            elseif lilHarbinger.SubType == LIL_HARBINGERS.WAR then
                fData.Sewn_lilHarbinger_locustExplode = false
                locust:GetData().Sewn_lilHarbinger_locustParent = lilHarbinger
                sewnFamiliars:customCollision(locust, sewnFamiliars.lilHarbinger_warLocust_collision)
            elseif lilHarbinger.SubType == LIL_HARBINGERS.FAMINE then
                locust.CollisionDamage = locust.CollisionDamage * 2.5
            end

            if not locustData.Sewn_lilHarbingers_additionalLocust and sewingMachineMod:isUltra(fData) then
                local additionalLocust = Isaac.Spawn(locust.Type, locust.Variant, locust.SubType, locust.Position, v0, lilHarbinger)
                additionalLocust:GetData().Sewn_lilHarbingers_additionalLocust = true
            end
            locustData.Sewn_lilHarbingers_locustInit = true
        end
    end
end
function sewnFamiliars:lilHarbinger_famine_attack(param)
    local lilHarbinger = param.LIL_HARBINGER
    local target = param.TARGET
    local nbTears = param.NB_TEARS or 3
    for i = 1, nbTears do
        local velo = (target.Position - lilHarbinger.Position):Normalized() * 7
        velo = velo:Rotated(15 * i - 15 * math.ceil(nbTears/2))
        local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLOOD, 0, lilHarbinger.Position, velo, lilHarbinger):ToTear()
        tear.FallingAcceleration = -0.03
        tear.TearFlags = TearFlags.TEAR_SPECTRAL
        tear.CollisionDamage = 7.5
        tear.Scale = 1.05
    end
    if nbTears == 3 then
        sewingMachineMod:delayFunction(sewnFamiliars.lilHarbinger_famine_attack, 20, {LIL_HARBINGER = lilHarbinger, TARGET = target, NB_TEARS = 4})
    end
end

function sewnFamiliars:lilHarbinger_conquestLocust_collision(locust, collider)
    if collider:IsVulnerableEnemy() then
        local roll = sewingMachineMod.rng:RandomInt(100)
        if roll < 15 then
            local crackTheSky = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CRACK_THE_SKY, 0, collider.Position, v0, locust.Player):ToEffect()

            crackTheSky.CollisionDamage = crackTheSky.CollisionDamage + math.min(locust.Player.Damage, 20)
        end
    end
end
function sewnFamiliars:lilHarbinger_warLocust_collision(locust, collider)
    if collider:IsVulnerableEnemy() then
        locust:GetData().Sewn_lilHarbinger_locustParent:GetData().Sewn_lilHarbinger_locustExplode = true
    end
end
function sewnFamiliars:custom_playerTakeDamage_lilHarbinger(lilHarbinger, damageSource, damageAmount, damageFlags)
    local fData = lilHarbinger:GetData()
    if damageSource.Type == EntityType.ENTITY_FAMILIAR and damageSource.Variant == FamiliarVariant.BLUE_FLY and damageFlags & DamageFlag.DAMAGE_EXPLOSION ~= 0 then -- Damage taken from a red locustWAR LOCUST EXPLOD
        if fData.Sewn_lilHarbinger_locustExplode == true then
            fData.Sewn_lilHarbinger_locustExplode = false
            return false
        end
    end
    if damageSource.Type == EntityType.ENTITY_TEAR and damageFlags & DamageFlag.DAMAGE_EXPLOSION ~= 0 and damageSource.Entity.SpawnerType == EntityType.ENTITY_FAMILIAR and damageSource.Entity.SpawnerVariant == FamiliarVariant.LIL_HARBINGERS then -- Damage taken from an explosive tear from lil harbingers (ipecac pestilence shots)
        return false
    end
end

-- DEAD CAT
function sewnFamiliars:upDeadCat(deadCat)
    local fData = deadCat:GetData()
    local player = deadCat.Player
    local pData = player:GetData()
    if pData.Sewn_deadCat_counter == nil then
        pData.Sewn_deadCat_counter = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_DEAD_CAT)
    end
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        sewnFamiliars:customUpdate(deadCat, sewnFamiliars.custom_update_deadCat)
    end
end
function sewnFamiliars:custom_update_deadCat(deadCat)
    local fData = deadCat:GetData()
    local player = deadCat.Player
    local pData = player:GetData()
    local deadCats = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_DEAD_CAT)
    
    if player:IsDead() then
        pData.Sewn_deadCat_playerIsDead = true
    end
    
    if pData.Sewn_deadCat_playerIsDead == true and pData.Sewn_deadCat_counter ~= deadCats then
        if pData.Sewn_deadCat_counter > deadCats then
            if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
                player:AddSoulHearts(2)
            end
            if sewingMachineMod:isUltra(fData) then
                player:AddMaxHearts(2, true)
                player:AddHearts(2)
            end
        end
        pData.Sewn_deadCat_playerIsDead = false
        pData.Sewn_deadCat_counter = deadCats
    end
end

-- HOLY WATER



-- If player has not Holy Mantle -> Give holy mantle effect in some rooms



function sewnFamiliars:upHolyWater(holyWater)
    local fData = holyWater:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        sewnFamiliars:customUpdate(holyWater, sewnFamiliars.custom_update_holyWater)
        sewnFamiliars:customPlayerTakeDamage(holyWater, sewnFamiliars.custom_playerTakeDamage_holyWater)
        if sewingMachineMod:isUltra(fData) then
            fData.Sewn_holyWater_hasHolyMantle = holyWater.Player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
            sewnFamiliars:customNewRoom(holyWater, sewnFamiliars.custom_newRoom_holyWater)
        end
    end
end
function sewnFamiliars:custom_update_holyWater(holyWater)
    local fData = holyWater:GetData()

    -- Prevent Holy Water from cracking
    local sprite = holyWater:GetSprite()
    sprite:Play("Idle", true)
    holyWater:FollowParent()

    if sewingMachineMod:isUltra(fData) then
        -- If the player lose his holy mantle effect -> spawn water
        if fData.Sewn_holyWater_hasHolyMantle == true and holyWater.Player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE) == false then
            sewnFamiliars:custom_holyWater_spawnWater(holyWater)
            fData.Sewn_holyWater_hasHolyMantle = false
        end
    end

end
function sewnFamiliars:custom_playerTakeDamage_holyWater(holyWater, damageSource)
    sewnFamiliars:custom_holyWater_spawnWater(holyWater)
end

function sewnFamiliars:custom_newRoom_holyWater(holyWater, room)
    local fData = holyWater:GetData()

    fData.Sewn_holyWater_hasHolyMantle = false
    
    -- if the player has Holy Mantle
    if holyWater.Player:HasCollectible(CollectibleType.COLLECTIBLE_HOLY_MANTLE) then
        fData.Sewn_holyWater_hasHolyMantle = true
    else
        local chance = 25
        local roll = sewingMachineMod.rng:RandomInt(100)

        if holyWater.Player:HasPlayerForm(PlayerForm.PLAYERFORM_ANGEL) then
            chance = chance + 15
        end

        if sewingMachineMod.currentRoom:IsFirstVisit() and roll < chance then
            holyWater.Player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE, true)
            fData.Sewn_holyWater_hasHolyMantle = true
        end
    end
end
function sewnFamiliars:custom_holyWater_setCreepVisible(creep)
    creep.Visible = true
end
function sewnFamiliars:custom_holyWater_spawnWater(holyWater)
    local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER, 0, holyWater.Position, v0, holyWater):ToEffect()
    
    -- Prevent from a visual bug
    creep.Visible = false
    sewingMachineMod:delayFunction(sewnFamiliars.custom_holyWater_setCreepVisible, 1, creep)
end

-- LIL SPEWER
local lil_spewer_state = {
    NORMAL = 0,
    WHITE = 1,
    RED = 2,
    BLACK = 3,
    YELLOW = 4
}
local lil_spewer_sprite = {
    "gfx/familiar/lilSpewer/familiar_125_lilspewer.png",
    "gfx/familiar/lilSpewer/familiar_125_lilspewer_white.png",
    "gfx/familiar/lilSpewer/familiar_125_lilspewer_red.png",
    "gfx/familiar/lilSpewer/familiar_125_lilspewer_black.png",
    "gfx/familiar/lilSpewer/familiar_125_lilspewer_yellow.png"
}
function sewnFamiliars:upLilSpewer(lilSpewer)
    local fData = lilSpewer:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        if sewingMachineMod:isUltra(fData) then
            fData.Sewn_lilSpewer_firstState = lilSpewer.State
            fData.Sewn_lilSpewer_secondState = sewnFamiliars:custom_lilSpewer_randomState(lilSpewer)
            
            sewnFamiliars:custom_lilSpewer_updateUltraCostume(lilSpewer)
        end
        fData.Sewn_lilSpewer_fireFrame = -1
        sewnFamiliars:customUpdate(lilSpewer, sewnFamiliars.custom_update_lilSpewer)
    end
end
function sewnFamiliars:custom_lilSpewer_resetState(lilSpewer)
    local fData = lilSpewer:GetData()
    lilSpewer.State = fData.Sewn_lilSpewer_firstState
end
function sewnFamiliars:custom_lilSpewer_randomState(lilSpewer)
    local fData = lilSpewer:GetData()
    local roll = sewingMachineMod.rng:RandomInt(5)
    
    if roll == lilSpewer.State then
        roll = sewnFamiliars:custom_lilSpewer_randomState(lilSpewer)
    end
    return roll
end
function sewnFamiliars:custom_lilSpewer_fireTears(data)
    local lilSpewer = data[1]
    local state = data[2]
    
    local fData = lilSpewer:GetData()
    local velocity = Vector(0, 0)
    local speed = 10
    
    local direction = lilSpewer.Player:GetFireDirection()
    if direction == Direction.NO_DIRECTION then
        direction = lilSpewer.Player:GetHeadDirection()
    end
    
    if direction == Direction.LEFT then
        velocity.X = -speed
    elseif direction == Direction.RIGHT then
        velocity.X = speed
    elseif direction == Direction.UP then
        velocity.Y = -speed
    elseif direction == Direction.DOWN then
        velocity.Y = speed
    end
    
    local color = Color(0,0,0,0,0,0,0)
    local flag = 0
    
    if state == lil_spewer_state.NORMAL or
       state == lil_spewer_state.WHITE or
       state == lil_spewer_state.BLACK then
        if state == lil_spewer_state.NORMAL then
            color = Color(1, 1, 0.95, 1, 20, 10, 0)
        end
        if state == lil_spewer_state.WHITE then
            color = Color(1, 1, 1, 1, 50, 40, 35)
            flag = flag | TearFlags.TEAR_SLOW
        end
        if state == lil_spewer_state.BLACK then
            color = Color(0.1, 0.1, 0.1, 1, 0, 0, 0)
            flag = flag | TearFlags.TEAR_GISH
        end
        for i = 0, 2 do
            local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, lilSpewer.Position, velocity:Rotated(-20 + 20 * i) + lilSpewer.Velocity * 0.5, lilSpewer):ToTear()
            tear:SetColor(color, -1, 1, false, false)
            tear.CollisionDamage = 5
        end
    end
    if state == lil_spewer_state.YELLOW then
        local data = {
            LIL_SPEWER = lilSpewer,
            VELOCITY = velocity + lilSpewer.Velocity * 0.5
        }        
        sewingMachineMod:delayFunction(sewnFamiliars.custom_lilSpewer_fireYellowTear, 1, data)
        sewingMachineMod:delayFunction(sewnFamiliars.custom_lilSpewer_fireYellowTear, 3, data)
        sewingMachineMod:delayFunction(sewnFamiliars.custom_lilSpewer_fireYellowTear, 5, data)
    end
    if state == lil_spewer_state.RED then
        local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLOOD, 0, lilSpewer.Position, velocity + lilSpewer.Velocity * 0.8, lilSpewer):ToTear()
        tear.Scale = 1.25
        tear.CollisionDamage = 15
    end
    
    -- If lil spewer is ultra -> fire tears from his second state
    if sewingMachineMod:isUltra(fData) and data[3] == nil then
        data = {lilSpewer, fData.Sewn_lilSpewer_secondState, true}
        sewingMachineMod:delayFunction(sewnFamiliars.custom_lilSpewer_fireTears, 2, data)
    end
end
function sewnFamiliars:custom_lilSpewer_fireYellowTear(data)
    local lilSpewer = data.LIL_SPEWER
    local velocity = data.VELOCITY
    local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, lilSpewer.Position, velocity, lilSpewer):ToTear()
    tear:SetColor(Color(1, 1, 0, 1, 0, 0, 0), -1, 1, false, false)
    tear.CollisionDamage = 5
end
function sewnFamiliars:custom_lilSpewer_updateUltraCostume(lilSpewer)
    local fData = lilSpewer:GetData()
    local sprite = lilSpewer:GetSprite()
    fData.Sewn_lilSpewer_firstState = lilSpewer.State
    fData.Sewn_lilSpewer_secondState = sewnFamiliars:custom_lilSpewer_randomState(lilSpewer)
    
    sprite:ReplaceSpritesheet(1, lil_spewer_sprite[fData.Sewn_lilSpewer_secondState + 1])
    sprite:LoadGraphics()
end
function sewnFamiliars:custom_update_lilSpewer(lilSpewer)
    local fData = lilSpewer:GetData()
    local sprite = lilSpewer:GetSprite()
    
    
    -- Loop through effects to upgrade creep
    for _, creep in pairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, -1, -1, false, true)) do
        creep = creep:ToEffect()
        if creep.FrameCount == 1 and EntityEffect.IsPlayerCreep(creep.Variant) and creep.SpawnerType == EntityType.ENTITY_FAMILIAR and creep.SpawnerVariant == FamiliarVariant.LIL_SPEWER then
            local cData = creep:GetData()
            
            local multiplier = 1.1
            if sewingMachineMod:isUltra(fData) then
                multiplier = 1.33
            end
            
            if not cData.Sewn_lilSpewer_creepSuper then
                creep.Size = creep.Size * multiplier
                creep.SpriteScale = creep.SpriteScale * multiplier
                creep.CollisionDamage = creep.CollisionDamage * multiplier
                cData.Sewn_lilSpewer_creepSuper = true
            end
        end
    end
    
    
    -- If lil' spewer is firing
    if lilSpewer.FireCooldown == -15 and fData.Sewn_lilSpewer_fireFrame + 1 ~= lilSpewer.FrameCount then
        
        local data = {lilSpewer, lilSpewer.State}
        sewnFamiliars:custom_lilSpewer_fireTears(data)
        
        if sewingMachineMod:isUltra(fData) then
            -- Change his state
            lilSpewer.State = fData.Sewn_lilSpewer_secondState
            -- Reset the cooldown to 0 (ready to fire)
            lilSpewer.FireCooldown = 0
            -- Fire puddle with the new state
            lilSpewer:Shoot()
            --Fire aditionnal tears
            
            fData.Sewn_lilSpewer_fireFrame = lilSpewer.FrameCount
            
            -- On next frame, reset the state of lil' spewer
            sewingMachineMod:delayFunction(sewnFamiliars.custom_lilSpewer_resetState, 1, lilSpewer)
        end
    end
    
    if sewingMachineMod:isUltra(fData) then
        -- If lil spewer change his state (the player use a pill)
        if lilSpewer.FireCooldown > 0 and fData.Sewn_lilSpewer_firstState ~= lilSpewer.State then
            sewnFamiliars:custom_lilSpewer_updateUltraCostume(lilSpewer)
        end
        
        if sprite.FlipX == true then
            sprite:ReplaceSpritesheet(0, lil_spewer_sprite[fData.Sewn_lilSpewer_secondState + 1])
            sprite:LoadGraphics()
        else
            sprite:ReplaceSpritesheet(0, lil_spewer_sprite[fData.Sewn_lilSpewer_firstState + 1])
            sprite:LoadGraphics()
        end
    end
end


-- HALLOWED GROUND
function sewnFamiliars:upHallowedGround(hallowedGround)
    local fData = hallowedGround:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        fData.Sewn_hallowedGround_radius = 45
        if sewingMachineMod:isUltra(fData) then
            fData.Sewn_hallowedGround_radius = 55
        end
        sewnFamiliars:customUpdate(hallowedGround, sewnFamiliars.custom_update_hallowedGround)
        sewnFamiliars:customCache(hallowedGround, sewnFamiliars.custom_cache_hallowedGround)
        sewnFamiliars:customPlayerTakeDamage(hallowedGround, sewnFamiliars.custom_playerTakeDamage_hallowedGround)

        -- Remove hallowed ground from previous update
        sewnFamiliars:custom_hallowedGround_removeAura(hallowedGround)
    end
end
function sewnFamiliars:custom_hallowedGround_removeAura(hallowedGround)
    for _, aura in pairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.HALLOWED_GROUND_PERMANENT_AURA, -1, false, true)) do
        aura:Remove()
    end
end
function sewnFamiliars:custom_update_hallowedGround(hallowedGround)
    local fData = hallowedGround:GetData()
    local player = hallowedGround.Player

    if hallowedGround.State == 1 then
        return
    end

    if fData.Sewn_hallowedGround_effect == nil or not fData.Sewn_hallowedGround_effect:Exists() then
        fData.Sewn_hallowedGround_effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALLOWED_GROUND_PERMANENT_AURA, 0, hallowedGround.Position, v0, hallowedGround):ToEffect()
        if sewingMachineMod:isUltra(fData) then
            fData.Sewn_hallowedGround_effect:GetSprite():Play("Ultra", true)
        end
    end

    -- Aura follow Hallowed Ground
    fData.Sewn_hallowedGround_effect.Position = hallowedGround.Position

    if player and player.Position:DistanceSquared(hallowedGround.Position) <= fData.Sewn_hallowedGround_radius ^2 then
        if fData.Sewn_hallowedGround_playerIsClose ~= true then
            fData.Sewn_hallowedGround_playerIsClose = true
            player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
            player:EvaluateItems()
        end
    else
        if fData.Sewn_hallowedGround_playerIsClose == true then
            fData.Sewn_hallowedGround_playerIsClose = false
            player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
            player:EvaluateItems()
        end
    end

    if sewingMachineMod:isUltra(fData) then
        for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, true)) do
            local familiarData = familiar:GetData()
            familiar = familiar:ToFamiliar()
            if GetPtrHash(familiar) ~= GetPtrHash(hallowedGround) then
                if familiar.Position:DistanceSquared(hallowedGround.Position) <= fData.Sewn_hallowedGround_radius ^2 then
                    if familiarData.Sewn_hallowedGround_isInRadius ~= true then
                        local bonus = familiarData.Sewn_tearRate_bonus or 0
                        familiarData.Sewn_hallowedGround_initialFireRateBonus = bonus
                        local newBonus = bonus + 8 - math.ceil(bonus / 3)
                        if newBonus < 0 then
                            newBonus = 0
                        end
                        sewnFamiliars:setTearRateBonus(familiar, newBonus)
                        familiarData.Sewn_hallowedGround_isInRadius = true
                        familiar:SetColor(Color(1,1,1,1,0,20,50), -1, 1, true, false)
                    end
                else
                    if familiarData.Sewn_hallowedGround_isInRadius == true then
                        sewnFamiliars:setTearRateBonus(familiar, familiarData.Sewn_hallowedGround_initialFireRateBonus)
                        familiarData.Sewn_hallowedGround_isInRadius = false
                        familiar:SetColor(Color(1,1,1,1,0,0,0), -1, 1, true, false)
                    end
                end
            end
        end
    end
end
function sewnFamiliars:custom_cache_hallowedGround(hallowedGround, cacheFlag)
    local fData = hallowedGround:GetData()
    local player = hallowedGround.Player
    if cacheFlag == CacheFlag.CACHE_FIREDELAY then
        if fData.Sewn_hallowedGround_effect ~= nil and fData.Sewn_hallowedGround_playerIsClose == true then
            local fireDelay = player.MaxFireDelay - math.floor(player.MaxFireDelay / 10) - 1
            if sewingMachineMod:isUltra(fData) then
                fireDelay = player.MaxFireDelay - math.ceil(player.MaxFireDelay / 10) - 1
            end
            player.MaxFireDelay = fireDelay
        end
    end
end
function sewnFamiliars:custom_playerTakeDamage_hallowedGround(hallowedGround, dmgSource, dmgAmount, dmgFlags)
    local fData = hallowedGround:GetData()
    fData.Sewn_hallowedGround_playerIsClose = false
    fData.Sewn_hallowedGround_effect = nil
    sewnFamiliars:custom_hallowedGround_removeAura(hallowedGround)
    player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
    player:EvaluateItems() 
end

-- DRY BABY
function sewnFamiliars:upDryBaby(dryBaby)
    local fData = dryBaby:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        sewnFamiliars:customAnimation(dryBaby, sewnFamiliars.custom_animation_dryBaby, ANIMATION_NAMES.HIT)
        sewnFamiliars:customCollision(dryBaby, sewnFamiliars.custom_collision_dryBaby)
    end
end
function sewnFamiliars:custom_animationDash_dryBaby(dryBaby)
    if dryBaby:GetSprite():GetFrame() < 23 then return end
    for i, bullet in pairs(Isaac.FindInRadius(dryBaby.Position, 500, EntityPartition.BULLET)) do
        bullet:Die()
    end
end
function sewnFamiliars:custom_collision_dryBaby(dryBaby, collider)
    if collider.Type == EntityType.ENTITY_PROJECTILE then
        local roll = sewingMachineMod.rng:RandomInt(100)
        local chance = 5
        local sprite = dryBaby:GetSprite()
        
        if sewingMachineMod:isUltra(fData) then
            chance = 25
        end
        if roll < chance then
            sprite:Play("Hit")
        end
    end
end

-- GUPPY'S HAIRBALL
function sewnFamiliars:upGuppysHairball(guppysHairball)
    local fData = guppysHairball:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        sewnFamiliars:customNewRoom(guppysHairball, sewnFamiliars.custom_newRoom_guppysHairball)
        sewnFamiliars:customKillEnemy(guppysHairball, sewnFamiliars.custom_killEnemy_guppysHairball)
    end
end
function sewnFamiliars:custom_newRoom_guppysHairball(guppysHairball, room)
    local fData = guppysHairball:GetData()

    if guppysHairball.SubType < 2 and sewingMachineMod:isUltra(fData) then
        guppysHairball.SubType = 2
    elseif guppysHairball.SubType == 0 then
        guppysHairball.SubType = 1
    end
end
function sewnFamiliars:custom_killEnemy_guppysHairball(guppysHairball, enemy)    
    local fData = guppysHairball:GetData()
    local chance = 60
    local roll = sewingMachineMod.rng:RandomInt(100)
    local amount = 1

    if sewingMachineMod:isUltra(fData) then
        chance = 90
        amount = sewingMachineMod.rng:RandomInt(3) + 1
    end
    if roll < chance then
        for i = 1, amount do
            local velo = Vector(math.random(-25.0, 25.0), math.random(-25.0, 25.0))
            local blueFly = guppysHairball.Player:AddBlueFlies(1, enemy.Position, guppysHairball.Player)
            blueFly.Velocity = velo
        end
    end
end

-- POINTY RIB
function sewnFamiliars:upPointyRib(pointyRib)
    local fData = pointyRib:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        fData.Sewn_pointyRib_colliders = {}
        sewnFamiliars:customCollision(pointyRib, sewnFamiliars.custom_collision_pointyRib)
        sewnFamiliars:customNewRoom(pointyRib, sewnFamiliars.custom_newRoom_pointyRib)
        sewnFamiliars:customKillEnemy(pointyRib, sewnFamiliars.custom_killEnemy_pointyRib)
    end
end
function sewnFamiliars:custom_collision_pointyRib(pointyRib, collider)
    local fData = pointyRib:GetData()
    if not collider:IsVulnerableEnemy() then return end
    
    -- Has a chance to apply bleed to non-boss 
    if not collider:IsBoss() and (fData.Sewn_pointyRib_colliders[GetPtrHash(collider)] == nil or fData.Sewn_pointyRib_colliders[GetPtrHash(collider)] + 60 < collider.FrameCount) then
        local roll = sewingMachineMod.rng:RandomInt(101)
        local chanceBleed = 33
        if sewingMachineMod:isUltra(fData) then
            chanceBleed = 66
        end
        if roll < chanceBleed then
            collider:AddEntityFlags(EntityFlag.FLAG_BLEED_OUT)
        end
        fData.Sewn_pointyRib_colliders[GetPtrHash(collider)] = collider.FrameCount
    end

    -- Take more damage when Ultra
    if sewingMachineMod:isUltra(fData) then
        collider:TakeDamage(pointyRib.Player.Damage * 0.5, DamageFlag.DAMAGE_COUNTDOWN, EntityRef(pointyRib), 5)
    end
end
function sewnFamiliars:custom_newRoom_pointyRib(pointyRib, room)
    local fData = pointyRib:GetData()
    fData.Sewn_pointyRib_colliders = {}
end
function sewnFamiliars:custom_killEnemy_pointyRib(pointyRib, enemy)
    sewnFamiliars:spawnBonesOrbitals(pointyRib, 0, 1)
end


-- SLIPPED RIB
function sewnFamiliars:upSlippedRib(slippedRib)
    local fData = slippedRib:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        fData.Sewn_slippedRib_colliders = {}
        sewnFamiliars:customCollision(slippedRib, sewnFamiliars.custom_collision_slippedRib)
        if sewingMachineMod:isUltra(fData) then
            fData.Sewn_slippedRib_colliders = {}
            sewnFamiliars:customNewRoom(slippedRib, sewnFamiliars.custom_newRoom_slippedRib)
        end
    end
end
function sewnFamiliars:custom_collision_slippedRib(slippedRib, collider)
    local fData = slippedRib:GetData()
    
    if collider:IsVulnerableEnemy() then
        local dmg = math.max(3.5, slippedRib.Player.Damage * 0.75)
        if slippedRib.Player and slippedRib.Player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
            dmg = dmg * 2
        end
        collider:TakeDamage(dmg, DamageFlag.DAMAGE_COUNTDOWN, EntityRef(slippedRib), 5)
    elseif collider.Type == EntityType.ENTITY_PROJECTILE and sewingMachineMod:isUltra(fData) then
        if fData.Sewn_slippedRib_colliders[GetPtrHash(collider)] == nil or fData.Sewn_slippedRib_colliders[GetPtrHash(collider)] + 30 < collider.FrameCount then
            local rollBone = sewingMachineMod.rng:RandomInt(100)
            if rollBone < 20 then
                sewnFamiliars:spawnBonesOrbitals(slippedRib)
            end
        end
    end
end
function sewnFamiliars:custom_newRoom_slippedRib(slippedRib, room)
    local fData = slippedRib:GetData()
    fData.Sewn_slippedRib_colliders = {}
end

-- MILK!
local milkFlavours = { NORMAL = 1, CHOCOLATE = 2, SOY = 3, STRAWBERRY = 4 }
local milkFlavoursSprite = { "gfx/familiar/milk/milk.png", "gfx/familiar/milk/chocolateMilk.png", "gfx/familiar/milk/soyMilk.png", "gfx/familiar/milk/strawberryMilk.png" }
local milkBoosts = { DAMAGE = 1, FIRE_DELAY = 2, SPEED = 3 }
function sewnFamiliars:upMilk(milk)
    local fData = milk:GetData()
    if sewingMachineMod:isSuper(fData) then
        sewnFamiliars:customPlayerTakeDamage(milk, sewnFamiliars.custom_playerTakeDamage_milk)
    elseif sewingMachineMod:isUltra(fData) then
        fData.Sewn_milk_flavour = milkFlavours.NORMAL
        fData.Sewn_milk_boosts = {}
        sewnFamiliars:customNewRoom(milk, sewnFamiliars.custom_newRoom_milk)
        sewnFamiliars:customPlayerTakeDamage(milk, sewnFamiliars.custom_playerTakeDamage_milk)
        sewnFamiliars:customCache(milk, sewnFamiliars.custom_cache_milk)
    end
end
function sewnFamiliars:custom_newRoom_milk(milk, room)
    local fData = milk:GetData()
    local rollFlavour = sewingMachineMod.rng:RandomInt(4) + 1
    local sprite = milk:GetSprite()
    
    fData.Sewn_milk_boosts = {}

    if fData.Sewn_milk_hit == true then
        sewnFamiliars:custom_milk_removeEffects(milk)
    end
    
    fData.Sewn_milk_flavour = rollFlavour
    sprite:ReplaceSpritesheet(0, milkFlavoursSprite[fData.Sewn_milk_flavour])
    sprite:LoadGraphics()
    
    fData.Sewn_milk_hit = nil
end
function sewnFamiliars:custom_playerTakeDamage_milk(milk, amount)
    local fData = milk:GetData()

    sewingMachineMod:delayFunction(sewnFamiliars.custom_milk_setPosition, 2, milk)
    sewingMachineMod:delayFunction(sewnFamiliars.custom_milk_changePuddle, 3, milk)

    if sewingMachineMod:isUltra(fData) then

        fData.Sewn_milk_roomDamage = sewingMachineMod.currentRoom
        
        if fData.Sewn_milk_hit ~= nil then return true end

        sewingMachineMod:delayFunction(sewnFamiliars.custom_milk_applyEffects, 4, milk)

        fData.Sewn_milk_hit = true
    end
end
function sewnFamiliars:custom_cache_milk(milk, cacheFlag)
    local fData = milk:GetData()
    if cacheFlag == CacheFlag.CACHE_FIREDELAY and fData.Sewn_milk_boosts[milkBoosts.FIRE_DELAY] ~= nil then
        milk.Player.MaxFireDelay = fData.Sewn_milk_boosts[milkBoosts.FIRE_DELAY]
    elseif cacheFlag == CacheFlag.CACHE_DAMAGE and fData.Sewn_milk_boosts[milkBoosts.DAMAGE] ~= nil then
        milk.Player.Damage = fData.Sewn_milk_boosts[milkBoosts.DAMAGE]
    elseif cacheFlag == CacheFlag.CACHE_SPEED and fData.Sewn_milk_boosts[milkBoosts.SPEED] ~= nil then
        milk.Player.MoveSpeed = fData.Sewn_milk_boosts[milkBoosts.SPEED]
    end
end
function sewnFamiliars:custom_milk_setPosition(milk)
    local fData = milk:GetData()

    --if fData.Sewn_milk_roomDamage ~= sewingMachineMod.currentRoom then return end

    fData.Sewn_milk_positionOnHit = milk.Position
end
function sewnFamiliars:custom_milk_changePuddle(milk)
    local fData = milk:GetData()

    for _, puddle in pairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_PUDDLE_MILK, -1, false, true)) do
        puddle = puddle:ToEffect()
        if (puddle.Position - fData.Sewn_milk_positionOnHit):LengthSquared() < 5 then
            local newPuddle = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER, 0, puddle.Position, v0, milk):ToEffect()
            
            newPuddle:SetColor(Color(0.5,0.5,0,0,0,0,0),0,0,false,false)
            newPuddle.CollisionDamage = 2

            if sewingMachineMod:isUltra(fData) then
                if fData.Sewn_milk_roomDamage ~= sewingMachineMod.currentRoom then return end
                local puddleSprite = puddle:GetSprite()
                puddleSprite:ReplaceSpritesheet(0, milkFlavoursSprite[fData.Sewn_milk_flavour])
                puddleSprite:LoadGraphics()
            end
        end
    end
end
function sewnFamiliars:custom_milk_applyEffects(milk)
    local fData = milk:GetData()
    
    if fData.Sewn_milk_roomDamage ~= sewingMachineMod.currentRoom then return end
    
    fData.Sewn_milk_boosts[milkBoosts.FIRE_DELAY] = nil
    fData.Sewn_milk_boosts[milkBoosts.DAMAGE] = nil
    fData.Sewn_milk_boosts[milkBoosts.SPEED] = nil

    if fData.Sewn_milk_flavour == milkFlavours.NORMAL then
        fData.Sewn_milk_boosts[milkBoosts.FIRE_DELAY] = milk.Player.MaxFireDelay - 1 - math.floor((milk.Player.MaxFireDelay -1) / 10)
        milk.Player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
    elseif fData.Sewn_milk_flavour == milkFlavours.CHOCOLATE then
        fData.Sewn_milk_boosts[milkBoosts.FIRE_DELAY] = milk.Player.MaxFireDelay + 2
        fData.Sewn_milk_boosts[milkBoosts.DAMAGE] = milk.Player.Damage + 1 + milk.Player.Damage * 0.5
        milk.Player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY)
    elseif fData.Sewn_milk_flavour == milkFlavours.SOY then
        fData.Sewn_milk_boosts[milkBoosts.FIRE_DELAY] = math.ceil((milk.Player.MaxFireDelay + 2) / 2 - 1)
        fData.Sewn_milk_boosts[milkBoosts.DAMAGE] = milk.Player.Damage * 0.7
        milk.Player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY)
    elseif fData.Sewn_milk_flavour == milkFlavours.STRAWBERRY then
        fData.Sewn_milk_boosts[milkBoosts.SPEED] = milk.Player.MoveSpeed * 1.15
        fData.Sewn_milk_boosts[milkBoosts.DAMAGE] = 0.75 + milk.Player.Damage * 1.08
        milk.Player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_SPEED)
    end
    milk.Player:EvaluateItems()
end
function sewnFamiliars:custom_milk_removeEffects(milk)
    local fData = milk:GetData()
    
    if fData.Sewn_milk_flavour == milkFlavours.NORMAL then
        milk.Player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
    elseif fData.Sewn_milk_flavour == milkFlavours.CHOCOLATE then
        milk.Player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY)
    elseif fData.Sewn_milk_flavour == milkFlavours.SOY then
        milk.Player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY)
    elseif fData.Sewn_milk_flavour == milkFlavours.STRAWBERRY then
        milk.Player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY | CacheFlag.CACHE_SPEED)
    end
    milk.Player:EvaluateItems()
end

-- DEPRESSION
function sewnFamiliars:upDepression(depression)
    local fData = depression:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        fData.Sewn_depression_collidersProjectile = {}
        fData.Sewn_depression_counterProjectile = 0
        fData.Sewn_depression_requiredAmountProjectile = 2
        sewnFamiliars:customNewRoom(depression, sewnFamiliars.custom_newRoom_depression)
        sewnFamiliars:customCollision(depression, sewnFamiliars.custom_collision_depression)
        sewnFamiliars:customTearFall(depression, sewnFamiliars.custom_tearFall_depression)
        if sewingMachineMod:isUltra(fData) then
            sewnFamiliars:customUpdate(depression, sewnFamiliars.custom_update_depression)
            fData.Sewn_depression_requiredAmountProjectile = 1
        end
    end
end
function sewnFamiliars:custom_update_depression(depression)
    local fData = depression:GetData()
    for _, creep in pairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL, -1, false, true)) do
        if creep.FrameCount == 0 and creep.SpawnerType == depression.Type and creep.SpawnerVariant == depression.Variant then
            local cData = creep:GetData()
            if not cData.Sewn_creepIsScaled then
                creep.Size = creep.Size * 1.5
                creep.SpriteScale = creep.SpriteScale * 1.5
                creep.CollisionDamage = creep.CollisionDamage * 1.5
                cData.Sewn_creepIsScaled = true
            end
        end
    end
end
function sewnFamiliars:custom_newRoom_depression(depression, room)
    local fData = depression:GetData()
    fData.Sewn_depression_collidersProjectile = {}
end
function sewnFamiliars:custom_collision_depression(depression, collider)
    local fData = depression:GetData()
    if collider.Type == EntityType.ENTITY_PROJECTILE then
        if fData.Sewn_depression_collidersProjectile[GetPtrHash(collider)] == nil then
            fData.Sewn_depression_counterProjectile = fData.Sewn_depression_counterProjectile + 1

            if fData.Sewn_depression_counterProjectile >= fData.Sewn_depression_requiredAmountProjectile then
                sewnFamiliars:custom_depression_fireTears(depression)
                collider:Die()
                fData.Sewn_depression_counterProjectile = 0
            end
            fData.Sewn_depression_collidersProjectile[GetPtrHash(collider)] = true
        end
    end
end
function sewnFamiliars:custom_tearFall_depression(depression, tear)
    Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL, 0, tear.Position, v0, depression)
end
function sewnFamiliars:custom_depression_fireTears(depression)
    local force = 3

    for i = 0, 2, 2 do
        for j = 0, 2, 2 do
            local velocity = Vector(i * force - force, j * force - force)
            local tear = depression:FireProjectile(velocity * 0.1)
            tear.CollisionDamage = 5
            tear.Velocity = velocity
            tear.FallingSpeed = -8
            tear.FallingAcceleration = 0.8
        end
    end

end

-- SAMSON'S CHAINS
function sewnFamiliars:upSamsonsChains(samsonsChains)
    local fData = samsonsChains:GetData()
    if sewingMachineMod:isSuper(fData) or sewingMachineMod:isUltra(fData) then
        sewnFamiliars:customHitEnemy(samsonsChains, sewnFamiliars.custom_hitEnemy_samsonsChains)
        if sewingMachineMod:isUltra(fData) then
            fData.Sewn_samsonsChains_isOrbiting = false
            fData.Sewn_samsonsChains_orbitingFrames = 0
            sewnFamiliars:customUpdate(samsonsChains, sewnFamiliars.custom_update_samsonsChains)
        end
    end
end
function sewnFamiliars:custom_hitEnemy_samsonsChains(samsonsChains, enemy)
    local eData = enemy:GetData()
    if eData.Sewn_samsonsChains_hasTakeFakeDamage == true then
        
    else
        eData.Sewn_samsonsChains_hasTakeFakeDamage = true
        enemy:TakeDamage(math.max(3.5, samsonsChains.Velocity:Length()), DamageFlag.DAMAGE_COUNTDOWN, EntityRef(samsonsChains), 6)
        eData.Sewn_samsonsChains_hasTakeFakeDamage = false
        return false
    end
end
function sewnFamiliars:custom_update_samsonsChains(samsonsChains)
    local fData = samsonsChains:GetData()
    local player = samsonsChains.Player
    local deltaTime = 1 / 30

    ---local isPlayerShooting = player:GetShootingInput():LengthSquared() > 0

    local isPlayerShooting = player:GetFireDirection() ~= Direction.NO_DIRECTION

    -- When Player is firing
    if isPlayerShooting and samsonsChains.FireCooldown == 0 then
        -- First frame where player is firing
        if fData.Sewn_samsonsChains_isOrbiting ~= true then
            
            -- Spawn an additional Samson's Chains
            fData.Sewn_samsonsChains_newChains = Isaac.Spawn(samsonsChains.Type, samsonsChains.Variant, samsonsChains.SubType, samsonsChains.Position, samsonsChains.Velocity, samsonsChains)
            fData.Sewn_samsonsChains_newChains:ClearEntityFlags(EntityFlag.FLAG_APPEAR) -- Disable the "Poof" effect when it appears
            fData.Sewn_samsonsChains_newChains:SetColor(Color(0,0,0,0,0,0,0),0,0,false,false)
            fData.Sewn_samsonsChains_newChains.Visible = false
            fData.Sewn_samsonsChains_newChains.CollisionDamage = 0
            fData.Sewn_samsonsChains_newChains.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
            fData.Sewn_samsonsChains_newChains.GridCollisionClass = GridCollisionClass.COLLISION_NONE
            
            fData.Sewn_samsonsChains_newChains:GetData().Sewn_noUpgrade = true

            fData.Sewn_samsonsChains_isOrbiting = true
        end
        samsonsChains.Velocity = Vector(
            fData.Sewn_samsonsChains_newChains.Position.X + math.cos(samsonsChains.FrameCount * 0.8) * 10,
            fData.Sewn_samsonsChains_newChains.Position.Y + math.sin(samsonsChains.FrameCount * 0.8) * 10) - samsonsChains.Position

        fData.Sewn_samsonsChains_playerFireDirection = player:GetFireDirection()
        fData.Sewn_samsonsChains_orbitingFrames = fData.Sewn_samsonsChains_orbitingFrames + 1
    end
    -- When player isn't firing
    if not isPlayerShooting then
        -- First frame where player stop firing
        if fData.Sewn_samsonsChains_isOrbiting == true then
            if fData.Sewn_samsonsChains_newChains ~= nil then
                fData.Sewn_samsonsChains_newChains:Remove()
                fData.Sewn_samsonsChains_newChains = nil
            end

            samsonsChains.FireCooldown = 30

            -- Throw the ball
            local newVelocity = Vector(0, 0)
            if fData.Sewn_samsonsChains_playerFireDirection == Direction.LEFT then
                newVelocity.X = -1
            elseif fData.Sewn_samsonsChains_playerFireDirection == Direction.UP then
                newVelocity.Y = -1
            elseif fData.Sewn_samsonsChains_playerFireDirection == Direction.RIGHT then
                newVelocity.X = 1
            elseif fData.Sewn_samsonsChains_playerFireDirection == Direction.DOWN then
                newVelocity.Y = 1
            end
            samsonsChains.Velocity = (newVelocity + (player.Position - samsonsChains.Position):Normalized() * 0.1 + player.Velocity * 0.2):Normalized() * math.min(5 + math.ceil(fData.Sewn_samsonsChains_orbitingFrames * 0.33), 35)
            fData.Sewn_samsonsChains_orbitingFrames = 0
            fData.Sewn_samsonsChains_isOrbiting = false
        end
    end
    if samsonsChains.FireCooldown > 0 then
        samsonsChains.FireCooldown = samsonsChains.FireCooldown - 1
    end

    -- Prevent a bug where the ball is stuck
    -- If the ball do not move, and it is far from the player
    if samsonsChains.Velocity:LengthSquared() < 1 and (samsonsChains.Position - player.Position):LengthSquared() > 110 ^2 then
        samsonsChains.Velocity = (player.Position - samsonsChains.Position):Normalized() * 5
    end
end

sewingMachineMod.errFamiliars.Error()