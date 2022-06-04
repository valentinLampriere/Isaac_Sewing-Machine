local SpiderModEgg = require("sewn_scripts.entities.effects.spider_mod_egg")
local CubeBabyAura = require("sewn_scripts.entities.effects.cube_baby_aura")
local BombBagPowder = require("sewn_scripts.entities.effects.bomb_bag_powder")
local Fart = require("sewn_scripts.entities.effects.fart")

local function MC_POST_EFFECT_INIT(_, effect)
    SpiderModEgg:EffectInit(effect)
    CubeBabyAura:EffectInit(effect)
    BombBagPowder:EffectInit(effect)
    Fart:EffectInit(effect)
end

return MC_POST_EFFECT_INIT