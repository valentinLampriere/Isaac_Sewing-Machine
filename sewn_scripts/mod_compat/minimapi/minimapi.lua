if MinimapAPI == nil then
    return
end
local Enums = require("sewn_scripts.core.enums")

local icon = Sprite()

icon:Load("/gfx/mapicon.anm2", true)
MinimapAPI:AddIcon("SewingMachine", icon, "Icon", 0)
MinimapAPI:AddPickup("SewingMachine", "SewingMachine", EntityType.ENTITY_SLOT, Enums.SlotMachineVariant.SEWING_MACHINE, -1, MinimapAPI.PickupSlotMachineNotBroken, "slots")