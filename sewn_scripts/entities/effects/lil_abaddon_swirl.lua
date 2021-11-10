local Enums = require("sewn_scripts.core.enums")

local LilAbaddonSwirl = { }

function LilAbaddonSwirl:EffectUpdate(effect)
    if effect.Variant ~= Enums.EffectVariant.LIL_ABADDON_BRIMSTONE_SWIRL then
        return
    end
    local sprite = effect:GetSprite()
    if sprite:IsFinished("Spawn") then
        sprite:Play("Idle")
    end
    if sprite:IsFinished("Death") then
        effect:Remove()
    end
end

return LilAbaddonSwirl