local Enums = require("sewn_scripts.core.enums")
local Globals = require("sewn_scripts.core.globals")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local Familiar = require("sewn_scripts.entities.familiar.familiar")

local SewnDoll = { }

function SewnDoll:OnEvaluateCache(player, cacheFlags)
    if cacheFlags & CacheFlag.CACHE_FAMILIARS ~= CacheFlag.CACHE_FAMILIARS then
        return
    end
    if player:HasCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY) and player:HasCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD) then
        player:CheckFamiliar(Enums.FamiliarVariant.SEWN_DOLL, 1, Globals.rng)
    end
    local dolls = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, Enums.FamiliarVariant.SEWN_DOLL, -1, false, false)
    for _, doll in ipairs(dolls) do
        doll:ToFamiliar():AddToFollowers()
    end
end

function SewnDoll:OnFamiliarUpdate(familiar)
    familiar:FollowParent()
end

function SewnDoll:OnFamiliarNewRoom(dollFamiliar)
    local player = dollFamiliar.Player
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    for _, familiar in ipairs(familiars) do
        familiar = familiar:ToFamiliar()
        if familiar.Player and GetPtrHash(familiar.Player) == GetPtrHash(player) then
            Familiar:TemporaryUpgrade(familiar, Enums.FamiliarLevel.ULTRA | Enums.FamiliarLevelModifierFlag.PURE | Enums.FamiliarLevelModifierFlag.TAINTED)
        end
    end
end

CustomCallbacks:AddCallback(Enums.ModCallbacks.FAMILIAR_UPDATE, SewnDoll.OnFamiliarUpdate, Enums.FamiliarVariant.SEWN_DOLL, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ANY)
CustomCallbacks:AddCallback(Enums.ModCallbacks.POST_FAMILIAR_NEW_ROOM, SewnDoll.OnFamiliarNewRoom, Enums.FamiliarVariant.SEWN_DOLL, Enums.FamiliarLevelFlag.FLAG_ANY)

return SewnDoll