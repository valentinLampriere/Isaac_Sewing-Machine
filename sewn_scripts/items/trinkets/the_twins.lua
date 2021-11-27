local Enums = require("sewn_scripts.core.enums")
local Globals = require("sewn_scripts.core.globals")
local Delay = require("sewn_scripts.helpers.delay")
local TheTwins = { }


local function CheckFamiliarsSpawn(player)
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    for _, familiar in ipairs(familiars) do
        familiar = familiar:ToFamiliar()
        if GetPtrHash(player) == GetPtrHash(familiar.Player) then
            if familiar.FrameCount == 1 then
                local fData = familiar:GetData()
                fData.Sewn_noUpgrade = Sewn_API.Enums.NoUpgrade.MACHINE
            end
        end
    end
end

function TheTwins:OnNewRoom()
    for i = 1, Globals.Game:GetNumPlayers() do
        local player = Isaac.GetPlayer(i - 1)
        if player:HasTrinket(TrinketType.TRINKET_THE_TWINS) then
            Delay:DelayFunction(CheckFamiliarsSpawn, 0, true, player)
        end
    end
end

return TheTwins