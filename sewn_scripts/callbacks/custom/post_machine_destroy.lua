local SewingMachine = require("sewn_scripts.entities.slot.sewing_machine.sewing_machine")
local SewingMachineManager = require("sewn_scripts.core.sewing_machine_manager")


-- Return true to remove pickups from the machine
local function POST_MACHINE_DESTROY(_, machine)
    local mData = machine:GetData().SewingMachineData
    SewingMachine:TryGetFamiliarBack(machine, false)
    --local removePickups = SewingMachine:MachineDestroy(machine)
    if mData.Sewn_sewingMachineBroken == true then
        SewingMachine:BreakMachine(machine)
        return true
    end
    SewingMachineManager:RepairMachine(machine)
    return true
end

return POST_MACHINE_DESTROY
