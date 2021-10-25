local v0 = Vector(0, 0)
local game = Game()

----------------------------------------------
-- MC_POST_EFFECT_INIT - EffectVariant.FART --
----------------------------------------------
function sewingMachineMod:init_fart(effect)
    -- Burning Farts effect
    if effect.SubType == 75 then
        local npcs = Isaac.FindInRadius(effect.Position, 100, EntityPartition.ENEMY)
        for _, npc in pairs(npcs) do
            if npc:IsVulnerableEnemy() then
                local rollTime = math.random(210) + 60
                npc:TakeDamage(5, DamageFlag.DAMAGE_POISON_BURN, EntityRef(effect.SpawnerEntity), 5)
                npc:AddBurn(EntityRef(effect.SpawnerEntity), rollTime, 3.5)
            end
        end
    end
end


----------------------------------------------------------
-- MC_POST_EFFECT_UPDATE - EffectVariant.SPIDER_MOD_EGG --
----------------------------------------------------------
function sewingMachineMod:update_spiderModEgg(egg)
    local eData = egg:GetData()

    if egg.FrameCount >= 30 * 30 then -- Remove after 30 seconds
        egg:Remove()
        Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.TOOTH_PARTICLE, 0, effect.Position, v0, nil)
    end

    for _, npc in pairs(Isaac.FindInRadius(egg.Position, egg.Size, EntityPartition.ENEMY)) do
        if npc:IsVulnerableEnemy() then
            if eData.Sewn_spidermod_eggColliderCooldown[GetPtrHash(npc)] == nil or eData.Sewn_spidermod_eggColliderCooldown[GetPtrHash(npc)] + 90 < game:GetFrameCount() then
                local rollEffect = npc:GetDropRNG():RandomInt(8)
                local rollDuration = npc:GetDropRNG():RandomInt(60) + 30
                if rollEffect == 0 then
                    npc:AddPoison(EntityRef(egg), rollDuration, 3.5)
                elseif rollEffect == 1 then
                    npc:AddFreeze(EntityRef(egg), rollDuration)
                elseif rollEffect == 2 then
                    npc:AddSlowing(EntityRef(egg), rollDuration, 1, Color(1,1,1,1,0,0,0))
                elseif rollEffect == 3 then
                    npc:AddCharmed(EntityRef(egg), rollDuration)
                elseif rollEffect == 4 then
                    npc:AddConfusion(EntityRef(egg), rollDuration, false)
                elseif rollEffect == 5 then
                    npc:AddFear(EntityRef(egg), rollDuration)
                elseif rollEffect == 6 then
                    npc:AddBurn(EntityRef(egg), rollDuration, 3.5)
                elseif rollEffect == 7 then
                    npc:AddShrink(EntityRef(egg), rollDuration)
                end
                eData.Sewn_spidermod_eggColliderCooldown[GetPtrHash(npc)] = game:GetFrameCount()
            end
        end
    end
end
-----------------------------------------------------------------------
-- MC_POST_EFFECT_UPDATE - EffectVariant.LIL_ABADDON_BRIMSTONE_SWIRL --
-----------------------------------------------------------------------
function sewingMachineMod:update_lilAbaddonBrimstoneSwirl(swirl)
    local sprite = swirl:GetSprite()
    if sprite:IsFinished("Spawn") then
        sprite:Play("Idle")
    end
    if sprite:IsFinished("Death") then
        swirl:Remove()
    end
end

sewingMachineMod:AddCallback(ModCallbacks.MC_POST_EFFECT_INIT, sewingMachineMod.init_fart, EffectVariant.FART)

sewingMachineMod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, sewingMachineMod.update_spiderModEgg, EffectVariant.SPIDER_MOD_EGG)
sewingMachineMod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, sewingMachineMod.update_lilAbaddonBrimstoneSwirl, EffectVariant.LIL_ABADDON_BRIMSTONE_SWIRL)


sewingMachineMod.errFamiliars.Error()