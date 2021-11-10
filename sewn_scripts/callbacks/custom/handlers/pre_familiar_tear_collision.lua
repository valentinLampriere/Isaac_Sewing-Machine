local Enums = require("sewn_scripts.core.enums")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local PreFamiliarTearCollision = { }
PreFamiliarTearCollision.DefaultArguments = { -1, Enums.FamiliarLevelFlag.SUPER | Enums.FamiliarLevelFlag.ULTRA }


PreFamiliarTearCollision.ID = Enums.ModCallbacks.PRE_FAMILIAR_TEAR_COLLISION

function PreFamiliarTearCollision:PreTearCollision(tear, collider)
    local familiar = tear.Parent

    -- If tear hasn't been fired from a familiar
    if tear.SpawnerType ~= EntityType.ENTITY_FAMILIAR or familiar == nil then
        return
    end

    familiar = familiar:ToFamiliar()

    for _, callback in ipairs(PreFamiliarTearCollision.RegisteredCallbacks) do
        if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
            local ignoreCollision = callback:Function(familiar, tear, collider)
            if ignoreCollision ~= nil then
                return ignoreCollision
            end
        end
    end
end

return PreFamiliarTearCollision