local Enums = require("sewn_scripts.core.enums")
local Globals = require("sewn_scripts.core.globals")
local EntityCollidersCooldown = require("sewn_scripts.helpers.entity_colliders_cooldown")
local CColor = require("sewn_scripts.helpers.ccolor")

local SpiderModEgg = { }

local colliderCooldownName = "spiderModEggCollidersCooldown"

function SpiderModEgg:EffectInit(effect)
    if effect.Variant ~= Enums.EffectVariant.SPIDER_MOD_EGG then
        return
    end
    local eData = effect:GetData()
    eData.Sewn_spiderModEgg_colliderCooldown = { }
    
    -- Flip the egg sprite
    effect.FlipX = math.random(1) == 0
end

function SpiderModEgg:EffectUpdate(effect)
    if effect.Variant ~= Enums.EffectVariant.SPIDER_MOD_EGG then
        return
    end

    local eData = effect:GetData()

    if effect.Timeout == 0 then
        effect:Remove()
        Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.TOOTH_PARTICLE, 0, effect.Position, Globals.V0, nil)
        return
    end

    local npcs = Isaac.FindInRadius(effect.Position, effect.Size, EntityPartition.ENEMY)
    for _, npc in ipairs(npcs) do
        if not EntityCollidersCooldown:IsInCooldown(effect, npc, colliderCooldownName) then
            local rollEffect = npc:GetDropRNG():RandomInt(8)
            local rollDuration = npc:GetDropRNG():RandomInt(60) + 30
            if rollEffect == 0 then
                npc:AddPoison(EntityRef(effect), rollDuration, 3.5)
            elseif rollEffect == 1 then
                npc:AddFreeze(EntityRef(effect), rollDuration)
            elseif rollEffect == 2 then
                npc:AddSlowing(EntityRef(effect), rollDuration, 1, CColor(1,1,1,1,0,0,0))
            elseif rollEffect == 3 then
                if REPENTANCE then
                    npc:AddCharmed(EntityRef(effect), rollDuration)
                else
                    npc:AddCharmed(rollDuration)
                end
            elseif rollEffect == 4 then
                npc:AddConfusion(EntityRef(effect), rollDuration, false)
            elseif rollEffect == 5 then
                npc:AddFear(EntityRef(effect), rollDuration)
            elseif rollEffect == 6 then
                npc:AddBurn(EntityRef(effect), rollDuration, 3.5)
            elseif rollEffect == 7 then
                npc:AddShrink(EntityRef(effect), rollDuration)
            end
            EntityCollidersCooldown:Add(effect, npc, colliderCooldownName, 95)
        end
    end
end

return SpiderModEgg