local Enums = require("sewn_scripts.core.enums")
local Globals = require("sewn_scripts.core.globals")
local SewingMachineManager = require("sewn_scripts.core.sewing_machine_manager")

local WarrantyCard = { }

function WarrantyCard:OnUse(card, player, useFlags)
    if card ~= Enums.Card.CARD_WARRANTY then
        return
    end
    SewingMachineManager:Spawn(Globals.Room:FindFreePickupSpawnPosition(player.Position, 0, true), true)
end

return WarrantyCard