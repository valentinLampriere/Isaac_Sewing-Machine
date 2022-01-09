local Sewn_API = { }

local Enums = require("sewn_scripts.core.enums")
local AvailableFamiliarManager = require("sewn_scripts.core.available_familiars_manager")
local UpgradeManager = require("sewn_scripts.core.upgrade_manager")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local FamiliarDescription = require("sewn_scripts.mod_compat.eid.familiar_description")
local Familiar = require("sewn_scripts.entities.familiar.familiar")
local EncyclopediaUpgrades = require("sewn_scripts.mod_compat.encyclopedia.encyclopedia_upgrades")

Sewn_API.Enums = {
    ModCallbacks = Enums.ModCallbacks,
    FamiliarLevel = Enums.FamiliarLevel,
    FamiliarLevelFlag = Enums.FamiliarLevelFlag,
    NoUpgrade = Enums.NoUpgrade
}

-- Return true if the familiar is upgraded as SUPER (yellow crown)
-- fData (table)                   : data attributes of the familiar retrieved with familiar:GetData()
-- includeUltra (bool) [optionnal] : When true, return true if the familiar is SUPER or ULTRA, if false return true only when the familiar is SUPER. Default : true
function Sewn_API:IsSuper(fData, includeUltra)
    if includeUltra == nil then
        includeUltra = true
    end
    if includeUltra then
        return Sewn_API:GetLevel(fData) >= Enums.FamiliarLevel.SUPER
    else
        return Sewn_API:GetLevel(fData) == Enums.FamiliarLevel.SUPER
    end
end

-- Return true if the familiar is upgraded as ULTRA (blue crown)
-- fData (table) : data attributes of the familiar retrieved with familiar:GetData()
function Sewn_API:IsUltra(fData)
    return Sewn_API:GetLevel(fData) >= Enums.FamiliarLevel.ULTRA
end
function Sewn_API:GetLevel(fData)
    if fData.Sewn_upgradeLevel_temporary ~= nil then
        return fData.Sewn_upgradeLevel_temporary
    end
    return fData.Sewn_upgradeLevel or Enums.FamiliarLevel.NORMAL
end
-- Make the familiar available for the Sewing Machine
-- Parameters :
--   [FamiliarVariant]
--   [CollectibleType] (optional) : The collectible associated to the familiar. The sprite for this collectible will be seen in the Sewing Machine
Sewn_API.MakeFamiliarAvailable = AvailableFamiliarManager.TryMakeFamiliarAvailable

-- Add an EID description for the given familiar upgrades. Those descriptions will be shown when the familiar is in the Sewing Machine
-- Parameters :
--   [FamiliarVariant]
--   [string] : The text which will be seen for the SUPER upgrade
--   [string] : The text which will be seen for the ULTRA upgrade
--   [table]  : The color of the familiar name text. It is a table with 3 numbers [0, 1]. Ex : {1, 0.8, 0.4}
--   [string] : The name of the familiar, will be displayed as the title. If not set the name of the associated collectible is taken. Note : it is marked optional but due to the last repentance patch it is impossible to get the name of collectibles, so it is recommended to enter the name of the familiar
Sewn_API.AddFamiliarDescription = FamiliarDescription.AddDescriptionsForFamiliar

-- Add a callback
-- Parameters :
--   [Sewn_API.Enums.ModCallbacks] : The callback ID
--   [function] : The function which will be called
--   [...] (optional) : Additional arguments, depending on the callback called
Sewn_API.AddCallback = CustomCallbacks.AddCallback

-- Hide/Unhide the crown of a familiar
-- Parameters :
--   [EntityFamiliar] : the familiar you want to hide/unhide the crown to
--   [boolean] (optional) : true to hide the crown, false to unhide it. Default is true
Sewn_API.HideCrown = Familiar.HideCrown

-- Upgrade your familiar and call the ON_FAMILIAR_UPGRADED callbacks
-- Parameters :
--   [EntityFamiliar] : the familiar you want to upgrade
--   [Sewn_API.Enums.FamiliarLevel] : the level to set
Sewn_API.UpFamiliar = UpgradeManager.UpFamiliar

-- Add an offset to the familiar's crown
-- Parameters :
--   [EntityFamiliar] : the familiar entity
--   [Vector] : the offset
Sewn_API.AddCrownOffset = Familiar.AddCrownOffset

-- Add an Encyclopedia description for the familiar's Upgrade. This will be added in the familiar item wiki.
-- It is possible to add 3 sections : Super upgrade, Ultra upgrade, Notes for additional informations
-- By default the EID description is used in the Encyclopedia
-- Parameters :
--   [FamiliarVariant] : the familiar vatiant
--   [string] (optionnal) : the super upgraded text (EID formatted). If not set, the EID text is choosen
--   [string] (optionnal) : the ulta upgraded text (EID formatted). If not set, the EID text is choosen
--   [string] (optionnal) : the notes text (EID formatted)
Sewn_API.AddEncyclopediaUpgrade = EncyclopediaUpgrades.AddEncyclopediaUpgrade


return Sewn_API