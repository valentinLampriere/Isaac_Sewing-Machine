local Globals = require("sewn_scripts.core.globals")
local AvailableFamiliarManager = require("sewn_scripts.core.available_familiars_manager")
local Familiar = require("sewn_scripts.entities.familiar.familiar")

local Player = { }

function Player:Init(player)
    local pData = player:GetData()
    pData.Sewn_items = {}
    pData.Sewn_hasTrinket = {}
end

local function RemoveFamiliarsInMachineOnCache(player)
    local pData = player:GetData()

    if pData.Sewn_familiarsInMachine ~= nil then
        for machineIndex, sewnFamiliarVariant in pairs(pData.Sewn_familiarsInMachine) do
            local fams = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, sewnFamiliarVariant, -1, false, false)
            if fams ~= nil then
                fams[#fams]:Remove()
            end
        end
    end
end

function Player:OnEvaluateCache(player, cacheFlag)
    if cacheFlag == CacheFlag.CACHE_FAMILIARS then
        RemoveFamiliarsInMachineOnCache(player)
    end
end

function Player:GetAvailableFamiliars(player)
    local availableFamiliars = {}
    for _, familiar in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
        familiar = familiar:ToFamiliar()
        local fData = familiar:GetData()
        if AvailableFamiliarManager:IsFamiliarAvailable(familiar.Variant) and Familiar:IsReady(fData) then
            -- if the familiar belongs to the player AND the familiar is ready AND it isn't Ultra
            if GetPtrHash(familiar.Player) == GetPtrHash(player) then
                local fData = familiar:GetData()
                --[[
                if familiar:GetData().Sewn_familiarReady == true and sewingMachineMod:isUltra(fData) == false then
                    table.insert(availableFamiliars, familiar)
                end
                --]]
                if not Sewn_API:IsUltra(fData) then
                    table.insert(availableFamiliars, familiar)
                end
            end
        end
    end
    return availableFamiliars
end

function Player:ResetFamiliarsInMachine(player)
    local pData = player:GetData()
    pData.Sewn_familiarsInMachine = { }
    player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
    player:EvaluateItems()
end
function Player:ResetFamiliarsInMachineForPlayers()
    for i = 1, Globals.game:GetNumPlayers() do
        Player:ResetFamiliarsInMachine(Isaac.GetPlayer(i - 1))
    end
end

function Player:GetLilDelirium(player)
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    for _, familiar in ipairs(familiars) do
        familiar = familiar:ToFamiliar()
        if familiar.FrameCount == 1 and familiar.Player and GetPtrHash(familiar.Player) == GetPtrHash(player) then
            familiar:GetData().Sewn_isDelirium = true
        end
    end
end

return Player