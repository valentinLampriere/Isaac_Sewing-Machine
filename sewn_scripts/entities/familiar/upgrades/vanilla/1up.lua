local Globals = require("sewn_scripts.core.globals")
local CColor = require("sewn_scripts.helpers.ccolor")
local Delay = require("sewn_scripts.helpers.delay")
local SewnMod = require("sewn_scripts.sewn_mod")

local OneUp = { }

local HasMagicMushroom = {
    YES = true,
    NO = false
}

OneUp.Stats = {
    BonusFlatDamage = {
        [HasMagicMushroom.YES] = 0.1,
        [HasMagicMushroom.NO] = 0.1
    },
    BonusDamage = {
        [HasMagicMushroom.YES] = 1,
        [HasMagicMushroom.NO] = 1.33
    },
    BonusSize = {
        [HasMagicMushroom.YES] = 1,
        [HasMagicMushroom.NO] = 1.2
    }
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.ONE_UP, CollectibleType.COLLECTIBLE_1UP)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.ONE_UP,
    "{{ArrowUp}} Extends the Bleed duration. Bosses are not affected.",
    "When an enemy dies while bleeding, spawn a large blood puddle. Also have a chance to spawn half a heart.#{{ArrowUp}} Extends the Bleed duration", nil, "Mom's Razor"
)

local function CheckPlayerRespawnFromOneUp(familiar, previousExtraLives)
    local player = familiar.Player
    local pData = player:GetData()
    local extraLives = player:GetExtraLives()
    if previousExtraLives == extraLives + 1 then
        local pData = player:GetData()

        --player:AddMaxHearts(2, true)
        --player:AddHearts(24)
        pData.Sewn_1up_hasMagicMushroomEffect = true
        --player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_SIZE)
        --player:EvaluateItems()

        if REPENTANCE then
            player:UseActiveItem(CollectibleType.COLLECTIBLE_MEGA_MUSH)
        end
    end
    pData.Sewn_1up_playerIsDead = false
end

function OneUp:OnUpdate(familiar)
    local player = familiar.Player
    local pData = player:GetData()
    local extraLives = player:GetExtraLives()
    local hasSoulOfLazarus = false
    if REPENTANCE then
        hasSoulOfLazarus = player:GetCard(0) == Card.CARD_SOUL_LAZARUS
        hasSoulOfLazarus = hasSoulOfLazarus or player:GetCard(1) == Card.CARD_SOUL_LAZARUS
    end
    
    if hasSoulOfLazarus == false then
        if player:IsDead() and pData.Sewn_1up_playerIsDead ~= true then
            local sprite = player:GetSprite()
            local actualFrame = sprite:GetFrame()
            sprite:SetLastFrame()
            local animationLength = sprite:GetFrame()
            sprite:SetFrame(actualFrame)
            Delay:DelayFunction(function ()
                player:UseCard(Card.CARD_SOUL_LAZARUS, UseFlag.USE_NOANIM | UseFlag.USE_NOCOSTUME | UseFlag.USE_ALLOWNONMAIN | UseFlag.USE_NOANNOUNCER)
                player:RemoveCollectible(CollectibleType.COLLECTIBLE_1UP, false, nil, false)
            end, animationLength - 1)
            pData.Sewn_1up_playerIsDead = true
        end
        
        Delay:DelayFunction(CheckPlayerRespawnFromOneUp, 0, true, familiar, extraLives)
    end
end

function OneUp:EvaluateCache(player, cacheFlag)
    local pData = player:GetData()

    if pData.Sewn_1up_hasMagicMushroomEffect == true then
        local hasMagicMushroom = player:HasCollectible(CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM)
        if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage + OneUp.Stats.BonusFlatDamage[hasMagicMushroom]
            player.Damage = player.Damage * OneUp.Stats.BonusDamage[hasMagicMushroom]
        elseif cacheFlag & CacheFlag.CACHE_SIZE == CacheFlag.CACHE_SIZE then
            local size = OneUp.Stats.BonusSize[hasMagicMushroom]
            player.SpriteScale = player.SpriteScale * Vector(size, size)
        end
    end
end

function OneUp:OnUpgrade(familiar, isPermanentUpgrade)
    local sprite = familiar:GetSprite()
    sprite:Load("gfx/003.041_1up_super.anm2", true)
    sprite:Play("Idle")

    Sewn_API:AddCrownOffset(familiar, Vector(0, 8))
end

function OneUp:OnLoseUpgrade(familiar, losePermanentUpgrade)
    local sprite = familiar:GetSprite()
    sprite:Load("gfx/003.041_1up.anm2", true)
    sprite:Play("Idle")
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, OneUp.OnUpgrade, FamiliarVariant.ONE_UP)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_LOSE_UPGRADE, OneUp.OnLoseUpgrade, FamiliarVariant.ONE_UP)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, OneUp.OnUpdate, FamiliarVariant.ONE_UP)
SewnMod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, OneUp.EvaluateCache)