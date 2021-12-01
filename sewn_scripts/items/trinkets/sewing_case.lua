local Globals = require("sewn_scripts.core.globals")
local Enums = require("sewn_scripts.core.enums")
local Random = require("sewn_scripts.helpers.random")
local Familiar = require("sewn_scripts.entities.familiar.familiar")

local SewingCase = { }

function SewingCase:OnNewRoom()
    for i = 1, Globals.Game:GetNumPlayers() do
        local player = Isaac.GetPlayer(i - 1)
        if player:HasTrinket(Enums.TrinketType.TRINKET_SEWING_CASE) then

            local playerAvailableFamiliars = { }

            local luck = player.Luck
            -- Cap luck
            if luck < -10 then
                luck = -10
            elseif luck > 50 then
                luck = 50
            end

            local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
            for _, familiar in ipairs(familiars) do
                local fData = familiar:GetData()
                familiar = familiar:ToFamiliar()
                if not Sewn_API:IsUltra(fData) and (fData.Sewn_noUpgrade ~= nil and fData.Sewn_noUpgrade & Sewn_API.Enums.NoUpgrade.TEMPORARY ~= Sewn_API.Enums.NoUpgrade.TEMPORARY) then
                    table.insert(playerAvailableFamiliars, familiar)
                end
            end
            
            if Random:CheckRoll((math.sqrt(#playerAvailableFamiliars * 0.1) + luck * 0.008) * 100, player:GetTrinketRNG(Enums.TrinketType.TRINKET_SEWING_CASE)) then
                local rollFamiliar = player:GetTrinketRNG(Enums.TrinketType.TRINKET_SEWING_CASE):RandomInt(#playerAvailableFamiliars) + 1
                if playerAvailableFamiliars[rollFamiliar] ~= nil and playerAvailableFamiliars[rollFamiliar]:Exists() then
                    Familiar:TemporaryUpgrade(playerAvailableFamiliars[rollFamiliar])
                end
            end
        end
    end
end

return SewingCase