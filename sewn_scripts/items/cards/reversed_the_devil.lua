local Enums = require("sewn_scripts.core.enums")
local Globals = require("sewn_scripts.core.globals")
local SewingMachineManager = require("sewn_scripts.core.sewing_machine_manager")
local Delay = require("sewn_scripts.helpers.delay")

local ReversedTheDevil = { }

function ReversedTheDevil:OnUse(card, player, useFlags)
    if card ~= Card.CARD_REVERSE_DEVIL then
        return
    end
    Delay:DelayFunction(function ()
        local seraphims = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.SERAPHIM, -1, false, false)
        for _, seraphim in ipairs(seraphims) do
            seraphim = seraphim:ToFamiliar()
            if GetPtrHash(player) == GetPtrHash(seraphim.Player) then
                if seraphim.FrameCount <= 1 then
                    local fData = seraphim:GetData()
                    fData.Sewn_noUpgrade = true
                end
            end
        end
    end)
end

return ReversedTheDevil