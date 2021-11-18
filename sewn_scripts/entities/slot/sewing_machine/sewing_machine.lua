local Globals = require("sewn_scripts.core.globals")
local Enums = require("sewn_scripts.core.enums")
local Player = require("sewn_scripts.entities.player.player")
local SewingMachineTypes = require("sewn_scripts.entities.slot.sewing_machine.sewing_machine_types")
local UpgradeManager = require("sewn_scripts.core.upgrade_manager")
local AvailableFamiliarManager = require("sewn_scripts.core.available_familiars_manager")
local Random = require("sewn_scripts.helpers.random")
local CustomCallbacksHandler = require("sewn_scripts.callbacks.custom_callbacks_handler")
local SewingMachineDescription = require("sewn_scripts.mod_compat.eid.sewing_machine_description")

local SewingMachine = { }

SewingMachine.Stats = require("sewn_scripts.entities.slot.sewing_machine.sewing_machine_stats")

-------------------------------
-- POST_PLAYER_TOUCH_MACHINE --
-------------------------------
function SewingMachine:PlayerTouchMachine(player, machine)
    local mData = machine:GetData().SewingMachineData

    if mData.Sewn_touchCooldown > 0 then
        return -- The machine is in a cooldown state
    end

    if mData.Sewn_player ~= nil and GetPtrHash(mData.Sewn_player) ~= GetPtrHash(player) then
        return
    end

    if mData.Sewn_currentFamiliarVariant == nil then
        SewingMachine:TryAddFamiliarInMachine(machine, player)
    else
        SewingMachine:TryGetFamiliarBack(machine, true)
    end

    mData.Sewn_touchCooldown = SewingMachine.Stats.PlayerTouchCooldown
end

local function SetMachineAnimation(machine)
    local machineSprite = machine:GetSprite()

    if machineSprite:IsFinished("Appear") then
        machineSprite:Play("Idle")
    elseif machineSprite:IsFinished("Disappear") then
        machine:Remove()
    end
end

-------------------------
-- POST_MACHINE_UPDATE --
-------------------------
function SewingMachine:MachineUpdate(machine)
    local mData = machine:GetData().SewingMachineData

    SetMachineAnimation(machine)

    -- Reduce machine cooldown
    if mData.Sewn_touchCooldown > 0 then
        mData.Sewn_touchCooldown = mData.Sewn_touchCooldown - 1
    end
end

--------------------------
-- POST_MACHINE_DESTROY --
--------------------------
function SewingMachine:BreakMachine(machine)

    local machineSprite = machine:GetSprite()
    local machineType = SewingMachineTypes:GetSewingMachineType(machine.SubType)

    print("BreakMachine")

    if machineType.ShouldDisappearOnBreak == true then
        machineSprite:Play("Disappear")
    else
        machineSprite:Play("Broken")
    end
    if machineType.ShouldExplodeOnBreak == true then
        Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BOMB_EXPLOSION, 0, machine.Position, Globals.V0, nil)
    end
end

local function GetFamiliarSprite(familiarVariant)
    local curse = Globals.Game:GetLevel():GetCurses()
    if curse == LevelCurse.CURSE_OF_BLIND then
        return AvailableFamiliarManager:GetFamiliarSprite(-1)
    end
    return AvailableFamiliarManager:GetFamiliarSprite(familiarVariant)
end

function SewingMachine:SetIdleAnim(machine)
    local machineSprite = machine:GetSprite()
    machineSprite:Play("Idle")
    machineSprite:LoadGraphics()
end
function SewingMachine:SetFloatingAnim(machine)
    local machineSprite = machine:GetSprite()
    local mData = machine:GetData().SewingMachineData
    machineSprite:ReplaceSpritesheet(1, GetFamiliarSprite(mData.Sewn_currentFamiliarVariant))
    machineSprite:Play("IdleFloating")
    machineSprite:LoadGraphics()
end

-- Try to put a familiar from the given player in the machine
-- Called when a player touch a Sewing Machine (and there is no familiar in it)
function SewingMachine:TryAddFamiliarInMachine(machine, player)
    local mData = machine:GetData().SewingMachineData
    local pData = player:GetData()
    local availableFamiliars = Player:GetAvailableFamiliars(player)

    -- Does nothing if the player has no available familiars
    if #availableFamiliars == 0 then
        return
    end

    local rollFamiliar = machine:GetDropRNG():RandomInt(#availableFamiliars) + 1
    local choosenFamiliar = availableFamiliars[rollFamiliar]

    CustomCallbacksHandler:Evaluate(Enums.ModCallbacks.PRE_ADD_FAMILIAR_IN_SEWING_MACHINE, machine, choosenFamiliar)

    mData.Sewn_currentFamiliarVariant = choosenFamiliar.Variant
    mData.Sewn_currentFamiliarSubType = choosenFamiliar.SubType
    mData.Sewn_currentFamiliarLevel = choosenFamiliar:GetData().Sewn_upgradeLevel or 0

    mData.Sewn_player = player

    -- Replace the sprite with the familiar (the sprite is the image of the collectible, not the familiar itself)
    SewingMachine:SetFloatingAnim(machine)

    -- Remove the familiar from Isaac
    if pData.Sewn_familiarsInMachine == nil then
        pData.Sewn_familiarsInMachine = {}
    end

    pData.Sewn_familiarsInMachine[machine.InitSeed] = choosenFamiliar.Variant
    
    --local allFamiliarsForChoosenVariant = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, choosenFamiliar.Variant, -1, false, false)

    local _fData, _i = UpgradeManager:FindFamiliarData(choosenFamiliar.Variant, mData.Sewn_currentFamiliarLevel, player.Index)
    if _fData ~= nil then
        UpgradeManager:RemoveUpgrade(_i)
    end
    
    choosenFamiliar:Remove()

    SewingMachineDescription:SetMachineDescription(machine)
    --local allFamiliarsForChoosenVariant = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, choosenFamiliar.Variant, -1, false, false)
    --player:CheckFamiliar(choosenFamiliar.Variant, #allFamiliarsForChoosenVariant - 1, machine:GetDropRNG())
end

local function TryBreakMachine(machine, isUpgrade)
    local mData = machine:GetData().SewingMachineData
    local machineType = SewingMachineTypes:GetSewingMachineType(machine.SubType)
    mData.Sewn_machineUsed_counter = mData.Sewn_machineUsed_counter or 0

    if isUpgrade then
        mData.Sewn_machineUsed_counter = mData.Sewn_machineUsed_counter + 1
    end

    local chancePerUse = machineType.BreakChancePerUse or SewingMachine.Stats.DefaultBreakChanceForEachUse
    local flatBreakChance = machineType.BreakChanceFlat or SewingMachine.Stats.DefaultFlatBreakChance
    flatBreakChance = isUpgrade and flatBreakChance or 0
    if Random:CheckRoll(mData.Sewn_machineUsed_counter * chancePerUse + flatBreakChance, machine:GetDropRNG()) then
        machine:TakeDamage(100, DamageFlag.DAMAGE_EXPLOSION, EntityRef(machine), 1)
        mData.Sewn_sewingMachineBroken = true
    end
end

-- Try to give the familiar back to the player
-- Called when a player interact a second time with a Sewing Machine, or when a sewing machine is bombed
function SewingMachine:TryGetFamiliarBack(machine, isUpgrade)
    local mData = machine:GetData().SewingMachineData

    if mData.Sewn_player == nil or mData.Sewn_currentFamiliarVariant == nil then
        return
    end
    
    if CustomCallbacksHandler:Evaluate(Enums.ModCallbacks.PRE_GET_FAMILIAR_FROM_SEWING_MACHINE, machine, mData.Sewn_player, isUpgrade) == true then
        print("Pre Get Familiar true")
        return
    end
    
    if isUpgrade and not SewingMachineTypes:CanPay(mData.Sewn_player, machine.SubType) then
        return -- Can't pay the cost
    end

    local familiarFromMachine = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, mData.Sewn_currentFamiliarVariant, 0, machine.Position, Globals.V0, nil):ToFamiliar()
    local fData = familiarFromMachine:GetData()
    fData.Sewn_upgradeLevel = mData.Sewn_currentFamiliarLevel


    -- Play the normal animation (without the floating familiar)
    SewingMachine:SetIdleAnim(machine)
    
    -- sewnFamiliar:GetData().Sewn_familiarReady = true

    mData.Sewn_player:GetData().Sewn_familiarsInMachine[machine.InitSeed] = nil
    
    local preventExplosion = false

    -- Upgrade the familiar
    if isUpgrade then
        local fixedUpgradeLevel = SewingMachineTypes:GetSewingMachineType(machine.SubType).FixedUpgradeLevel
        UpgradeManager:TryUpgrade(mData.Sewn_currentFamiliarVariant, mData.Sewn_currentFamiliarLevel, mData.Sewn_player.Index, fixedUpgradeLevel)
        --[[local _fData = FamiliarData:FindFamiliarData(mData.Sewn_currentFamiliarVariant, mData.Sewn_currentFamiliarLevel, mData.Sewn_player.Index)

        local newUpgrade = mData.Sewn_currentFamiliarLevel + 1
        --if machine.SubType == sewingMachineMod.SewingMachineSubType.EVIL then
        --    newUpgrade = sewingMachineMod.UpgradeState.ULTRA
        --end

        FamiliarData:AddOrUpdateFamiliarData(_fData, newUpgrade, mData.Sewn_currentFamiliarVariant, mData.Sewn_player.Index)
        --if _fData == nil then
            --table.insert(sewingMachineMod.familiarData, newFamiliarData(sewnFamiliar.Variant, newUpgrade, mData.Sewn_player.Index))
        --else
            --_fData.Upgrade = newUpgrade
        --end
        --]]
        SewingMachineTypes:Pay(mData.Sewn_player, machine.SubType)
        --sewingMachineMod:payCost(machine, mData.Sewn_player)

        local _preventExplosion = CustomCallbacksHandler:Evaluate(Enums.ModCallbacks.POST_GET_FAMILIAR_FROM_SEWING_MACHINE, machine, mData.Sewn_player, familiarFromMachine, true, fixedUpgradeLevel or mData.Sewn_currentFamiliarLevel + 1)
        if _preventExplosion == true then
            preventExplosion = true
        end
    else
        local _preventExplosion = CustomCallbacksHandler:Evaluate(Enums.ModCallbacks.POST_GET_FAMILIAR_FROM_SEWING_MACHINE, machine, mData.Sewn_player, familiarFromMachine, false, mData.Sewn_currentFamiliarLevel)
        if _preventExplosion == true then
            preventExplosion = true
        end
    end

    -- Reset the machine data to nil
    mData.Sewn_currentFamiliarLevel = nil
    mData.Sewn_currentFamiliarVariant = nil
    --mData.Sewn_player:GetData().Sewn_machine_upgradeFree = nil
    mData.Sewn_player = nil

    TryBreakMachine(machine, isUpgrade and not preventExplosion)
    SewingMachineDescription:ResetMachineDescription(machine)
end

return SewingMachine