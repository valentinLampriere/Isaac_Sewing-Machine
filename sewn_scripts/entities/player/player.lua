local Globals = require("sewn_scripts.core.globals")
local AvailableFamiliarManager = require("sewn_scripts.core.available_familiars_manager")
local Familiar = require("sewn_scripts.entities.familiar.familiar")
local SewingMachineManager = require("sewn_scripts.core.sewing_machine_manager")

local Player = { }

function Player:Init(player)
    local pData = player:GetData()
    pData.Sewn_items = { }
    pData.Sewn_hasTrinket = { }
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

function Player:SetIsCloseFromMachine(player)
    local pData = player:GetData()
    local isCloseFromMachine = false
    local machines = SewingMachineManager:GetAllSewingMachines()
    for _, machine in ipairs(machines) do
        if (machine.Position - player.Position):LengthSquared() < 100 ^ 2 then
            isCloseFromMachine = true
        end
    end
    if pData.Sewn_isCloseFromMachine ~= isCloseFromMachine then
        pData.Sewn_isCloseFromMachine = isCloseFromMachine
    end
end

function Player:ResetFamiliarsInMachine(player)
    local pData = player:GetData()
    pData.Sewn_familiarsInMachine = { }
    player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
    player:EvaluateItems()
end
function Player:ResetFamiliarsInMachineForPlayers()
    for i = 1, Globals.Game:GetNumPlayers() do
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