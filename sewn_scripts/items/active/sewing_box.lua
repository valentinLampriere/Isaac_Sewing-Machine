local Enums = require("sewn_scripts.core.enums")
local Familiar = require("sewn_scripts.entities.familiar.familiar")
local GetPlayerUsingItem = require("sewn_scripts.helpers.get_player_using_item")

local SewingBox = { }

function SewingBox:OnUseItem(collectibleType, rng)
    if collectibleType ~= Enums.CollectibleType.COLLECTIBLE_SEWING_BOX then
        return
    end
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

return SewingBox