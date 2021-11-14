local Enums = require("sewn_scripts.core.enums")
local Globals = require("sewn_scripts.core.globals")
local EntityCollidersCooldown = require("sewn_scripts.helpers.entity_colliders_cooldown")
local CColor = require("sewn_scripts.helpers.ccolor")

local CubeBabyAura = { }

CubeBabyAura.Stats = {
    FrameRate = 3,
    Damage = 0.5
}

function CubeBabyAura:EffectInit(effect)
    if effect.Variant ~= Enums.EffectVariant.CUBE_BABY_AURA then
        return
    end
    local eData = effect:GetData()
    eData.Sewn_cubeBabyAura_freezeEnemies = { }
    eData.Sewn_cubeBabyAura_maxFreeze = { }
end

local function SetNpcColor(effect, npc)
    local eData = effect:GetData()
    local ptrNpc = GetPtrHash(npc)
    if eData.Sewn_cubeBabyAura_freezeEnemies[ptrNpc] == nil then
        return
    end
    local t = eData.Sewn_cubeBabyAura_freezeEnemies[ptrNpc] / eData.Sewn_cubeBabyAura_maxFreeze[ptrNpc]
    npc:SetColor(Color.Lerp(CColor(1, 1, 1), CColor(0.78, 0.86, 1.29, 1, 0.22, 0.33, 0.59), t), 4, 1, true, false)
end
local function IncreaseCold(effect, npc, t)
    local eData = effect:GetData()
    local ptrNpc = GetPtrHash(npc)
    
    if eData.Sewn_cubeBabyAura_freezeEnemies[ptrNpc] < eData.Sewn_cubeBabyAura_maxFreeze[ptrNpc] and t > 0 or eData.Sewn_cubeBabyAura_freezeEnemies[ptrNpc] > 0 and t < 0 then
        eData.Sewn_cubeBabyAura_freezeEnemies[ptrNpc] = eData.Sewn_cubeBabyAura_freezeEnemies[ptrNpc] + t
        return true
    end
    return false
end

function CubeBabyAura:EffectUpdate(effect)
    if effect.Variant ~= Enums.EffectVariant.CUBE_BABY_AURA then
        return
    end

    local eData = effect:GetData()

    local npcs = Isaac.FindInRadius(effect.Position, 1500, EntityPartition.ENEMY)
    
    -- Prevent from looping through all enemies each frames
    if effect.FrameCount % CubeBabyAura.Stats.FrameRate == 0 then
        for _, npc in pairs(npcs) do
            if npc:IsVulnerableEnemy() then

                local ptrNpc = GetPtrHash(npc)
                if npc.Position:DistanceSquared(effect.Position) <= effect.Size ^ 2 then
                    if eData.Sewn_cubeBabyAura_freezeEnemies[ptrNpc] == nil then
                        eData.Sewn_cubeBabyAura_freezeEnemies[ptrNpc] = 0
                        eData.Sewn_cubeBabyAura_maxFreeze[ptrNpc] = npc.HitPoints * 5
                    end

                    SetNpcColor(effect, npc)

                    if not IncreaseCold(effect, npc, CubeBabyAura.Stats.FrameRate) then
                        npc:TakeDamage(CubeBabyAura.Stats.Damage, 0, EntityRef(effect), CubeBabyAura.Stats.FrameRate)
                        npc:AddEntityFlags(EntityFlag.FLAG_ICE)
                    end
                elseif eData.Sewn_cubeBabyAura_freezeEnemies[ptrNpc] ~= nil then
                    SetNpcColor(effect, npc)
                    if not IncreaseCold(effect, npc, - CubeBabyAura.Stats.FrameRate * 2) then
                        npc:ClearEntityFlags(EntityFlag.FLAG_ICE)
                        eData.Sewn_cubeBabyAura_freezeEnemies[ptrNpc] = nil
                        eData.Sewn_cubeBabyAura_maxFreeze[ptrNpc] = nil
                    end
                end
            end
        end
    end
end

return CubeBabyAura