local Globals = require("sewn_scripts.core.globals")

local Bomb = { }

function Bomb:OnNewLevel()
    for i = 1, Globals.Game:GetNumPlayers() do
        local player = Isaac.GetPlayer(i - 1)
        local pData = player:GetData()

        pData.Sewn_bonusBombFlag = nil
    end
end


function Bomb:OnBombUpdate(bomb)
    local bData = bomb:GetData()
    if bData.Sewn_init == nil then
        local spawner = bomb.SpawnerEntity
        if spawner ~= nil then
            local playerSpawer = spawner:ToPlayer()
            if playerSpawer ~= nil then
                local pData = playerSpawer:GetData()
                if pData.Sewn_bonusBombFlag ~= nil then
                    bomb:AddTearFlags(pData.Sewn_bonusBombFlag)
                end
            end
        end

        bData.Sewn_init = true
    end
end

return Bomb