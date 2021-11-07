local SewingMachine = require("sewn_scripts/entities/slot/sewing_machine/sewing_machine")

local function POST_MACHINE_UPDATE(_, machine)
    SewingMachine:MachineUpdate(machine)
end

return POST_MACHINE_UPDATE
