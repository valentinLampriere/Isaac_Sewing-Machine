local Enums = require("sewn_scripts.core.enums")
local Delay = require("sewn_scripts.helpers.delay")

local DollsPureBody = { }

Sewn_API:MakeFamiliarAvailable(Enums.FamiliarVariant.DOLL_S_PURE_BODY, Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY)

function DollsPureBody:OnSuperUpgrade(familiar, isPermanentUpgrade)
    Sewn_API:HideCrown(familiar)
end
function DollsPureBody:OnUltraUpgrade(familiar, isPermanentUpgrade)
    local fData = familiar:GetData()
    Delay:DelayFunction(function ()
        Sewn_API:HideCrown(familiar, false)
        fData.Sewn_crown:Play("Pure")
        fData.Sewn_crown:LoadGraphics()
    end, 1)
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, DollsPureBody.OnSuperUpgrade, Enums.FamiliarVariant.DOLL_S_PURE_BODY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, DollsPureBody.OnUltraUpgrade, Enums.FamiliarVariant.DOLL_S_PURE_BODY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)