local SewingMachine = require("sewn_scripts/entities/slot/sewing_machine/sewing_machine")

local function POST_PLAYER_TOUCH_MACHINE(_, player, machine)
    SewingMachine:PlayerTouchMachine(player, machine)
end

return POST_PLAYER_TOUCH_MACHINE
