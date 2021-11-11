local SpiderModEgg = require("sewn_scripts.entities.effects.spider_mod_egg")
local CubeBabyAura = require("sewn_scripts.entities.effects.cube_baby_aura")

local function MC_POST_EFFECT_INIT(_, effect)
    SpiderModEgg:EffectInit(effect)
    CubeBabyAura:EffectInit(effect)
end

return MC_POST_EFFECT_INIT