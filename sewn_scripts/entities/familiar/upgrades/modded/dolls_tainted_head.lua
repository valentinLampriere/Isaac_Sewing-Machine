local Enums = require("sewn_scripts.core.enums")
local Delay = require("sewn_scripts.helpers.delay")

local DollsTaintedHead = { }

Sewn_API:MakeFamiliarAvailable(Enums.FamiliarVariant.DOLL_S_TAINTED_HEAD, Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD)

function DollsTaintedHead:OnSuperUpgrade(familiar, isPermanentUpgrade)
    Sewn_API:HideCrown(familiar)
end
function DollsTaintedHead:OnUltraUpgrade(familiar, isPermanentUpgrade)
    local fData = familiar:GetData()
    Delay:DelayFunction(function ()
        Sewn_API:HideCrown(familiar, false)
        fData.Sewn_crown:Play("Tainted")
        fData.Sewn_crown:LoadGraphics()
    end, 1)
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, DollsTaintedHead.OnSuperUpgrade, Enums.FamiliarVariant.DOLL_S_TAINTED_HEAD)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, DollsTaintedHead.OnUltraUpgrade, Enums.FamiliarVariant.DOLL_S_TAINTED_HEAD, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)