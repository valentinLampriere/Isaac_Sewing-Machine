local CrackedThimble = require("sewn_scripts/items/trinkets/cracked_thimble")

local EntityTakeDamage = { }

function EntityTakeDamage:Player(player, amount, flags, source, countdown)
    player = player:ToPlayer()
    CrackedThimble:OnPlayerTakeDamage(player, flags, source)
end

return EntityTakeDamage
