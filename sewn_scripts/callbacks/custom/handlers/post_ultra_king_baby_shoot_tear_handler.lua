local Enums = require("sewn_scripts.core.enums")

local PostUltraKingBabyShootTearHandler = { }

PostUltraKingBabyShootTearHandler.ID = Enums.ModCallbacks.POST_ULTRA_KING_BABY_SHOOT_TEAR
PostUltraKingBabyShootTearHandler.DefaultArguments = { -1 }

function PostUltraKingBabyShootTearHandler:Evaluate(kingBaby, tear, targetNPC)
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    for _, familiar in ipairs(familiars) do
        familiar = familiar:ToFamiliar()
        if GetPtrHash(kingBaby.Player) == GetPtrHash(familiar.Player) and familiar.IsFollower then
            for _, callback in ipairs(PostUltraKingBabyShootTearHandler.RegisteredCallbacks) do
                if callback.Argument[1] == PostUltraKingBabyShootTearHandler.DefaultArguments[1] or callback.Argument[1] == familiar.Variant then
                    callback:Function(familiar, kingBaby, tear, targetNPC)
                end
            end
        end
    end
end

return PostUltraKingBabyShootTearHandler