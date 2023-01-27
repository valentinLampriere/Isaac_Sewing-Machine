local Enums = require("sewn_scripts.core.enums")
local Globals = require("sewn_scripts.core.globals")
local Familiar = require("sewn_scripts.entities.familiar.familiar")
local GetPlayerUsingItem = require("sewn_scripts.helpers.get_player_using_item")
local AvailableFamiliarManager = require("sewn_scripts.core.available_familiars_manager")
local UpgradeManager = require("sewn_scripts.core.upgrade_manager")

local SewingBox = { }

SewingBox.NonSpawnableFamiliars = {
    FamiliarVariant.PEEPER, -- Because it evaluate cache flags
    FamiliarVariant.PASCHAL_CANDLE, -- Because it evaluate cache flags
    FamiliarVariant.LITTLE_CHAD,
    FamiliarVariant.DEAD_CAT,
    FamiliarVariant.ONE_UP,
    FamiliarVariant.ISAACS_HEART,
    FamiliarVariant.BLOOD_OATH,
    FamiliarVariant.TWISTED_BABY,
}

local hasUseSewingBox = false

local function SpawnRandomAvailableFamiliar(player, rng)
    local familiarVariant = AvailableFamiliarManager:GetRandomAvailableFamiliars(rng, table.unpack(SewingBox.NonSpawnableFamiliars))
    
    local familiar = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, familiarVariant, 0, player.Position, Globals.V0, player):ToFamiliar()
    UpgradeManager:UpFamiliar(familiar, Sewn_API.Enums.FamiliarLevel.SUPER)
end

function SewingBox:OnUseItem(collectibleType, rng)
    if collectibleType ~= Enums.CollectibleType.COLLECTIBLE_SEWING_BOX then
        return
    end
    local player = GetPlayerUsingItem()
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    local hasUpgradeFamiliars = false
    for _, familiar in ipairs(familiars) do
        familiar = familiar:ToFamiliar()
        if familiar.Player and GetPtrHash(familiar.Player) == GetPtrHash(player) then
            if Familiar:TemporaryUpgrade(familiar) == true then
                hasUpgradeFamiliars = true
            end
        end
    end

    if hasUpgradeFamiliars == false then
        SpawnRandomAvailableFamiliar(player, rng)
    end

    hasUseSewingBox = true

    return true
end

function SewingBox:OnNewRoom()
    if hasUseSewingBox == true then
        local playerCount = Globals.Game:GetNumPlayers()
        for i = 1, playerCount do
            local player = Isaac.GetPlayer(i - 1)
            player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
            player:EvaluateItems()
        end

        hasUseSewingBox = false
    end
end

return SewingBox