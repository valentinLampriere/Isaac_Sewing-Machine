local EIDManager = { }

local AvailableFamiliarManager = require("sewn_scripts.core.available_familiars_manager")
local FamiliarDescription = require("sewn_scripts.mod_compat.eid.familiar_description")

function EIDManager:SetEIDForEntity(entity, name, description)
    local data = entity:GetData()
    data.EID_Description = {
        Name = name,
        Description = description
    }
end
function EIDManager:ResetEIDForEntity(entity)
    local data = entity:GetData()
    data.EID_Description = nil
end

function EIDManager:GetFamiliarUpgradeDescObj(collectibleId)
    local familiarVariant = AvailableFamiliarManager:GetFamiliarFromCollectible(collectibleId)

    if familiarVariant == nil then return end

    if type(familiarVariant) == "table" then
        familiarVariant = familiarVariant[1]
    end

    local info = FamiliarDescription:GetInfoForFamiliar(familiarVariant)
    if info == nil then return end

    local description = {}
	description.ObjType = EntityType.ENTITY_FAMILIAR
	description.ObjVariant = familiarVariant
	description.ObjSubType = 0
	description.fullItemString = ""
	description.Name = "" ..
    "{{ColorText}}" ..
    AvailableFamiliarManager:GetFamiliarName(familiarVariant) ..
    " {{SewingMachine}}"

    description.Description = "" ..
    "{{SuperCrown}} Super :#" ..
    info.SuperUpgrade ..
    "#{{Blank}}" ..
    "#{{UltraCrown}} Ultra :#" ..
    info.UltraUpgrade

    return description
end

return EIDManager