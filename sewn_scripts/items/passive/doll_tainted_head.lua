local Enums = require("sewn_scripts.core.enums")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local UpgradeManager = require("sewn_scripts.core.upgrade_manager")
local DevilSewingMachine = require("sewn_scripts.entities.slot.sewing_machine.subtype.sewing_machine_devil")

local DollTaintedHead = { }

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
    DevilSewingMachine.AppearChance = DevilSewingMachine.AppearChance + DollTaintedHead.Stats.DevilSewingMachineChance
end
function DollTaintedHead:LoseCollectible(player)
    DevilSewingMachine.AppearChance = DevilSewingMachine.AppearChance - DollTaintedHead.Stats.DevilSewingMachineChance
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
        local taintedHeads = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, Enums.FamiliarVariant.DOLL_S_TAINTED_HEAD, -1, false, false)
        for _, taintedHead in ipairs(taintedHeads) do
            taintedHead:ToFamiliar():AddToFollowers()
        end
    end
end

function DollTaintedHead:OnFamiliarUpdate(familiar)
    familiar:FollowParent()
end

CustomCallbacks:AddCallback(Enums.ModCallbacks.FAMILIAR_UPDATE, DollTaintedHead.OnFamiliarUpdate, Enums.FamiliarVariant.DOLL_S_TAINTED_HEAD, Sewn_API.Enums.FamiliarLevelFlag.FLAG_NORMAL)

return DollTaintedHead