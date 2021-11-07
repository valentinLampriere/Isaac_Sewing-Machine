local UpgradeManager = require("sewn_scripts/core/upgrade_manager")
local Enums = require("sewn_scripts/core/enums")
local Random = require("sewn_scripts/helpers/random")

local CrackedThimble = { }

CrackedThimble.Stats = {
    TriggerChance = 100
}

function CrackedThimble:OnPlayerTakeDamage(player, flags, source)
    if not player:HasTrinket(Enums.TrinketType.TRINKET_CRACKED_THIMBLE) then
        return
    end
    if flags & DamageFlag.DAMAGE_CURSED_DOOR == DamageFlag.DAMAGE_CURSED_DOOR or
    flags & DamageFlag.DAMAGE_IV_BAG == DamageFlag.DAMAGE_IV_BAG or 
    flags & DamageFlag.DAMAGE_CHEST == DamageFlag.DAMAGE_CHEST then
        return
    end

    local crackedThimbleRng = player:GetTrinketRNG(Enums.TrinketType.TRINKET_CRACKED_THIMBLE)
    if Random:CheckRoll(CrackedThimble.Stats.TriggerChance, crackedThimbleRng) then
        UpgradeManager:RerollUpgrades(player, crackedThimbleRng)
    end
end

return CrackedThimble