local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local Enums = require("sewn_scripts.core.enums")
local GetLoseCollectible = require("sewn_scripts.callbacks.custom.get_lose_collectible")

CustomCallbacks:AddCallback(Enums.ModCallbacks.GET_LOSE_COLLECTIBLE, GetLoseCollectible.LilDelirium, CollectibleType.COLLECTIBLE_LIL_DELIRIUM)
CustomCallbacks:AddCallback(Enums.ModCallbacks.GET_LOSE_COLLECTIBLE, GetLoseCollectible.DollsTaintedHead, Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD)
CustomCallbacks:AddCallback(Enums.ModCallbacks.GET_LOSE_COLLECTIBLE, GetLoseCollectible.DollsPureBody, Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY)