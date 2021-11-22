local GetPlayerUsingItem = require("sewn_scripts.helpers.get_player_using_item")
local Delay = require("sewn_scripts.helpers.delay")
local UpgradeManager = require("sewn_scripts.core.upgrade_manager")

local GlowingHourglass = { }

local upgradeSaves = { }

function GlowingHourglass:OnUseItem(collectibleType, rng)
    if collectibleType ~= CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS then
        return
    end

    UpgradeManager:LoadUpgrades(upgradeSaves)
end

function GlowingHourglass:OnNewRoom()
    upgradeSaves = UpgradeManager:SaveUpgrades()
end

return GlowingHourglass