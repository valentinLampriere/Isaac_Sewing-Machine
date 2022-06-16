local Enums = require("sewn_scripts.core.enums")
local Globals = require("sewn_scripts.core.globals")
local Random = require("sewn_scripts.helpers.random")

local SewingMachine_Shop = { }

SewingMachine_Shop.SubType = Enums.SewingMachineSubType.SHOP
SewingMachine_Shop.BreakChancePerUse = 7

SewingMachine_Shop.Stats = {
    Cost = 10,
    Cost_Sale = 5,
    SpawnChance = 40,
    SpawnChanceInHome = 75,
    HardModeChanceMultiplier = 0.65
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
        local _mData = machine:GetData()

        local playerHasSteamSale = player:HasCollectible(CollectibleType.COLLECTIBLE_STEAM_SALE)

        if playerHasSteamSale and not _mData.Sewn_machineSale then
            ChangeSaleSprite(machine, true)
            _mData.Sewn_machineSale = true
        elseif not playerHasSteamSale and _mData.Sewn_machineSale then
            ChangeSaleSprite(machine, false)
            _mData.Sewn_machineSale = nil
        end
    end
end

function SewingMachine_Shop:EvaluateSpawn(rng, room, level, ignoreRandom)
    local chance = SewingMachine_Shop:GetChance()
    if Globals.Game.Difficulty == Difficulty.DIFFICULTY_HARD or Globals.Game.Difficulty == Difficulty.DIFFICULTY_GREEDIER then
        chance = chance * SewingMachine_Shop.Stats.HardModeChanceMultiplier
    end

    print("Chance : " .. chance)
    
    if room:GetType() == RoomType.ROOM_SHOP then
        if (Random:CheckRoll(chance, rng) or ignoreRandom) or level:GetStage() == LevelStage.STAGE4_3 then
            return true
        end
    end

    -- Spawn machine in Home
    if SewingMachine_Shop.Parent:IsHomeClosetRoom(room, level) then
        if (Random:CheckRoll(SewingMachine_Shop.Stats.SpawnChanceInHome, rng) or not ignoreRandom) then
            return true
        end
    end

    return false
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