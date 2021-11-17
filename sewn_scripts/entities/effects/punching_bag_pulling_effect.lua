local Enums = require("sewn_scripts.core.enums")
local Globals = require("sewn_scripts.core.globals")

local PunchingBagPullingEffect = { }

function PunchingBagPullingEffect:EffectInit(effect)
    if effect.Variant ~= Enums.EffectVariant.PUNCHING_BAG_PULLING_EFFECT then
        return
    end
end

function PunchingBagPullingEffect:EffectUpdate(effect)
    if effect.Variant ~= Enums.EffectVariant.PUNCHING_BAG_PULLING_EFFECT then
        return
    end

    if effect.Timeout == 0 then
        effect:Remove()
        return
    end

    for _, npc in ipairs(Isaac.FindInRadius(effect.Position, effect.Size, EntityPartition.ENEMY)) do
        local direction = (effect.Position - npc.Position):Normalized()
        local distance = npc.Position:Distance(effect.Position)
        if npc:IsFlying() or Globals.Room:CheckLine(npc.Position, effect.Position, 0, 0, false, false) then
            if npc.Type ~= EntityType.ENTITY_BOMBDROP then
                npc.Position = npc.Position + direction * (effect.Size / (distance + 2.5))
            end
        end
    end
    for _, bullet in ipairs(Isaac.FindInRadius(effect.Position, effect.Size, EntityPartition.BULLET)) do
        local direction = (effect.Position - bullet.Position):Normalized()
        local velocityMagnitude = bullet.Velocity:Length()
        local newVelocity = bullet.Velocity:Normalized() * 0.7 + direction:Normalized() * 0.3
        bullet.Velocity = newVelocity:Normalized() * velocityMagnitude
    end
end

return PunchingBagPullingEffect