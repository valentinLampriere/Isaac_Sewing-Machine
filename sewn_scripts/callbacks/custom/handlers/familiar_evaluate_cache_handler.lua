local Enums = require("sewn_scripts.core.enums")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local FamiliarEvaluateCacheHandler = { }
FamiliarEvaluateCacheHandler.DefaultArguments = { -1, Enums.FamiliarLevelFlag.FLAG_SUPER | Enums.FamiliarLevelFlag.FLAG_ULTRA }

FamiliarEvaluateCacheHandler.ID = Enums.ModCallbacks.FAMILIAR_EVALUATE_CACHE

function FamiliarEvaluateCacheHandler:EvaluateCache(player, cacheFlag)
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    for _, familiar in ipairs(familiars) do
        local fData = familiar:GetData()
        familiar = familiar:ToFamiliar()
        if fData.Sewn_Init ~= nil and GetPtrHash(familiar.Player) == GetPtrHash(player) then
            for _, callback in ipairs(FamiliarEvaluateCacheHandler.RegisteredCallbacks) do
                if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
                    if callback.Argument[3] == nil or callback.Argument[3] == cacheFlag then
                        callback:Function(familiar, cacheFlag)
                    end
                end
            end
        end
    end
end

return FamiliarEvaluateCacheHandler