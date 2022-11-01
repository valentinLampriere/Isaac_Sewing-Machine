local Enums = require("sewn_scripts.core.enums")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local UpgradeManager = require("sewn_scripts.core.upgrade_manager")
local Familiar = require("sewn_scripts.entities.familiar.familiar")
local DevilSewingMachine = require("sewn_scripts.entities.slot.sewing_machine.subtype.sewing_machine_devil")

local DollTaintedHead = { }

local id = PickupVariant.PICKUP_COLLECTIBLE .. "." .. Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD

DollTaintedHead.CollectibleID = Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD

DollTaintedHead.Stats = {
    DevilSewingMachineChance = 20
}

function DollTaintedHead:GetCollectible(player)
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1)
    for _, familiar in ipairs(familiars) do
        familiar = familiar:ToFamiliar()
        local fData = familiar:GetData()
        if GetPtrHash(player) == GetPtrHash(familiar.Player) then
            --UpgradeManager:TryUpgrade(familiar.Variant, Sewn_API:GetLevel(fData), familiar.Player.Index)
        end
    end
    DevilSewingMachine:AddChance(id, DollTaintedHead.Stats.DevilSewingMachineChance)
end
function DollTaintedHead:LoseCollectible(player)
    DevilSewingMachine:RemoveChance(id)
end

function DollTaintedHead:OnEvaluateCache(player, cacheFlags)
    if cacheFlags & CacheFlag.CACHE_FAMILIARS ~= CacheFlag.CACHE_FAMILIARS then
        return
    end
    if player:HasCollectible(DollTaintedHead.CollectibleID) then
        if player:HasCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY) then
            player:CheckFamiliar(Enums.FamiliarVariant.DOLL_S_TAINTED_HEAD, 0, player:GetCollectibleRNG(DollTaintedHead.CollectibleID))
        else
            player:CheckFamiliar(Enums.FamiliarVariant.DOLL_S_TAINTED_HEAD, 1, player:GetCollectibleRNG(DollTaintedHead.CollectibleID))
            
            local taintedDolls = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, Enums.FamiliarVariant.DOLL_S_TAINTED_HEAD, -1, false, false)
            for _, taintedDoll in ipairs(taintedDolls) do
                taintedDoll:ToFamiliar():AddToFollowers()
            end
        end
    end
end

function DollTaintedHead:OnFamiliarUpdate(familiar)
    familiar:FollowParent()
end

function DollTaintedHead:OnFamiliarNewRoom(dollFamiliar)
    local player = dollFamiliar.Player
    local fData = dollFamiliar:GetData()
    local level = Sewn_API:GetLevel(fData)
    local familiarsLevel = level == Sewn_API.Enums.FamiliarLevel.ULTRA and Enums.FamiliarLevel.SUPER | Enums.FamiliarLevelModifierFlag.TAINTED or Enums.FamiliarLevel.SUPER
    local hasCounterPartDoll = player:HasCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY)
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    for _, familiar in ipairs(familiars) do
        familiar = familiar:ToFamiliar()
        if familiar.Player and GetPtrHash(familiar.Player) == GetPtrHash(player) then
            local fData = familiar:GetData()
            local level = Sewn_API:GetLevel(fData, false)
            if hasCounterPartDoll == false and level == Sewn_API.Enums.FamiliarLevel.NORMAL or
               hasCounterPartDoll == true and level < Sewn_API.Enums.FamiliarLevel.ULTRA then
                Familiar:TemporaryUpgrade(familiar, familiarsLevel)
            end
        end
    end
end

function DollTaintedHead:OnEvaluateFamiliarLevel(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    local player = familiar.Player
    
    local dollstaintedHeads = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, Enums.FamiliarVariant.DOLL_S_TAINTED_HEAD, -1, false, false)
    local dolltaintedHead = dollstaintedHeads[1]
    if dolltaintedHead then
        dolltaintedHead = dolltaintedHead:ToFamiliar()
        if dolltaintedHead.Player and GetPtrHash(dolltaintedHead.Player) == GetPtrHash(player) then
            local _fData = dolltaintedHead:GetData()
            local _level = Sewn_API:GetLevel(_fData, false)
            if Sewn_API:IsUltra(_level) then
                UpgradeManager:UpFamiliar(familiar, Sewn_API.Enums.FamiliarLevel.SUPER, Sewn_API.Enums.FamiliarLevelModifierFlag.TAINTED)
            else
                UpgradeManager:UpFamiliar(familiar, Sewn_API.Enums.FamiliarLevel.SUPER)
            end
        end
    end
end

CustomCallbacks:AddCallback(Enums.ModCallbacks.FAMILIAR_UPDATE, DollTaintedHead.OnFamiliarUpdate, Enums.FamiliarVariant.DOLL_S_TAINTED_HEAD, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ANY)
CustomCallbacks:AddCallback(Enums.ModCallbacks.POST_FAMILIAR_NEW_ROOM, DollTaintedHead.OnFamiliarNewRoom, Enums.FamiliarVariant.DOLL_S_TAINTED_HEAD, Enums.FamiliarLevelFlag.FLAG_ANY)
CustomCallbacks:AddCallback(Enums.ModCallbacks.ON_EVALUATE_FAMILIAR_LEVEL, DollTaintedHead.OnEvaluateFamiliarLevel)


Sewn_API:AddRerollCrownPeventer(Enums.FamiliarVariant.DOLL_S_TAINTED_HEAD)

return DollTaintedHead