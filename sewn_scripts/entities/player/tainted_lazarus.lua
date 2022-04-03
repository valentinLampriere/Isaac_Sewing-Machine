local Globals = require("sewn_scripts.core.globals")
local UpgradeManager = require("sewn_scripts.core.upgrade_manager")

local TainedLazarus = { }

TainedLazarus.FamiliarUpgradeTracker = {
}
TainedLazarus.FamiliarTracker = {
}

local function GetTaintedLazarusFamiliarUpgradeTrackerTable(player)
    if TainedLazarus.FamiliarUpgradeTracker[player.Index] == nil then
        TainedLazarus.FamiliarUpgradeTracker[player.Index] = {
            [PlayerType.PLAYER_LAZARUS_B] = { },
            [PlayerType.PLAYER_LAZARUS2_B] = { }
        }
    end
    return TainedLazarus.FamiliarUpgradeTracker[player.Index]
end
local function GetTaintedLazarusFamiliarTrackerTable(player)
    if TainedLazarus.FamiliarTracker[player.Index] == nil then
        TainedLazarus.FamiliarTracker[player.Index] = {
            [PlayerType.PLAYER_LAZARUS_B] = { },
            [PlayerType.PLAYER_LAZARUS2_B] = { }
        }
    end
    return TainedLazarus.FamiliarTracker[player.Index]
end

local function IsTaintedLazarus(player)
    if player == nil then
        return false
    end
    return player:GetPlayerType() == PlayerType.PLAYER_LAZARUS_B or player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2_B
end

local function SaveCounterpartFamiliarUpgrades(player, counterpart)
    local familiarTracker = GetTaintedLazarusFamiliarTrackerTable(player)
    local familiarUpgradeTracker = GetTaintedLazarusFamiliarUpgradeTrackerTable(player)
    -- Loop through all stored familiar upgrades for the counterpart lazarus
    for i, _fData in ipairs(familiarUpgradeTracker[counterpart]) do
        if _fData.PlayerIndex == player.Index then
            -- Loop through familiars which were existing for the counterpart Lazarus
            for j, familiarData in ipairs(familiarTracker[counterpart]) do
                if _fData.Variant == familiarData.Variant and _fData.Upgrade == familiarData.Upgrade then
                    UpgradeManager:TryUpgrade(_fData.Variant, 0, _fData.PlayerIndex, _fData.Upgrade)
                end
            end
        end
    end
end

function TainedLazarus:OnNewFloor()
    for i = 1, Globals.Game:GetNumPlayers() do
        local player = Isaac.GetPlayer(i - 1)
        if player:GetPlayerType() == PlayerType.PLAYER_LAZARUS_B then
            SaveCounterpartFamiliarUpgrades(player, PlayerType.PLAYER_LAZARUS2_B)
        elseif player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2_B then
            SaveCounterpartFamiliarUpgrades(player, PlayerType.PLAYER_LAZARUS_B)
        end
    end
end

function TainedLazarus:OnPlayerUpdate(player)
    if not IsTaintedLazarus(player) then
        return
    end
    local taintedLazarusFamiliarTracker = GetTaintedLazarusFamiliarUpgradeTrackerTable(player)
    local familiarTracker = GetTaintedLazarusFamiliarTrackerTable(player)
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    familiarTracker[player:GetPlayerType()] = { }
    for _, familiar in ipairs(familiars) do
        familiar = familiar:ToFamiliar()
        if GetPtrHash(familiar.Player) == GetPtrHash(player) then
            local _fData, i = UpgradeManager:FindFamiliarData(familiar.Variant, Sewn_API:GetLevel(familiar:GetData()), familiar.Player.Index, taintedLazarusFamiliarTracker[player:GetPlayerType()])
            table.insert(familiarTracker[player:GetPlayerType()], _fData)
        end
    end
end

function TainedLazarus:FamiliarUpgraded(familiar, isPermanentUpgrade)
    if not IsTaintedLazarus(familiar.Player) then
        return
    end
    if isPermanentUpgrade then
        local taintedLazarusFamiliarTracker = GetTaintedLazarusFamiliarUpgradeTrackerTable(familiar.Player)
        local _fData, i = UpgradeManager:FindFamiliarData(familiar.Variant, Sewn_API:GetLevel(familiar:GetData()) - 1, familiar.Player.Index, taintedLazarusFamiliarTracker[familiar.Player:GetPlayerType()])
        --if _fData == nil then
        --    _fData, i = UpgradeManager:FindFamiliarData(familiar.Variant, Sewn_API:GetLevel(familiar:GetData()), familiar.Player.Index)
        --end
        UpgradeManager:AddOrUpdateFamiliarData(_fData, Sewn_API:GetLevel(familiar:GetData()), familiar.Variant, familiar.Player.Index, taintedLazarusFamiliarTracker[familiar.Player:GetPlayerType()])
    end
end
function TainedLazarus:FamiliarLoseUpgrade(familiar, losePermanentUpgrade)
    if not IsTaintedLazarus(familiar.Player) then
        return
    end
    
    local taintedLazarusFamiliarTracker = GetTaintedLazarusFamiliarUpgradeTrackerTable(familiar.Player)
    for i, _fData in ipairs(taintedLazarusFamiliarTracker[familiar.Player:GetPlayerType()]) do
        if GetPtrHash(familiar) == GetPtrHash(_fData.Entity) then
            table.remove(taintedLazarusFamiliarTracker[familiar.Player:GetPlayerType()], i)
            break
        end
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, TainedLazarus.FamiliarUpgraded)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_LOSE_UPGRADE, TainedLazarus.FamiliarLoseUpgrade)

return TainedLazarus