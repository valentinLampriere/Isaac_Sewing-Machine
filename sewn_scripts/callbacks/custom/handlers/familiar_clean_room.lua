local Enums = require("sewn_scripts.core.enums")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local FamiliarCleanRoom = { }
FamiliarCleanRoom.DefaultArguments = { -1, Enums.FamiliarLevelFlag.FLAG_SUPER | Enums.FamiliarLevelFlag.FLAG_ULTRA }

FamiliarCleanRoom.ID = Enums.ModCallbacks.FAMILIAR_CLEAN_ROOM

function FamiliarCleanRoom:PreSpawnCleanAward(rng, spawnPosition)
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    for _, familiar in ipairs(familiars) do
        familiar = familiar:ToFamiliar()
        for _, callback in ipairs(FamiliarCleanRoom.RegisteredCallbacks) do
            if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
                callback:Function(familiar)
            end
        end
    end
end

return FamiliarCleanRoom