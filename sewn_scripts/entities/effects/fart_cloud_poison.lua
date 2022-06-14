local FartCloud = require("sewn_scripts.entities.effects.fart_cloud")

local FartCloudPoison = { }

FartCloudPoison.SubType = 75

function FartCloudPoison:OnNpcCollide(effect, npc)
    npc:AddPoison(EntityRef(effect), FartCloud.Duration, FartCloud.Damage)
end

FartCloud:RegisterNpcFartCloud(FartCloudPoison)

return FartCloudPoison