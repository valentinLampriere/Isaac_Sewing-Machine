local Enums = require("sewn_scripts.core.enums")
local Globals = require("sewn_scripts.core.globals")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")

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

CustomCallbacks:AddCallback(Enums.ModCallbacks.FAMILIAR_UPDATE, SewnDoll.OnFamiliarUpdate, Enums.FamiliarVariant.SEWN_DOLL, Sewn_API.Enums.FamiliarLevelFlag.FLAG_NORMAL)

return SewnDoll