local Enums = require("sewn_scripts.core.enums")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local UpgradeManager = require("sewn_scripts.core.upgrade_manager")
local Familiar = require("sewn_scripts.entities.familiar.familiar")
local AngelSewingMachine = require("sewn_scripts.entities.slot.sewing_machine.subtype.sewing_machine_angel")

local DollPureBody = { }

DollPureBody.CollectibleID = Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY

local id = PickupVariant.PICKUP_COLLECTIBLE .. "." .. Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY

DollPureBody.Stats = {
    AngelSewingMachineChance = 20
}

function DollPureBody:GetCollectible(player)
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1)
    for _, familiar in ipairs(familiars) do
        familiar = familiar:ToFamiliar()
        local fData = familiar:GetData()
        if GetPtrHash(player) == GetPtrHash(familiar.Player) then
            --UpgradeManager:TryUpgrade(familiar.Variant, Sewn_API:GetLevel(fData), familiar.Player.Index)
        end
    end
    AngelSewingMachine:AddChance(id, DollPureBody.Stats.AngelSewingMachineChance)
end

function DollPureBody:LoseCollectible(player)
    AngelSewingMachine:RemoveChance(id)
end

function DollPureBody:OnEvaluateCache(player, cacheFlags)
    if cacheFlags & CacheFlag.CACHE_FAMILIARS ~= CacheFlag.CACHE_FAMILIARS then
        return
    end
    if player:HasCollectible(DollPureBody.CollectibleID) then
        if player:HasCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD) then
            player:CheckFamiliar(Enums.FamiliarVariant.DOLL_S_PURE_BODY, 0, player:GetCollectibleRNG(DollPureBody.CollectibleID))
            return
        else
            player:CheckFamiliar(Enums.FamiliarVariant.DOLL_S_PURE_BODY, 1, player:GetCollectibleRNG(DollPureBody.CollectibleID))
            
            local pureDolls = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, Enums.FamiliarVariant.DOLL_S_PURE_BODY, -1, false, false)
            for _, pureDoll in ipairs(pureDolls) do
                pureDoll:ToFamiliar():AddToFollowers()
            end
        end
    end
end

function DollPureBody:OnFamiliarUpdate(familiar)
    familiar:FollowParent()
end

function DollPureBody:OnFamiliarNewRoom(dollFamiliar)
    local player = dollFamiliar.Player
    local fData = dollFamiliar:GetData()
    local level = Sewn_API:GetLevel(fData)
    local familiarsLevel = level == Sewn_API.Enums.FamiliarLevel.ULTRA and Enums.FamiliarLevel.SUPER | Enums.FamiliarLevelModifierFlag.PURE or Enums.FamiliarLevel.SUPER
    local hasCounterPartDoll = player:HasCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD)
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    for _, familiar in ipairs(familiars) do
        familiar = familiar:ToFamiliar()
        if familiar.Player and GetPtrHash(familiar.Player) == GetPtrHash(player) then
            local _fData = familiar:GetData()
            local _level = Sewn_API:GetLevel(_fData, false)
            if hasCounterPartDoll == false and _level == Sewn_API.Enums.FamiliarLevel.NORMAL or
               hasCounterPartDoll == true and _level < Sewn_API.Enums.FamiliarLevel.ULTRA then
                Familiar:TemporaryUpgrade(familiar, familiarsLevel)
            end
        end
    end
end

CustomCallbacks:AddCallback(Enums.ModCallbacks.FAMILIAR_UPDATE, DollPureBody.OnFamiliarUpdate, Enums.FamiliarVariant.DOLL_S_PURE_BODY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ANY)
CustomCallbacks:AddCallback(Enums.ModCallbacks.POST_FAMILIAR_NEW_ROOM, DollPureBody.OnFamiliarNewRoom, Enums.FamiliarVariant.DOLL_S_PURE_BODY, Enums.FamiliarLevelFlag.FLAG_ANY)

Sewn_API:AddRerollCrownPeventer(Enums.FamiliarVariant.DOLL_S_PURE_BODY)

return DollPureBody