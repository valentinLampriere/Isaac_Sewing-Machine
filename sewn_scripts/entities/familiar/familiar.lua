local Enums = require("sewn_scripts.core.enums")
local Globals = require("sewn_scripts.core.globals")
local AvailableFamiliarManager = require("sewn_scripts.core.available_familiars_manager")
local CustomCallbacksHandler = require("sewn_scripts.callbacks.custom_callbacks_handler")
local UpgradeManager = require("sewn_scripts.core.upgrade_manager")

local Familiar = { }

local function SetCrownSprite(familiar)
    local fData = familiar:GetData()
    fData.Sewn_crown = Sprite()
    fData.Sewn_crown:Load("gfx/sewn_familiar_crown.anm2", false)

    if Sewn_API:IsSuper(fData, false) then
        fData.Sewn_crown:Play("Super")
    elseif Sewn_API:IsUltra(fData) then
        fData.Sewn_crown:Play("Ultra")
    end
    fData.Sewn_crown:LoadGraphics()
end

function Familiar:TryInitFamiliar(familiar)
    local fData = familiar:GetData()
    if not fData.Sewn_Init and familiar.FrameCount > 0 then
        local player = familiar.Player

        fData.Sewn_upgradeLevel = fData.Sewn_upgradeLevel or Enums.FamiliarLevel.NORMAL

        local hasTaintedHead = familiar.Player:HasCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD)
        local hasPureBody = familiar.Player:HasCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY)
        if hasTaintedHead and hasPureBody then
            UpgradeManager:TryUpgrade(familiar.Variant, Sewn_API:GetLevel(fData), familiar.Player.Index, Enums.FamiliarLevel.ULTRA)
        elseif hasTaintedHead or hasPureBody then
            UpgradeManager:TryUpgrade(familiar.Variant, Sewn_API:GetLevel(fData), familiar.Player.Index, Enums.FamiliarLevel.SUPER)
        end

        fData.Sewn_Init = true
    end
end

local function CheckCrown(familiar)
    local fData = familiar:GetData()

    -- Not set yet
    if fData.Sewn_crown == nil then
        SetCrownSprite(familiar)
        return
    end
    -- Is super but do not have the gold crown
    if Sewn_API:IsSuper(fData, false) and not fData.Sewn_crown:IsPlaying("Super") then
        SetCrownSprite(familiar)
        return
    end
    -- Is ultra but do not have the diamond crown
    if Sewn_API:IsUltra(fData) and not fData.Sewn_crown:IsPlaying("Ultra") then
        SetCrownSprite(familiar)
        return
    end
    -- Is not super but has the gold crown
    if not Sewn_API:IsSuper(fData, false) and fData.Sewn_crown:IsPlaying("Super") then
        SetCrownSprite(familiar)
        return
    end
    -- Is not ultra but has the diamond crown
    if not Sewn_API:IsUltra(fData) and fData.Sewn_crown:IsPlaying("Ultra") then
        SetCrownSprite(familiar)
        return
    end
end

function Familiar:Update(familiar)
    local fData = familiar:GetData()
    if fData.Sewn_Init ~= true then
        return
    end
    CheckCrown(familiar)
end
function Familiar:CheckForDelirium(familiar)
    local fData = familiar:GetData()
    if familiar.FrameCount == 0 then
        if familiar.Player.FrameCount % 300 == 0 then
            fData.Sewn_isDelirium = true
        else
            fData.Sewn_isDelirium = nil
        end
    elseif familiar.FrameCount > 299 and fData.Sewn_isDelirium then
        fData.Sewn_isDelirium = nil
    end
end

local function GetCrownPosition(familiar)
    --[[
    local pos = Isaac.WorldToScreen(familiar.Position)
    if sewingMachineMod.Config.familiarCrownPosition == sewingMachineMod.CONFIG_CONSTANT.FAMILIAR_CROWN_POSITION.CENTER then
        pos = Vector(pos.X-1, pos.Y - familiar.Size * 2)
    elseif sewingMachineMod.Config.familiarCrownPosition == sewingMachineMod.CONFIG_CONSTANT.FAMILIAR_CROWN_POSITION.RIGHT then
        pos = Vector(pos.X + familiar.Size, pos.Y - familiar.Size * 2)
    end
    --]]

    local fData = familiar:GetData()

    local worldToScreen = Isaac.WorldToScreen(familiar.Position)
    local position = Vector(worldToScreen.X-1, worldToScreen.Y - familiar.Size * 2)

    if fData.Sewn_crownPositionOffset ~= nil then
        position = position - fData.Sewn_crownPositionOffset
    end

    return position
end

function Familiar:AddCrownOffset(familiar, offset)
    local fData = familiar:GetData()
    fData.Sewn_crownPositionOffset = offset
end

function Familiar:HideCrown(familiar, shouldHideCrown)
    shouldHideCrown = shouldHideCrown or true
    local fData = familiar:GetData()
    fData.Sewn_crown_hide = shouldHideCrown
end

function Familiar:RenderCrown(familiar)
    local fData = familiar:GetData()

    if fData.Sewn_Init == nil then return end

    local position = GetCrownPosition(familiar)
    if fData.Sewn_crown ~= nil and fData.Sewn_crown_hide ~= true then
        -- if familiar is super -> has a golden crown
        if Sewn_API:IsSuper(fData, false) then
            fData.Sewn_crown:Render(position, Globals.V0, Globals.V0)
        -- if familiar is ultra-> has a diamond crown
        elseif Sewn_API:IsUltra(fData) then
            fData.Sewn_crown:Render(position, Globals.V0, Globals.V0)
        end
    end
end

function Familiar:IsReady(fData)
    return fData.Sewn_isDelirium ~= true and fData.Sewn_noUpgrade ~= true
end

function Familiar:TemporaryUpgrade(familiar)
    local fData = familiar:GetData()
    if AvailableFamiliarManager:IsFamiliarAvailable(familiar.Variant) and not Sewn_API:IsUltra(fData) then
        --sewingMachineMod:resetFamiliarData(familiar, {"Sewn_upgradeState_temporary"})
        if fData.Sewn_upgradeLevel_temporary == nil then
            fData.Sewn_upgradeLevel_temporary = fData.Sewn_upgradeLevel or Enums.FamiliarLevel.NORMAL
            fData.Sewn_upgradeLevel_temporary = fData.Sewn_upgradeLevel_temporary + 1
        else
            fData.Sewn_upgradeLevel_temporary = fData.Sewn_upgradeLevel_temporary + 1
        end
        
        CustomCallbacksHandler:Evaluate(Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, familiar, false)
    end
end

return Familiar