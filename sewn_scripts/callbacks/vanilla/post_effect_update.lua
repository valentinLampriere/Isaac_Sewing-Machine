local LilAbaddonSwirl = require("sewn_scripts.entities.effects.lil_abaddon_swirl")
local SpiderModEgg = require("sewn_scripts.entities.effects.spider_mod_egg")
local CubeBabyAura = require("sewn_scripts.entities.effects.cube_baby_aura")
local PunchingBagPullingEffect = require("sewn_scripts.entities.effects.punching_bag_pulling_effect")
local BombBagPowder = require("sewn_scripts.entities.effects.bomb_bag_powder")
local FartCloud = require("sewn_scripts.entities.effects.fart_cloud")

local function MC_POST_EFFECT_UPDATE(_, effect)
    LilAbaddonSwirl:EffectUpdate(effect)
    SpiderModEgg:EffectUpdate(effect)
    CubeBabyAura:EffectUpdate(effect)
    PunchingBagPullingEffect:EffectUpdate(effect)
    BombBagPowder:EffectUpdate(effect)
    FartCloud:EffectUpdate(effect)

    if effect.Type == 1000 and effect.Variant == EffectVariant.FART and effect.FrameCount == 1 then
        local sprite = effect:GetSprite()
        local qcolor = sprite:GetTexel(Vector(0,0),Vector(0, 0), 0.1, 0)
        local color = sprite.Color
        print("GetTexel : " .. qcolor.Red .. ", " .. qcolor.Green .. ", " .. qcolor.Blue)
        print("Color : " .. color.R .. ", " .. color.G .. ", " .. color.B ..", " ..color.A .. ", " .. color.RO .. ", " .. color.GO .. ", " .. color.BO)
    end
end

return MC_POST_EFFECT_UPDATE
