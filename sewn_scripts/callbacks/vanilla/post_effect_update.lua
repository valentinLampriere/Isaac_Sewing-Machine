local LilAbaddonSwirl = require("sewn_scripts.entities.effects.lil_abaddon_swirl")
local SpiderModEgg = require("sewn_scripts.entities.effects.spider_mod_egg")
local CubeBabyAura = require("sewn_scripts.entities.effects.cube_baby_aura")
local PunchingBagPullingEffect = require("sewn_scripts.entities.effects.punching_bag_pulling_effect")
local BombBagPowder = require("sewn_scripts.entities.effects.bomb_bag_powder")
local Fart = require("sewn_scripts.entities.effects.fart")

local function MC_POST_EFFECT_UPDATE(_, effect)
    LilAbaddonSwirl:EffectUpdate(effect)
    SpiderModEgg:EffectUpdate(effect)
    CubeBabyAura:EffectUpdate(effect)
    PunchingBagPullingEffect:EffectUpdate(effect)
    BombBagPowder:EffectUpdate(effect)
end

return MC_POST_EFFECT_UPDATE
