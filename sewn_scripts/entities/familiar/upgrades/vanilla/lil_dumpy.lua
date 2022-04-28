local Globals = require("sewn_scripts.core.globals")
local Enums = require("sewn_scripts.core.enums")
local Delay = require("sewn_scripts.helpers.delay")
local ShootTearsCircular = require("sewn_scripts.helpers.shoot_tears_circular")

local LilDumpy = { }

local defaultFartRadius = 85

LilDumpy.DumpiesVariant = {
    DUMPLING = 0,
    SKINLING = 1,
    SCABLING = 2,
    SCORCHLING = 3,
    DROPLING = 4,
    FROSTLING = 5,
}

local function Frostling_clearNpcIceFlag(npc)
    if npc:HasEntityFlags(EntityFlag.FLAG_KNOCKED_BACK) == false then
        npc:ClearEntityFlags(EntityFlag.FLAG_ICE)
    else
        Delay:DelayFunction(Frostling_clearNpcIceFlag, 1, true, npc)
    end
end

LilDumpy.Dumpies = {
    [LilDumpy.DumpiesVariant.DUMPLING] = {
        GFX = "gfx/familiar/lilDumpy/dumpling.png"
    },
    [LilDumpy.DumpiesVariant.SKINLING] = {
        GFX = "gfx/familiar/lilDumpy/skinling.png",
        OnFart = function (familiar, fart)
            Globals.Game:Fart(fart.Position, nil, familiar, nil, 0)
            fart:Remove()
        end,
        EvaluateWeight = function (familiar)
            return 0.8
        end
    },
    [LilDumpy.DumpiesVariant.SCABLING] = {
        GFX = "gfx/familiar/lilDumpy/scabling.png",
        OnFart = function (familiar, fart)
            ShootTearsCircular(familiar, 6, TearVariant.BLOOD, nil, 6, 5)
        end,
    },
    [LilDumpy.DumpiesVariant.SCORCHLING] = {
        GFX = "gfx/familiar/lilDumpy/scorchling.png",
        OnFart = function (familiar, fart)
            local flame = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.RED_CANDLE_FLAME, 0, fart.Position, Globals.V0, familiar.Player):ToEffect()
            flame.CollisionDamage = 15
        end,
        OnCollision = function (familiar, collider)
            local fData = familiar:GetData()
            if familiar.State == 0 or fData.Sewn_lilDumpy_finishProjection == true then
                return
            end
            
            if collider:HasEntityFlags(EntityFlag.FLAG_BURN) == false and collider:IsVulnerableEnemy() then
                local burnDuration = math.floor(familiar.Velocity:LengthSquared())
                if burnDuration > 0 then
                    collider:AddBurn(EntityRef(familiar), burnDuration, 1)
                end
            end
        end,
        EvaluateWeight = function (familiar)
            local defaultWeight = LilDumpy.Stats.Default.EvaluateWeight(familiar)
            return DumplingsMod == nil and defaultWeight * 0.5 or defaultWeight
        end
    },
    [LilDumpy.DumpiesVariant.DROPLING] = {
        GFX = "gfx/familiar/lilDumpy/dropling.png",
        OnRest = function (familiar)
            local rng = familiar:GetDropRNG()
            local roll = rng:RandomFloat() * familiar.Velocity:LengthSquared() * 0.01
            roll = math.floor(roll)
            for i = 1, roll do
                local randomOffset = Vector(rng:RandomFloat() * 3, rng:RandomFloat() * 3)
                local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, familiar.Position, -familiar.Velocity * 0.4 + randomOffset, familiar):ToTear()
                tear.Scale = 0.8
            end
        end,
        EvaluateWeight = function (familiar)
            return 0.8
        end
    },
    [LilDumpy.DumpiesVariant.FROSTLING] = {
        GFX = "gfx/familiar/lilDumpy/frostling.png",
        OnFart = function (familiar, fart)
            local npcs = Isaac.FindInRadius(fart.Position, defaultFartRadius, EntityPartition.ENEMY)
            for _, npc in ipairs(npcs) do
                if npc:IsVulnerableEnemy() then
                    npc:AddEntityFlags(EntityFlag.FLAG_ICE)
                    Delay:DelayFunction(Frostling_clearNpcIceFlag, 1, true, npc)
                end
            end
        end,
        EvaluateWeight = function (familiar)
            return 0.8
        end,
        OnRestStart = function (familiar)
            local fData = familiar:GetData()
            fData.Sewn_lilDumpy_frostling_aura = Isaac.Spawn(EntityType.ENTITY_EFFECT, Enums.EffectVariant.CUBE_BABY_AURA, 0, familiar.Position - Vector(0, 10), Vector.Zero, familiar):ToEffect()
            fData.Sewn_lilDumpy_frostling_aura.Scale = 0.75
            fData.Sewn_lilDumpy_frostling_aura.SpriteScale = Vector(0.75, 0.75)
        end,
        OnRest = function (familiar)
            local fData = familiar:GetData()
            if fData.Sewn_lilDumpy_frostling_aura ~= nil then
                fData.Sewn_lilDumpy_frostling_aura.Position = familiar.Position - Vector(0, 10)
                fData.Sewn_lilDumpy_frostling_aura.Velocity = familiar.Velocity
            end
        end,
        OnRestEnd = function (familiar)
            local fData = familiar:GetData()
            if fData.Sewn_lilDumpy_frostling_aura ~= nil then
                fData.Sewn_lilDumpy_frostling_aura:Remove()
                fData.Sewn_lilDumpy_frostling_aura = nil
            end
        end
    },
}

LilDumpy.Stats = {
    AutoReturnCooldownMax = 240,
    AutoReturnCooldownMin = 90,
    Default = {
        EvaluateWeight = function (familiar) return 1 end
    }
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.LIL_DUMPY, CollectibleType.COLLECTIBLE_LIL_DUMPY)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.LIL_DUMPY,
    "Turn Lil Dumpy to different variants with unique effects",
    "Return to the player after a random amount of seconds, even if the player is far away", nil, "Lil Dumpy"
)
Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.LIL_DUMPY,
    "Lil Dumpy gains differents variants version of himself, each of them have a unique effect based on Antibirth's Dumplings monsters.#There are additional variants which are based on the Mod \"Dumplings!\" and which can only appear while the mod is enabled.#Variants have different weight which affect how often each variants are choosen."
)

local function RollDumpling(familiar)
    local weightSum = 0
    local rng = familiar:GetDropRNG()

    for variant, dumpling in pairs(LilDumpy.Dumpies) do
        local evaluateWeightFunction = dumpling.EvaluateWeight or LilDumpy.Stats.Default.EvaluateWeight
        local dumplingWeight = evaluateWeightFunction(familiar)
        weightSum = weightSum + dumplingWeight
    end

    local roll = rng:RandomFloat() * weightSum

    for variant, dumpling in pairs(LilDumpy.Dumpies) do
        local evaluateWeightFunction = dumpling.EvaluateWeight or LilDumpy.Stats.Default.EvaluateWeight
        local dumplingWeight = evaluateWeightFunction(familiar)
        roll = roll - dumplingWeight

        if roll <= 0 then
            return variant
        end
    end

    error("Can't roll a dumpling variant")
    return 0
end

local function ChangeDumpling(familiar, variant)
    local fData = familiar:GetData()
    local dumplingVariant = variant or RollDumpling(familiar)
    
    if familiar.SubType == dumplingVariant then
        -- Does nothing, we roll the same variant.
        return
    end

    familiar.SubType = dumplingVariant

    LilDumpy:InitSprite(familiar)
end

function LilDumpy:OnFamiliarInit(familiar)
    local fData = familiar:GetData()

    ChangeDumpling(familiar)

    fData.Sewn_lilDumpy_sleepTimer = 0
    fData.Sewn_lilDumpy_state = 0
    fData.Sewn_lilDumpy_cooldown = 0
    fData.Sewn_lilDumpy_finishProjection = false

    Sewn_API:AddCrownOffset(familiar, Vector(0, 10))
end

function LilDumpy:OnFamiliarLoseUpgrade(familiar, losePermanentUpgrade)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    if level == Sewn_API.Enums.FamiliarLevel.NORMAL then
        ChangeDumpling(familiar, LilDumpy.DumpiesVariant.DUMPLING)
    end
end

function LilDumpy:OnFamiliarNewRoom(familiar)
    ChangeDumpling(familiar)
end

function LilDumpy:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()
    local sprite = familiar:GetSprite()

    local dumpy = LilDumpy.Dumpies[familiar.SubType]

    -- Track when the familiar farts.
    if sprite:IsPlaying("Fart") and sprite:GetFrame() == 0 then
        local farts = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.FART, -1, false, false)
        
        for _, fart in ipairs(farts) do
            if fart.FrameCount == 0 then
                if dumpy.OnFart ~= nil then
                    dumpy.OnFart(familiar, fart:ToEffect())
                end
            end
        end
    end

    -- Check if familiar change state.
    if familiar.State == 0 and fData.Sewn_lilDumpy_state == 1 then
        fData.Sewn_lilDumpy_state = 0
        fData.Sewn_lilDumpy_finishProjection = false
        if dumpy.OnRestEnd ~= nil then
            dumpy.OnRestEnd(familiar)
        end
    elseif familiar.State == 1 then
        if fData.Sewn_lilDumpy_state == 0 then
            fData.Sewn_lilDumpy_sleepTimer = 0
            fData.Sewn_lilDumpy_state = 1
            fData.Sewn_lilDumpy_cooldown = familiar:GetDropRNG():RandomInt(LilDumpy.Stats.AutoReturnCooldownMax - LilDumpy.Stats.AutoReturnCooldownMin) + LilDumpy.Stats.AutoReturnCooldownMin
            if dumpy.OnRestStart ~= nil then
                dumpy.OnRestStart(familiar)
            end
        end

        if fData.Sewn_lilDumpy_finishProjection == false and familiar.Velocity:LengthSquared() < 1 then
            fData.Sewn_lilDumpy_finishProjection = true
        end

        if dumpy.OnRest ~= nil then
            dumpy.OnRest(familiar)
        end
        
        fData.Sewn_lilDumpy_sleepTimer = fData.Sewn_lilDumpy_sleepTimer + 1

        if Sewn_API:IsUltra(fData) and fData.Sewn_lilDumpy_sleepTimer >= fData.Sewn_lilDumpy_cooldown then
            familiar.State = 0
        end
    end
end

function LilDumpy:OnFamiliarCollision(familiar, collider)
    local fData = familiar:GetData()

    local dumpy = LilDumpy.Dumpies[familiar.SubType]

    if dumpy.OnCollision ~= nil then
        dumpy.OnCollision(familiar, collider)
    end
end

function LilDumpy:InitSprite(familiar)
    local sprite = familiar:GetSprite()
    sprite:ReplaceSpritesheet(0, LilDumpy.Dumpies[familiar.SubType].GFX)
    sprite:LoadGraphics()
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_INIT, LilDumpy.InitSprite, FamiliarVariant.LIL_DUMPY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ANY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_INIT, LilDumpy.OnFamiliarInit, FamiliarVariant.LIL_DUMPY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, LilDumpy.OnFamiliarInit, FamiliarVariant.LIL_DUMPY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_LOSE_UPGRADE, LilDumpy.OnFamiliarLoseUpgrade, FamiliarVariant.LIL_DUMPY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, LilDumpy.OnFamiliarUpdate, FamiliarVariant.LIL_DUMPY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_NEW_ROOM, LilDumpy.OnFamiliarNewRoom, FamiliarVariant.LIL_DUMPY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.PRE_FAMILIAR_COLLISION, LilDumpy.OnFamiliarCollision, FamiliarVariant.LIL_DUMPY)