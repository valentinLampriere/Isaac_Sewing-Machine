local Enums = require("sewn_scripts.core.enums")
local Random = require("sewn_scripts.helpers.random")

local SewingMachine_Shop = { }

SewingMachine_Shop.SubType = Enums.SewingMachineSubType.SHOP
SewingMachine_Shop.Room_Types = { RoomType.ROOM_SHOP }
SewingMachine_Shop.IsDefaultMachine = true
SewingMachine_Shop.BreakChancePerUse = 7
SewingMachine_Shop.ShouldExplodeOnBreak = true
SewingMachine_Shop.AppearChance = 25

SewingMachine_Shop.Stats = {
    Cost = 10,
    Cost_Sale = 5
}

function SewingMachine_Shop:CanPay(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_STEAM_SALE) then
        return player:GetNumCoins() >= SewingMachine_Shop.Stats.Cost_Sale
    else
        return player:GetNumCoins() >= SewingMachine_Shop.Stats.Cost
    end
end
function SewingMachine_Shop:Pay(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_STEAM_SALE) then
        player:AddCoins(-5)
    else
        player:AddCoins(-10)
    end
end

return SewingMachine_Shop