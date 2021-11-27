local Lilith = { }

function Lilith:NewGame()
    local incubuses = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.INCUBUS, -1, false, false)
    for _, incubus in ipairs(incubuses) do
        local fData = incubus:GetData()
        fData.Sewn_noUpgrade = Sewn_API.Enums.NoUpgrade.MACHINE
    end
end

return Lilith