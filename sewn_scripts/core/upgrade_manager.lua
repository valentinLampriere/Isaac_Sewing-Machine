local UpgradeManager = { }

local Enums = require("sewn_scripts.core.enums")
local Globals = require("sewn_scripts.core.globals")
local AvailableFamiliarManager = require("sewn_scripts.core.available_familiars_manager")
local CustomCallbacksHandler = require("sewn_scripts.callbacks.custom_callbacks_handler")

UpgradeManager.FamiliarsData = { }

local function NewFamiliarData(variant, upgrade, playerIndex, entity)
    local newFamiliarData = {
        Variant = variant,
        Upgrade = upgrade or 0,
        PlayerIndex = playerIndex or 0,
        Entity = entity
    }
    return newFamiliarData
end

function UpgradeManager:ResetUpgrades(bool_keepExistingFamiliarUpgrades)
    bool_keepExistingFamiliarUpgrades = bool_keepExistingFamiliarUpgrades or false
    local _familiarsData = {}
    if bool_keepExistingFamiliarUpgrades then
        local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
        for _, familiar in ipairs(familiars) do
            familiar = familiar:ToFamiliar()
            local fData = familiar:GetData()
            if fData.Sewn_upgradeLevel ~= nil then
                table.insert(_familiarsData, NewFamiliarData(familiar.Variant, fData.Sewn_upgradeLevel, familiar.Player.Index, familiar))
            end
        end
    end
    UpgradeManager.FamiliarsData = _familiarsData
end

function UpgradeManager:SaveUpgrades()
    local familiarsSave = { }
    for _, familiarData in ipairs(UpgradeManager.FamiliarsData) do
        table.insert(familiarsSave, familiarData)
    end
    return familiarsSave
end
function UpgradeManager:LoadUpgrades(loadedData)
    UpgradeManager.FamiliarsData = { }
    for key, familiarData in pairs(loadedData) do
        table.insert(UpgradeManager.FamiliarsData, familiarData)
    end
end

function UpgradeManager:RemoveUpgrade(index)
    table.remove(UpgradeManager.FamiliarsData, index)
end

-- return true when it add the upgrade, false when it update an existing one
function UpgradeManager:AddOrUpdateFamiliarData(fData, upgrade, variant, playerIndex, _table)
    _table = _table or UpgradeManager.FamiliarsData
    if fData == nil then
        table.insert(_table, NewFamiliarData(variant, upgrade, playerIndex))
        return true
    else
        fData.Upgrade = upgrade
        return false
    end
end

--[[function UpgradeManager:FindFamiliarDataWithEntity(entity, table)
    table = table or UpgradeManager.FamiliarsData
    if entity == nil then return end
    for i, fData in ipairs(UpgradeManager.FamiliarsData) do
        if GetPtrHash(entity) == GetPtrHash(fData.Entity) then
            return fData
        end
    end
end--]]
function UpgradeManager:FindFamiliarData(variant, level, playerIndex, _table)
    _table = _table or UpgradeManager.FamiliarsData

    for i, fData in ipairs(_table) do
        --print(tostring(fData.Variant) .. " == " .. tostring(variant) .. " AND " .. tostring(fData.PlayerIndex) .. " == " .. tostring(playerIndex) .. " AND " .. tostring(level) .. " == " .. tostring(fData.Upgrade))
        if fData.Variant == variant and fData.PlayerIndex == playerIndex and level == fData.Upgrade then
            return fData, i
        end
    end
end

-- Return nil if nothing happen
-- return true when it upgrade a new familiar, false when it update an existing one
function UpgradeManager:TryUpgrade(variant, currentLevel, playerIndex, newLevel, _table)
    _table = _table or UpgradeManager.FamiliarsData
    newLevel = newLevel or currentLevel + 1

    if currentLevel == Enums.FamiliarLevel.ULTRA then
        return
    end

    if not AvailableFamiliarManager:IsFamiliarAvailable(variant) then
        return
    end

    -- Prevent from upgrading above ULTRA
    if newLevel >= Enums.FamiliarLevel.ULTRA then
        newLevel = Enums.FamiliarLevel.ULTRA
    end

    local _fData = UpgradeManager:FindFamiliarData(variant, currentLevel, playerIndex, _table)

    return UpgradeManager:AddOrUpdateFamiliarData(_fData, newLevel, variant, playerIndex, _table)
end

function UpgradeManager:UpFamiliar(familiar, newLevel)
    local fData = familiar:GetData()
    fData.Sewn_upgradeLevel = newLevel
    CustomCallbacksHandler:Evaluate(Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, familiar, true)
end


function UpgradeManager:CheckForChanges()
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    
    -- Loop through familiars data to check changes in upgrades
    for i, familiarData in ipairs(UpgradeManager.FamiliarsData) do
        -- If the familiarData hasn't an associated familiar entity
        if familiarData.Entity == nil --[[or familiarData.Entity:Exists() == false--]] then
            local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, familiarData.Variant, -1, false, false)
            
            -- Reverse loop to get the last familiar first
            for j = #familiars, 1, -1 do
                local familiar = familiars[j]:ToFamiliar()
                local fData = familiar:GetData()
                if (fData.Sewn_upgradeLevel == nil or fData.Sewn_upgradeLevel < familiarData.Upgrade) and familiarData.PlayerIndex == familiar.Player.Index and fData.Sewn_noUpgrade ~= true then
                    -- Change familiar's data to prepare stats upgrade
                    --sewingMachineMod:callFamiliarUpgrade(familiar)
                    familiarData.Entity = familiar
                    UpgradeManager:UpFamiliar(familiar, familiarData.Upgrade)
                    break
                end
            end
        else
            local fData = familiarData.Entity:GetData()
            if fData.Sewn_upgradeLevel == nil or fData.Sewn_upgradeLevel < familiarData.Upgrade then
                -- Change familiar's data to prepare stats upgrade
                UpgradeManager:UpFamiliar(familiarData.Entity, familiarData.Upgrade)
                --sewingMachineMod:callFamiliarUpgrade(familiarData.Entity)
            elseif fData.Sewn_upgradeLevel > familiarData.Upgrade then
                --sewingMachineMod:resetFamiliarData(familiarData.Entity)
                UpgradeManager:UpFamiliar(familiarData.Entity, familiarData.Upgrade)
            end
        end
    end
end

function UpgradeManager:ResetTemporaryUpgrades()
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    for _, familiar in ipairs(familiars) do
        local fData = familiar:GetData()
        local hasUpgrade = false
        familiar = familiar:ToFamiliar()
        
        if fData.Sewn_upgradeLevel_temporary ~= nil and fData.Sewn_upgradeLevel_temporary ~= Enums.FamiliarLevel.NORMAL then
            hasUpgrade = true
        end
        fData.Sewn_upgradeLevel_temporary = nil

        if hasUpgrade == true then
            CustomCallbacksHandler:Evaluate(Enums.ModCallbacks.ON_FAMILIAR_LOSE_UPGRADE, familiar, false)
        end
    end
end

function UpgradeManager:RerollUpgrades(player, rng)
    rng = rng or Globals.rng

    local allowedFamiliars = {}
    local countCrowns = 0

    local crownSaveValue = 0
    local crownRetrieveValue = 0

    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    for _, familiar in pairs(familiars) do
        local fData = familiar:GetData()
        familiar = familiar:ToFamiliar()

        fData.Sewn_upgradeLevel = fData.Sewn_upgradeLevel or Enums.FamiliarLevel.NORMAL

        if GetPtrHash(familiar.Player) == GetPtrHash(player) and AvailableFamiliarManager:IsFamiliarAvailable(familiar.Variant) then
            table.insert(allowedFamiliars, familiar)
            countCrowns = countCrowns + Sewn_API:GetLevel(fData)

            crownSaveValue = crownSaveValue + familiar.Variant * Sewn_API:GetLevel(fData)

            --[[if Sewn_API:IsSuper(fData) then
                crownSaveValue = crownSaveValue + familiar.Variant
            end
            if Sewn_API:IsUltra(fData) then
                crownSaveValue = crownSaveValue + familiar.Variant
                crownSaveValue = crownSaveValue + familiar.Variant
            end--]]

            fData.Sewn_upgradeLevel = Enums.FamiliarLevel.NORMAL

            --sewingMachineMod:resetFamiliarData(familiar)
        end
    end

    local attemptCounter = 0
    local copy_familiarData = {}
    local copy_crownRetrieveValue = crownRetrieveValue
    while (crownRetrieveValue == 0 or crownRetrieveValue == crownSaveValue) and attemptCounter < 4 do
        crownRetrieveValue = copy_crownRetrieveValue

        local tmp_upgradeLevels = {}
        copy_familiarData = {}
        local copy_allowedFamiliars = allowedFamiliars
        local copy_countCrowns = countCrowns

        while #copy_allowedFamiliars > 0 and copy_countCrowns > 0 do
            local familiar_index = rng:RandomInt(#copy_allowedFamiliars) + 1
            local familiar = copy_allowedFamiliars[familiar_index]
            
            local upgradeLevel = tmp_upgradeLevels[GetPtrHash(familiar)] or 0

            
            if UpgradeManager:TryUpgrade(familiar.Variant, upgradeLevel, player.Index, upgradeLevel + 1, copy_familiarData) ~= nil then
                copy_countCrowns = copy_countCrowns -1
                crownRetrieveValue = crownRetrieveValue + copy_allowedFamiliars[familiar_index].Variant
                tmp_upgradeLevels[GetPtrHash(familiar)] = upgradeLevel + 1
            end

            --[[local _fData = UpgradeManager:FindFamiliarData(familiar.Variant, upgradeLevel, player.Index, copy_familiarData)
            --local _fData = sewingMachineMod:findFamiliarData(familiar.Variant, upgradeLevel, player, copy_familiarData)
            if upgradeLevel ~= Enums.FamiliarLevel.ULTRA then
                if _fData == nil then
                    --table.insert(copy_familiarData, newFamiliarData(familiar.Variant, upgradeLevel + 1, player, familiar))
                    table.insert(copy_familiarData, NewFamiliarData(familiar.Variant, upgradeLevel + 1, player.Index, familiar))
                else
                    _fData.Upgrade = upgradeLevel + 1
                end

                copy_countCrowns = copy_countCrowns -1

                crownRetrieveValue = crownRetrieveValue + copy_allowedFamiliars[familiar_index].Variant

                tmp_upgradeLevels[GetPtrHash(familiar)] = upgradeLevel + 1
            end--]]
            if upgradeLevel == Enums.FamiliarLevel.ULTRA then
                table.remove(copy_allowedFamiliars, familiar_index)
            end
        end
        attemptCounter = attemptCounter + 1
    end

    UpgradeManager.FamiliarsData = copy_familiarData
end

return UpgradeManager