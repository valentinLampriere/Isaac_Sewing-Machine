local Enums = require("sewn_scripts.core.enums")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local FamiliarHitNpcHandler = { }
FamiliarHitNpcHandler.DefaultArguments = { -1, Enums.FamiliarLevelFlag.SUPER | Enums.FamiliarLevelFlag.ULTRA }

FamiliarHitNpcHandler.ID = Enums.ModCallbacks.FAMILIAR_HIT_NPC

function FamiliarHitNpcHandler:EntityTakeDamage(entity, amount, flags, source, countdown)
    if source.Entity == nil or entity:IsVulnerableEnemy() == false then
        return
    end

    local sourceFamiliar
    if source.Type == EntityType.ENTITY_FAMILIAR then
        sourceFamiliar = source.Entity
    elseif source.Entity.Parent ~= nil and source.Entity.Parent.Type == EntityType.ENTITY_FAMILIAR then
        sourceFamiliar = source.Entity.Parent
    end

    if sourceFamiliar ~= nil then
        sourceFamiliar = sourceFamiliar:ToFamiliar()
        for _, callback in ipairs(FamiliarHitNpcHandler.RegisteredCallbacks) do
            if CallbackFamiliarArgument:Check(sourceFamiliar, callback.Argument[1], callback.Argument[2]) then
                callback:Function(sourceFamiliar, entity, amount, flags, source, countdown)
            end
        end
    end
end

return FamiliarHitNpcHandler