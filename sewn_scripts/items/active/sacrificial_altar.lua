local GetPlayerUsingItem = require("sewn_scripts.helpers.get_player_using_item")
local Delay = require("sewn_scripts.helpers.delay")
local UpgradeManager = require("sewn_scripts.core.upgrade_manager")
local Globals = require("sewn_scripts.core.globals")

local SacrificialAltar = { }

function SacrificialAltar:OnUseItem(collectibleType, rng)
    if collectibleType ~= CollectibleType.COLLECTIBLE_SACRIFICIAL_ALTAR then
        return
    end
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)

    Delay:DelayFunction(function ()
        local _familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)

        for i, familiar in ipairs(familiars) do
            for j, _familiar in ipairs(_familiars) do
                if GetPtrHash(familiar) == GetPtrHash(_familiar) then
                    table.remove(familiars, i)
                end
            end
        end

        local dataToRemove = {}
        for i, familiar in ipairs(familiars) do
            familiar = familiar:ToFamiliar()

            for j, familiarData in ipairs(UpgradeManager.FamiliarsData) do
                if GetPtrHash(familiarData.Entity) == GetPtrHash(familiar) then
                    for i = 1, familiarData.Upgrade do
                        local position = Globals.Room:FindFreePickupSpawnPosition(familiar.Position, 0)
                        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_BLACK, position, Globals.V0, nil)
                    end
                    table.insert(dataToRemove, j)
                end
            end
        end
        
        for _, index in ipairs(dataToRemove) do
            UpgradeManager.FamiliarsData[index] = nil
        end
    end)
end

return SacrificialAltar