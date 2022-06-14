local FartCloud = require("sewn_scripts.entities.effects.fart_cloud")

local FartCloudBurning = { }

FartCloudBurning.SubType = 78

function FartCloudBurning:OnNpcCollide(effect, npc)
    npc:AddBurn(EntityRef(effect), FartCloud.Duration, FartCloud.Damage)
end

FartCloud:RegisterNpcFartCloud(FartCloudBurning)

return FartCloudBurning