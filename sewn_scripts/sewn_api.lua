local Sewn_API = { }

local Enums = require("sewn_scripts/core/enums")
local AvailableFamiliarManager = require("sewn_scripts/core/available_familiars_manager")
local CustomCallbacks = require("sewn_scripts/callbacks/custom_callbacks")

Sewn_API.Enums = Enums

-- Return true if the familiar is upgraded as SUPER (yellow crown)
-- fData (table)                   : data attributes of the familiar retrieved with familiar:GetData()
-- includeUltra (bool) [optionnal] : When true, return true if the familiar is SUPER or ULTRA, if false return true only when the familiar is SUPER. Default : true
function Sewn_API:IsSuper(fData, includeUltra)
    if includeUltra == nil then
        includeUltra = true
    end
    if fData.Sewn_upgradeLevel_temporary ~= nil then
        if includeUltra then
            return fData.Sewn_upgradeLevel_temporary >= Enums.FamiliarLevel.SUPER
        else
            return fData.Sewn_upgradeLevel_temporary == Enums.FamiliarLevel.SUPER
        end
    end
    if includeUltra then
        return fData.Sewn_upgradeLevel >= Enums.FamiliarLevel.SUPER
    else
        return fData.Sewn_upgradeLevel == Enums.FamiliarLevel.SUPER
    end
end

-- Return true if the familiar is upgraded as ULTRA (blue crown)
-- fData (table) : data attributes of the familiar retrieved with familiar:GetData()
function Sewn_API:IsUltra(fData)
    if fData.Sewn_upgradeLevel_temporary ~= nil then
        return fData.Sewn_upgradeLevel_temporary >= Enums.FamiliarLevel.ULTRA
    end
    return fData.Sewn_upgradeLevel >= Enums.FamiliarLevel.ULTRA
end
function Sewn_API:GetLevel(fData)
    if fData.Sewn_upgradeLevel_temporary ~= nil then
        return fData.Sewn_upgradeLevel_temporary
    end
    return fData.Sewn_upgradeLevel or Enums.FamiliarLevel.NORMAL
end

function Sewn_API:MakeFamiliarAvailable(familiarVariant, collectibleID_or_spritePath)
    AvailableFamiliarManager:TryMakeFamiliarAvailable(familiarVariant, collectibleID_or_spritePath)
end
function Sewn_API:AddCallback(callbackId, _function, ...)
    local args = {...}
    CustomCallbacks:AddCallback(callbackId, _function, table.unpack(args))
end

return Sewn_API