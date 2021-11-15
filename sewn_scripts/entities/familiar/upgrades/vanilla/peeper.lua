local FindCloserNpc = require("sewn_scripts.helpers.find_closer_npc")
local Delay = require("sewn_scripts.helpers.delay")
local ShootTearsCircular = require("sewn_scripts.helpers.shoot_tears_circular")
local Globals = require("sewn_scripts.core.globals")
local CColor = require("sewn_scripts.helpers.ccolor")

local Peeper = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.PEEPER, CollectibleType.COLLECTIBLE_PEEPER)


Peeper.Stats = {
    AmountTears = 5,
    TearDamage = 5,
    TearCooldownMax = 200,
    TearCooldownMin = 60,
}

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.PEEPER,
    "Fire ".. Peeper.Stats.AmountTears .." tears in differents directions every few seconds.#Try to home to close enemies",
    "Spawn an additional Peeper Eye {{Collectible".. CollectibleType.COLLECTIBLE_PEEPER .."}}#The new Peeper Eye is upgraded as well.#With Inner Eye {{Collectible".. CollectibleType.COLLECTIBLE_INNER_EYE .."}}, spawns two Peepers Eyes"
)

function Peeper:OnFamiliarUpgraded(familiar, isPermanentUpgrade)
    local fData = familiar:GetData()
    fData.Sewn_peeper_tearCooldown = familiar:GetDropRNG():RandomInt(Peeper.Stats.TearCooldownMax - Peeper.Stats.TearCooldownMin) + Peeper.Stats.TearCooldownMin
    Sewn_API:AddCrownOffset(familiar, Vector(0, 5))
end

function Peeper:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()

    local center = familiar.Position + familiar.Velocity * 10
    local closerNpc = FindCloserNpc(center, 50)

    if closerNpc ~= nil then
        local velocityMagnitude = familiar.Velocity:Length()
        familiar.Velocity = (familiar.Velocity:Normalized() + (closerNpc.Position - familiar.Position):Normalized() * 0.2):Normalized() * velocityMagnitude
    end

    if Globals.Room:IsClear() then
        return
    end

    if fData.Sewn_peeper_tearCooldown == 0 then
        ShootTearsCircular(familiar, Peeper.Stats.AmountTears, TearVariant.BLOOD, nil, nil, Peeper.Stats.TearDamage, TearFlags.TEAR_SPECTRAL)
        fData.Sewn_peeper_tearCooldown = familiar:GetDropRNG():RandomInt(Peeper.Stats.TearCooldownMax - Peeper.Stats.TearCooldownMin) + Peeper.Stats.TearCooldownMin
    elseif fData.Sewn_peeper_tearCooldown > 0 then
        fData.Sewn_peeper_tearCooldown = fData.Sewn_peeper_tearCooldown - 1
    end
end

function Peeper:OnFamiliarUpgraded_Ultra(familiar, isPermanentUpgrade)
    local fData = familiar:GetData()
    fData.Sewn_peeper_additionalEyes = { }
    fData.Sewn_peeper_hasInnerEye = familiar.Player:HasCollectible(CollectibleType.COLLECTIBLE_INNER_EYE)
    
    Delay:DelayFunction(function()
        familiar.Player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
        familiar.Player:EvaluateItems()
    end, 1)
end

function Peeper:OnFamiliarUpdate_Ultra(familiar)
    local fData = familiar:GetData()
    local hasInnerEye = familiar.Player:HasCollectible(CollectibleType.COLLECTIBLE_INNER_EYE)
    if fData.Sewn_peeper_hasInnerEye ~= hasInnerEye then
        fData.Sewn_peeper_hasInnerEye = hasInnerEye
        
        familiar.Player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
        familiar.Player:EvaluateItems()
    end
end

function Peeper:EvaluateFamiliarCache(familiar, player)
    local fData = familiar:GetData()
    
    local countPeeper = familiar.Player:GetCollectibleNum(CollectibleType.COLLECTIBLE_PEEPER)
    local amountOfAdditionalEyes = fData.Sewn_peeper_hasInnerEye and 2 or 1
    
    local peeperEyesCopies = Isaac.FindByType(familiar.Type, familiar.Variant, 1, false, false)
    for i, additionalEye in ipairs(peeperEyesCopies) do
        additionalEye:Remove()
    end

    familiar.Player:CheckFamiliar(familiar.Variant, countPeeper, familiar:GetDropRNG())

    Delay:DelayFunction(function(_)
        for i = 1, amountOfAdditionalEyes do
            local newPeeper = Isaac.Spawn(familiar.Type, familiar.Variant, 1, familiar.Position, Globals.V0, familiar.Player)
            local newFData = newPeeper:GetData()
            newFData.Sewn_peeper_isAddtionalPeeperEye = true
            newFData.Sewn_noUpgrade = true
            
            Sewn_API:UpFamiliar(newPeeper, Sewn_API.Enums.FamiliarLevel.SUPER)

            --sewnFamiliars:upPeeper(newPeeper)
            Sewn_API:HideCrown(newPeeper, true)
            newPeeper:SetColor(CColor(1,0.6,0.6,0.9), -1, 2, false, false)
            
            table.insert(fData.Sewn_peeper_additionalEyes, newPeeper)
        end
    end)
end
function Peeper:LoseUpgrade(familiar, losePermanentUpgrade)
    familiar.Player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
    familiar.Player:EvaluateItems()
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, Peeper.OnFamiliarUpgraded, FamiliarVariant.PEEPER)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, Peeper.OnFamiliarUpdate, FamiliarVariant.PEEPER)

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_LOSE_UPGRADE, Peeper.LoseUpgrade, FamiliarVariant.PEEPER)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, Peeper.OnFamiliarUpgraded_Ultra, FamiliarVariant.PEEPER, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, Peeper.OnFamiliarUpdate_Ultra, FamiliarVariant.PEEPER, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_EVALUATE_CACHE, Peeper.EvaluateFamiliarCache, FamiliarVariant.PEEPER, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA, CacheFlag.CACHE_FAMILIARS)