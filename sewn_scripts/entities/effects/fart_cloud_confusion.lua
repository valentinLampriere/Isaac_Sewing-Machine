local FartCloud = require("sewn_scripts.entities.effects.fart_cloud")

local FartCloudConfusion = { }

FartCloudConfusion.SubType = 77

function FartCloudConfusion:OnNpcCollide(effect, npc)
    npc:AddConfusion(EntityRef(effect), FartCloud.Duration, false)
end

FartCloud:RegisterNpcFartCloud(FartCloudConfusion)

return FartCloudConfusion