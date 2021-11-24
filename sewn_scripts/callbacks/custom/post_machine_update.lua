local SewingMachine = require("sewn_scripts.entities.slot.sewing_machine.sewing_machine")
local MachineDataManager = require("sewn_scripts.core.machine_data_manager")

local function POST_MACHINE_UPDATE(_, machine)
    MachineDataManager:TryMatchMachineData(machine)
    local mData = machine:GetData().SewingMachineData
    if mData == nil then
        return
    end
    SewingMachine:HandleMachineAnimation(machine)
    SewingMachine:HandleMachineCooldown(machine)
    SewingMachine:SetPlayeCloseFromMachine(machine)
end

return POST_MACHINE_UPDATE
