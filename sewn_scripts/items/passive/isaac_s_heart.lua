local Globals = require("sewn_scripts.core.globals")
local MachineDataManager = require("sewn_scripts.core.machine_data_manager")

local IsaacsHeart = { }

function IsaacsHeart:OnNewRoom()
    -- Loop through machine data
    for machineId, machineValues in pairs(MachineDataManager.MachineData) do
        local mData = machineValues

        -- If it contains an *Isaac's Heart* :
        if mData.Sewn_currentFamiliarVariant == FamiliarVariant.ISAACS_HEART and mData.Sewn_player ~= nil then
            -- Loop through players to re-evaluate the cache of the owner of the *Isaac's Heart*
            for i = 1, Globals.Game:GetNumPlayers() do
                local player = Isaac.GetPlayer(i - 1)
                local pData = player:GetData()

                if GetPtrHash(mData.Sewn_player) == GetPtrHash(player) and pData.Sewn_familiarsInMachine ~= nil then
                    local isaacsHeart = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ISAACS_HEART, 0, player.Position, Globals.V0, player):ToFamiliar()
                    local fData = isaacsHeart:GetData()

                    isaacsHeart:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
                    fData.Sewn_upgradeLevel = mData.Sewn_currentFamiliarLevel

                    -- Remove the Isaac's Heart data from the player.
                    pData.Sewn_familiarsInMachine[machineId] = nil
                   
                    -- Remove the Isaac's Heart from the machine data.
                    MachineDataManager.MachineData[machineId] = nil
                end
            end
        end
    end
end

return IsaacsHeart