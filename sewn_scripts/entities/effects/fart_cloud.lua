local Globals = require("sewn_scripts.core.globals")

local FartCloud = { }

FartCloud.Variant = 762
FartCloud.Radius = 70
FartCloud.Duration = 90
FartCloud.Damage = 3.5
FartCloud.RegisteredNpcFartClouds = { }
FartCloud.RegisteredPlayerFartClouds = { }

function FartCloud:RegisterNpcFartCloud(fartCloud)
    if fartCloud.SubType == nil then
        error("Can't register this fart cloud effect")
        return
    end

    FartCloud.RegisteredNpcFartClouds[fartCloud.SubType] = fartCloud
end
function FartCloud:RegisterPlayerFartCloud(fartCloud)
    if fartCloud.SubType == nil then
        error("Can't register this fart cloud effect")
        return
    end

    FartCloud.RegisteredPlayerFartClouds[fartCloud.SubType] = fartCloud
end

function FartCloud:EffectUpdate(effect)
    if effect.Type ~= EntityType.ENTITY_EFFECT or effect.Variant ~= FartCloud.Variant then
        return
    end

    local npcs = Isaac.FindInRadius(effect.Position, FartCloud.Radius, EntityPartition.ENEMY)
    for npc in ipairs(npcs) do
        if npc:IsVulnerableEnemy() then
            for _, fartCloud in ipairs(FartCloud.RegisteredNpcFartClouds) do
                if fartCloud.OnNpcCollide ~= nil then
                    fartCloud:OnNpcCollide(effect, npc)
                end
            end
        end
    end

    local players = Isaac.FindInRadius(effect.Position, FartCloud.Radius, EntityPartition.PLAYER)
    for _, player in ipairs(players) do
        for _, fartCloud in ipairs(FartCloud.RegisteredPlayerFartClouds) do
            if fartCloud.OnPlayerCollide ~= nil then
                fartCloud:OnPlayerCollide(effect, player)
            end
        end
    end

    for _, fartCloud in ipairs(FartCloud.RegisteredPlayerFartClouds) do
        if fartCloud.EffectUpdate ~= nil then
            fartCloud:EffectUpdate(effect)
        end
    end
end

return FartCloud