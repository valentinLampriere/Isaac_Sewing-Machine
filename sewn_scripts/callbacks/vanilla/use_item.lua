local Familiar = require("sewn_scripts/entities/familiar/familiar")
local GetPlayerUsingItem = require("sewn_scripts/helpers/get_player_using_item")

local MC_USE_ITEM = { }

function MC_USE_ITEM:UseSewingBox(collectibleType, rng)
    local player = GetPlayerUsingItem()
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    for _, familiar in ipairs(familiars) do
        familiar = familiar:ToFamiliar()
        if familiar.Player and GetPtrHash(familiar.Player) == GetPtrHash(player) then
            Familiar:TemporaryUpgrade(familiar)
        end
    end
    return true
end

return MC_USE_ITEM
