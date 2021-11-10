local Enums = require("sewn_scripts.core.enums")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local CallbackFamiliarArgument = require("sewn_scripts.helpers.callback_familiar_argument")

local FamiliarKillNpcHandler = { }
FamiliarKillNpcHandler.DefaultArguments = { -1, Enums.FamiliarLevelFlag.FLAG_SUPER | Enums.FamiliarLevelFlag.FLAG_ULTRA }

FamiliarKillNpcHandler.ID = Enums.ModCallbacks.FAMILIAR_KILL_NPC

function FamiliarKillNpcHandler:FamiliarHitEnemy(familiar, entity, amount, flags, source, countdown)
    if entity.HitPoints - amount <= 0 then
        for _, callback in ipairs(FamiliarKillNpcHandler.RegisteredCallbacks) do
            if CallbackFamiliarArgument:Check(familiar, callback.Argument[1], callback.Argument[2]) then
                callback:Function(familiar, entity)
            end
        end
    end
end

function FamiliarKillNpcHandler:Init()
    CustomCallbacks:AddCallback(Enums.ModCallbacks.FAMILIAR_HIT_NPC, FamiliarKillNpcHandler.FamiliarHitEnemy)
end

return FamiliarKillNpcHandler