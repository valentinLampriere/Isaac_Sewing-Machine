local Enums = require("sewn_scripts.core.enums")
local Globals = require("sewn_scripts.core.globals")

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

local function ChangeSaleSprite(machine, bool_onSale)
    local sprite = machine:GetSprite()
    if bool_onSale then
        sprite:ReplaceSpritesheet(0, "gfx/items/slots/slot_sewingmachine_sales.png")
    else
        sprite:ReplaceSpritesheet(0, "gfx/items/slots/slot_sewingmachine.png")
    end
    sprite:LoadGraphics()
end

function SewingMachine_Shop.Update(machine)
    for i = 1, Globals.Game:GetNumPlayers() do
        local player = Isaac.GetPlayer(i - 1)
        local mData = machine:GetData().SewingMachineData

        local playerHasSteamSale = player:HasCollectible(CollectibleType.COLLECTIBLE_STEAM_SALE)

        if playerHasSteamSale and not mData.Sewn_machineSale then
            ChangeSaleSprite(machine, true)
            mData.Sewn_machineSale = true
        elseif not playerHasSteamSale and mData.Sewn_machineSale then
            ChangeSaleSprite(machine, false)
            mData.Sewn_machineSale = nil
        end
    end
end

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