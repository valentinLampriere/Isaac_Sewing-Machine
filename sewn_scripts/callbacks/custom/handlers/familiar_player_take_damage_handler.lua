local Enums = require("sewn_scripts.core.enums")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local FamiliarPlayerTakeDamageHandler = { }
FamiliarPlayerTakeDamageHandler.DefaultArguments = { -1, Enums.FamiliarLevelFlag.FLAG_SUPER | Enums.FamiliarLevelFlag.FLAG_ULTRA }

FamiliarPlayerTakeDamageHandler.ID = Enums.ModCallbacks.FAMILIAR_PLAYER_TAKE_DAMAGE

function FamiliarPlayerTakeDamageHandler:PlayerTakeDamage(player, amount, flags, source, countdown)
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    local sustainDamage
    for _, familiar in ipairs(familiars) do
        familiar = familiar:ToFamiliar()
        if GetPtrHash(player) == GetPtrHash(familiar.Player) then
            for _, callback in ipairs(FamiliarPlayerTakeDamageHandler.RegisteredCallbacks) do
                if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
                    local _sustainDamage = callback:Function(familiar, player, flags, source)
                    if _sustainDamage == false then
                        sustainDamage = _sustainDamage
                    end
                end
            end
        end
    end
    return sustainDamage
end

return FamiliarPlayerTakeDamageHandler