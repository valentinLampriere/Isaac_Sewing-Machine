local GetPlayerUsingItem = require("sewn_scripts.helpers.get_player_using_item")
local Delay = require("sewn_scripts.helpers.delay")
local Familiar = require("sewn_scripts.entities.familiar.familiar")

local BoxOfFriends = { }

local function TryCopyCrown(familiar)
    local higherCrown = Sewn_API.Enums.FamiliarLevel.NORMAL
    local sameFamiliars = Isaac.FindByType(familiar.Type, familiar.Variant, -1, false, false)
    for j, _familiar in ipairs(sameFamiliars) do
        if _familiar.FrameCount > 0 then
            local fData = _familiar:GetData()
            local level = Sewn_API:GetLevel(fData)
            if level > higherCrown then
                higherCrown = level
            end
        end
    end
    Familiar:TemporaryUpgrade(familiar, higherCrown)
end

local function TryAssociateCopyFamiliarToPermanent(familiar)
    local fData = familiar:GetData()
    local sameFamiliars = Isaac.FindByType(familiar.Type, familiar.Variant, -1, false, false)
    for j, _familiar in ipairs(sameFamiliars) do
        if _familiar.FrameCount <= 1 then
            if fData.Sewn_boxOfFriends_potentialCopy == nil then
                fData.Sewn_boxOfFriends_potentialCopy = { }
            end
            table.insert(fData.Sewn_boxOfFriends_potentialCopy, _familiar)
        end
    end
end

function BoxOfFriends:OnUseItem(collectibleType, rng)
    if collectibleType ~= CollectibleType.COLLECTIBLE_BOX_OF_FRIENDS then
        return
    end
    local player = GetPlayerUsingItem()
    
    Delay:DelayFunction(function ()
        local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)

        -- Detecting familiars which just spawn
        for _, familiar in ipairs(familiars) do
            familiar = familiar:ToFamiliar()
            if GetPtrHash(player) == GetPtrHash(familiar.Player) then
                if familiar.FrameCount <= 1 then
                    TryCopyCrown(familiar)
                    familiar:GetData().Sewn_noUpgrade = Sewn_API.Enums.NoUpgrade.MACHINE
                else
                    TryAssociateCopyFamiliarToPermanent(familiar)
                end
            end
        end
    end)
end

function BoxOfFriends:AddFamiliarInMachine(familiar, machine)
    local fData = familiar:GetData()
    if fData.Sewn_boxOfFriends_potentialCopy ~= nil then
        for _, copyFamiliar in ipairs(fData.Sewn_boxOfFriends_potentialCopy) do
            copyFamiliar:Remove()
        end
    end
end

function BoxOfFriends:OnNewRoom()
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)
    for _, familiar in ipairs(familiars) do
        local fData = familiar:GetData()
        fData.Sewn_boxOfFriends_potentialCopy = nil
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.PRE_ADD_FAMILIAR_IN_SEWING_MACHINE, BoxOfFriends.AddFamiliarInMachine)

return BoxOfFriends