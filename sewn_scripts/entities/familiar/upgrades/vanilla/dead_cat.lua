local Delay = require("sewn_scripts.helpers.delay")

local DeadCat = { }

DeadCat.Stats = {
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.DEAD_CAT, CollectibleType.COLLECTIBLE_DEAD_CAT)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.DEAD_CAT,
    "When the player dies, they respawn with an additional soul heart {{SoulHeart}}",
    "When the player dies, they respawn with an additional red heart container {{Heart}} and an additional soul heart {{SoulHeart}}", nil, "Dead Cat"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.DEAD_CAT,
    "角色复活时额外生成一个魂心",
    "角色复活时额外生成一个魂心的同时额外获得一个心之容器", nil, "嗝屁猫","zh_cn"
)
Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.DEAD_CAT,
    nil, nil,
    "Gives a soul heart even if the player respawn without Dead Cat (due to API limitation)"
)

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