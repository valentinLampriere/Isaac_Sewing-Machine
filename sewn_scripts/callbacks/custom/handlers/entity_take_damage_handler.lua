local Enums = require("sewn_scripts.core.enums")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local EntityTakeDamageHandler = { }
EntityTakeDamageHandler.DefaultArguments = { -1, Enums.FamiliarLevelFlag.FLAG_SUPER | Enums.FamiliarLevelFlag.FLAG_ULTRA }

EntityTakeDamageHandler.ID = Enums.ModCallbacks.ENTITY_TAKE_DAMAGE

function EntityTakeDamageHandler:EntityTakeDamage(entity, amount, flags, source, countdown)
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    for _, familiar in ipairs(familiars) do
        familiar = familiar:ToFamiliar()
        for _, callback in ipairs(EntityTakeDamageHandler.RegisteredCallbacks) do
            if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
                if callback:Function(familiar, entity, amount, flags, source, countdown) == false then
                    return false
                end
            end
        end
    end
end

return EntityTakeDamageHandler