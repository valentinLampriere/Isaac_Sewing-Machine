local Delay = require("sewn_scripts.helpers.delay")

local DeadCat = { }

DeadCat.Stats = {
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.DEAD_CAT, CollectibleType.COLLECTIBLE_DEAD_CAT)

local function Respawn(player, isUltra)
    player:AddSoulHearts(2)

    if isUltra then
        player:AddMaxHearts(2, true)
        player:AddHearts(2)
    end
end

function DeadCat:OnFamiliarUpdated(familiar)
    local fData = familiar:GetData()
    local extraLives = familiar.Player:GetExtraLives()

    local _extraLives = familiar.Player:GetExtraLives()
    if fData.Sewn_deadCat_extraLives == _extraLives + 1 then
        Respawn(familiar.Player, Sewn_API:IsUltra(fData))
    end
    fData.Sewn_deadCat_extraLives = extraLives
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, DeadCat.OnFamiliarUpdated, FamiliarVariant.DEAD_CAT)