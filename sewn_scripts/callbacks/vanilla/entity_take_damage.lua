local CrackedThimble = require("sewn_scripts.items.trinkets.cracked_thimble")
local CustomCallbacksHandler = require("sewn_scripts.callbacks.custom_callbacks_handler")
local Fart = require("sewn_scripts.entities.effects.fart")

function MC_ENTITY_TAKE_DMG(_, entity, amount, flags, source, countdown)
    if entity.Type == EntityType.ENTITY_PLAYER then
        local player = entity:ToPlayer()
        CrackedThimble:OnPlayerTakeDamage(player, flags, source)
        CustomCallbacksHandler:PlayerTakeDamage(player, amount, flags, source, countdown)
    else
        Fart:EntityTakeDamage(entity, amount, flags, source, countdown)
        return CustomCallbacksHandler:EntityTakeDamage(entity, amount, flags, source, countdown)
    end
end

return MC_ENTITY_TAKE_DMG