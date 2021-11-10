local LilAbaddonSwirl = require("sewn_scripts.entities.effects.lil_abaddon_swirl")

local function MC_POST_EFFECT_UPDATE(_, effect)
    LilAbaddonSwirl:EffectUpdate(effect)
end

return MC_POST_EFFECT_UPDATE
