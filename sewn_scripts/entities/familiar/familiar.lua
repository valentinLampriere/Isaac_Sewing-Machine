local Enums = require("sewn_scripts/core/enums")
local Globals = require("sewn_scripts/core/globals")
local AvailableFamiliarManager = require("sewn_scripts/core/available_familiars_manager")

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

        --[[if sewingMachineMod:isAvailable(familiar.Variant) then
            if not sewingMachineMod:isUltra(fData) or fData.Sewn_upgradeLevel == nil then
                -- Set the familiar as an available familiar (available for the Sewing machine)
                if familiar:GetData().Sewn_noUpgrade ~= true then
                    
                    -- Add the familiar to the "Temporary Familiars" table
                    temporaryFamiliars[GetPtrHash(familiar)] = familiar
                end
            end
        end--]]
        --[[if fData.Sewn_upgradeLevel == nil and sewingMachineMod:isAvailable(familiar.Variant) then
            local hasDollsHead = player:HasCollectible(CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD)
            local hasDollsBody = player:HasCollectible(CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY)
            if hasDollsHead and not hasDollsBody or not hasDollsHead and hasDollsBody then
                fData.Sewn_upgradeLevel = sewingMachineMod.UpgradeState.SUPER
                sewingMachineMod:callFamiliarUpgrade(familiar)
            elseif hasDollsHead and hasDollsBody then
                fData.Sewn_upgradeLevel = sewingMachineMod.UpgradeState.ULTRA
                sewingMachineMod:callFamiliarUpgrade(familiar)
            else
                fData.Sewn_upgradeLevel = sewingMachineMod.UpgradeState.NORMAL
            end
        end--]]

        fData.Sewn_upgradeLevel = fData.Sewn_upgradeLevel or Enums.FamiliarLevel.NORMAL
        
        fData.Sewn_crown = nil
        fData.Sewn_Init = true
    end
end

function Familiar:Update(familiar)
    local fData = familiar:GetData()
    if fData.Sewn_crown == nil and fData.Sewn_Init == true then
        SetCrownSprite(familiar)
    end
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

    local worldToScreen = Isaac.WorldToScreen(familiar.Position)
    return Vector(worldToScreen.X-1, worldToScreen.Y - familiar.Size * 2)
end
function Familiar:RenderCrown(familiar)
    local fData = familiar:GetData()

    if fData.Sewn_Init == nil then return end

    local position = GetCrownPosition(familiar)
    
    if fData.Sewn_crown ~= nil and fData.Sewn_crown_hide ~= true then
        if fData.Sewn_crownPositionOffset ~= nil then
            position = position - fData.Sewn_crownPositionOffset
        end
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
    return fData.Sewn_isDelirium ~= true
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
        --sewingMachineMod:callFamiliarUpgrade(familiar)
        fData.Sewn_crown = nil
    end
end

return Familiar