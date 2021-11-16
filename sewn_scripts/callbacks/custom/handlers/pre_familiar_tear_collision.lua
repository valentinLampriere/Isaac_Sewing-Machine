local Enums = require("sewn_scripts.core.enums")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local PreFamiliarTearCollision = { }
PreFamiliarTearCollision.DefaultArguments = { -1, Enums.FamiliarLevelFlag.FLAG_SUPER | Enums.FamiliarLevelFlag.FLAG_ULTRA }


PreFamiliarTearCollision.ID = Enums.ModCallbacks.PRE_FAMILIAR_TEAR_COLLISION

function PreFamiliarTearCollision:PreTearCollision(tear, collider)
    local familiar = tear.Parent

    if tear.Parent ~= nil or tear.SpawnerEntity ~= nil and tear.SpawnerEntity.Type == EntityType.ENTITY_FAMILIAR then
        familiar = familiar or tear.SpawnerEntity
        familiar = familiar:ToFamiliar()
        if familiar == nil then
            return
        end
        for _, callback in ipairs(PreFamiliarTearCollision.RegisteredCallbacks) do
            if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
                local ignoreCollision = callback:Function(familiar, tear, collider)
                if ignoreCollision ~= nil then
                    return ignoreCollision
                end
            end
        end
    end
    
end

return PreFamiliarTearCollision