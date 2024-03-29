local Enums = require("sewn_scripts.core.enums")
local Globals = require("sewn_scripts.core.globals")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local Random = require("sewn_scripts.helpers.random")

local Thimble = { }

local function RandomVelocity()
    return Vector(0,2):Rotated(math.random(-45,45))
end

function Thimble:GetFamiliarFromSewingMachine(familiar, player, machine, isUpgraded, newLevel)
    if not player:HasTrinket(Enums.TrinketType.TRINKET_THIMBLE) or not isUpgraded then
        return
    end
    if machine.SubType == Enums.SewingMachineSubType.SHOP then
        local rollCoins = machine:GetDropRNG():RandomInt(10)
        for i = 1, rollCoins do
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_PENNY, machine.Position, RandomVelocity(), machine)
        end
    elseif machine.SubType == Enums.SewingMachineSubType.BEDROOM then
        if Random:CheckRoll(50, machine:GetDropRNG()) then
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_SOUL, machine.Position, RandomVelocity(), machine)
        end
    elseif machine.SubType == Enums.SewingMachineSubType.ANGEL then
        local rollCoins = machine:GetDropRNG():RandomInt(2)
        if Random:CheckRoll(15, machine:GetDropRNG()) then
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_ETERNAL, machine.Position, RandomVelocity(), machine)
        end
        for i = 1, rollCoins do
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_PENNY, machine.Position, RandomVelocity(), machine)
        end
    elseif machine.SubType == Enums.SewingMachineSubType.DEVIL then
        local rollBlueFlies = machine:GetDropRNG():RandomInt(6) - 1
        if Random:CheckRoll(40, machine:GetDropRNG()) then
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_BLACK, machine.Position, RandomVelocity(), machine)
        end
        for i = 1, rollBlueFlies do
            local blueFly = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, 0, machine.Position, RandomVelocity(), machine):ToFamiliar()
            blueFly.Player = player
        end
    end
end

function Thimble:OnSewingMachineDestroy(machine)
    local playerHasThimble = false

    for i = 1, Globals.Game:GetNumPlayers() do
        local player = Isaac.GetPlayer(i - 1)
        if player:HasTrinket(Enums.TrinketType.TRINKET_THIMBLE) then
            playerHasThimble = true
        end
    end
    if playerHasThimble == false then
        return
    end
    local mData = machine:GetData().SewingMachineData
    if mData.Sewn_sewingMachineBroken == true then
        return false
    end
end

CustomCallbacks:AddCallback(Enums.ModCallbacks.POST_GET_FAMILIAR_FROM_SEWING_MACHINE, Thimble.GetFamiliarFromSewingMachine)
CustomCallbacks:AddCallback(Enums.ModCallbacks.POST_MACHINE_DESTROY, Thimble.OnSewingMachineDestroy, Enums.SlotMachineVariant.SEWING_MACHINE)

return Thimble