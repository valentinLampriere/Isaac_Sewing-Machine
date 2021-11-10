local SpiderModEgg = require("sewn_scripts.entities.effects.spider_mod_egg")

local function MC_POST_EFFECT_INIT(_, effect)
    SpiderModEgg:EffectInit(effect)
end

return MC_POST_EFFECT_INIT