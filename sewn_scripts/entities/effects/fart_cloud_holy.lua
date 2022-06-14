local FartCloud = require("sewn_scripts.entities.effects.fart_cloud")

local FartCloudHoly = { }

FartCloudHoly.SubType = 79
FartCloudHoly.PlayersTracker = { }

FartCloudHoly.Stats = {
    TearsBonusMaxPercentage = 0.25,
    DamageBonusMaxPercentage = 0.2
}

function FartCloudHoly:OnPlayerCollide(effect, player)
    if FartCloudHoly.PlayersTracker[player.Index] == nil then
        player.FireDelay = math.min(player.FireDelay, player.MaxFireDelay)
        player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY | CacheFlag.CACHE_DAMAGE)
        player:EvaluateItems()

        FartCloudHoly.PlayersTracker[player.Index] = player
    end
end

function FartCloudHoly:EffectUpdate(effect)
    for _, player in pairs(FartCloudHoly.PlayersTracker) do
        if (effect.Position - player.Position):LengthSquared() > FartCloud.Radius * FartCloud.Radius then
            player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY | CacheFlag.CACHE_DAMAGE)
            player:EvaluateItems()
            FartCloudHoly.PlayersTracker[player.Index] = nil
        end
    end
end

function FartCloudHoly:OnEvaluateCache(player, cacheFlag)
    if FartCloudHoly.PlayersTracker[player.Index] ~= nil then
        local pData = player:GetData()
        if cacheFlag == CacheFlag.CACHE_FIREDELAY then
            player.MaxFireDelay = player.MaxFireDelay - player.MaxFireDelay * pData.Sewn_holyFart_timeLeft * (FartCloudHoly.Stats.TearsBonusMaxPercentage / FartCloudHoly.Stats.BonusTime)
        elseif cacheFlag == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage + player.Damage * pData.Sewn_holyFart_timeLeft * (FartCloudHoly.Stats.DamageBonusMaxPercentage / FartCloudHoly.Stats.BonusTime)
        end
    end
end

FartCloud:RegisterPlayerFartCloud(FartCloudHoly)

return FartCloudHoly