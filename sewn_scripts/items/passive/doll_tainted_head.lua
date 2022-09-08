local Enums = require("sewn_scripts.core.enums")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local UpgradeManager = require("sewn_scripts.core.upgrade_manager")
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
            UpgradeManager:TryUpgrade(familiar.Variant, Sewn_API:GetLevel(fData), familiar.Player.Index)
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
            return
        end
        player:CheckFamiliar(Enums.FamiliarVariant.DOLL_S_TAINTED_HEAD, 1, player:GetCollectibleRNG(DollTaintedHead.CollectibleID))
    end
end

function DollTaintedHead:OnFamiliarUpdate(familiar)
    familiar:FollowParent()
end
function DollTaintedHead:OnFamiliarInit(familiar)
    familiar:ToFamiliar():AddToFollowers()
end

CustomCallbacks:AddCallback(Enums.ModCallbacks.POST_FAMILIAR_INIT, DollTaintedHead.OnFamiliarInit, Enums.FamiliarVariant.DOLL_S_TAINTED_HEAD)
CustomCallbacks:AddCallback(Enums.ModCallbacks.FAMILIAR_UPDATE, DollTaintedHead.OnFamiliarUpdate, Enums.FamiliarVariant.DOLL_S_TAINTED_HEAD)

return DollTaintedHead