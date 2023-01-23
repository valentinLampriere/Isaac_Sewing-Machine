local Enums = require("sewn_scripts.core.enums")

local PostUltraKingBabyFireTearHandler = { }

PostUltraKingBabyFireTearHandler.ID = Enums.ModCallbacks.POST_ULTRA_KING_BABY_FIRE_TEAR
PostUltraKingBabyFireTearHandler.DefaultArguments = { -1 }

function PostUltraKingBabyFireTearHandler:Evaluate(kingBaby, tear)
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    for _, familiar in ipairs(familiars) do
        familiar = familiar:ToFamiliar()
        if GetPtrHash(kingBaby.Player) == GetPtrHash(familiar.Player) and familiar.IsFollower then
            for _, callback in ipairs(PostUltraKingBabyFireTearHandler.RegisteredCallbacks) do
                if callback.Argument[1] == PostUltraKingBabyFireTearHandler.DefaultArguments[1] or callback.Argument[1] == familiar.Variant then
                    callback:Function(familiar, kingBaby, tear)
                end
            end
        end
    end
end

return PostUltraKingBabyFireTearHandler