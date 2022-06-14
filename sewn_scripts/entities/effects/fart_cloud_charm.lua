local FartCloud = require("sewn_scripts.entities.effects.fart_cloud")

local FartCloudCharm = { }

FartCloudCharm.SubType = 76

function FartCloudCharm:OnNpcCollide(effect, npc)
    if REPENTANCE then
        npc:AddCharmed(EntityRef(effect), FartCloud.Duration)
    else
        npc:AddCharmed(FartCloud.Duration)
    end
end

FartCloud:RegisterNpcFartCloud(FartCloudCharm)

return FartCloudCharm