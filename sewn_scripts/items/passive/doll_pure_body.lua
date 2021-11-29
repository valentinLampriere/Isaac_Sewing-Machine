local Enums = require("sewn_scripts.core.enums")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local UpgradeManager = require("sewn_scripts.core.upgrade_manager")
local AngelSewingMachine = require("sewn_scripts.entities.slot.sewing_machine.subtype.sewing_machine_angel")

local DollPureBody = { }

DollPureBody.CollectibleID = Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY


DollPureBody.Stats = {
    AngelSewingMachineChance = 20
}

function DollPureBody:GetCollectible(player)
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1)
    for _, familiar in ipairs(familiars) do
        familiar = familiar:ToFamiliar()
        local fData = familiar:GetData()
        if GetPtrHash(player) == GetPtrHash(familiar.Player) then
            UpgradeManager:TryUpgrade(familiar.Variant, Sewn_API:GetLevel(fData), familiar.Player.Index)
        end
    end
    AngelSewingMachine.AppearChance = AngelSewingMachine.AppearChance + DollPureBody.Stats.AngelSewingMachineChance
end

function DollPureBody:LoseCollectible(player)
    AngelSewingMachine.AppearChance = AngelSewingMachine.AppearChance - DollPureBody.Stats.AngelSewingMachineChance
end

function DollPureBody:OnEvaluateCache(player, cacheFlags)
    if cacheFlags & CacheFlag.CACHE_FAMILIARS ~= CacheFlag.CACHE_FAMILIARS then
        return
    end
    if player:HasCollectible(DollPureBody.CollectibleID) then
        if player:HasCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD) then
            player:CheckFamiliar(Enums.FamiliarVariant.DOLL_S_PURE_BODY, 0, player:GetCollectibleRNG(DollPureBody.CollectibleID))
            return
        end
        player:CheckFamiliar(Enums.FamiliarVariant.DOLL_S_PURE_BODY, 1, player:GetCollectibleRNG(DollPureBody.CollectibleID))
        local pureBodies = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, Enums.FamiliarVariant.DOLL_S_PURE_BODY, -1, false, false)
        for _, pureBody in ipairs(pureBodies) do
            pureBody:ToFamiliar():AddToFollowers()
        end
    end
end

function DollPureBody:OnFamiliarUpdate(familiar)
    familiar:FollowParent()
end

CustomCallbacks:AddCallback(Enums.ModCallbacks.FAMILIAR_UPDATE, DollPureBody.OnFamiliarUpdate, Enums.FamiliarVariant.DOLL_S_PURE_BODY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_NORMAL)

return DollPureBody