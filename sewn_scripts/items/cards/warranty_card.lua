local Enums = require("sewn_scripts/core/enums")
local GetPlayerUsingItem = require("sewn_scripts/helpers/get_player_using_item")
local SewingMachineManager = require("sewn_scripts/core/sewing_machine_manager")

local WarrantyCard = { }

function WarrantyCard:OnUse(card, player, useFlags)
    if card ~= Enums.Card.CARD_WARRANTY then
        return
    end
    player = player or GetPlayerUsingItem()
    SewingMachineManager:Spawn(player.Position, true)
end

return WarrantyCard