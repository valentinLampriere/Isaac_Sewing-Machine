local Globals = require("sewn_scripts.core.globals")
local Fart = require("sewn_scripts.entities.effects.fart")
local Delay = require("sewn_scripts.helpers.delay")

local HolyFart = { }
HolyFart.SubType = 76
HolyFart.Gfx = "/gfx/effects/holy_fart.png"

HolyFart.Stats = {
    TearsBonusMaxPercentage = 0.75,
    DamageBonusMaxPercentage = 0.5,
    BonusTime = 60
}

local FART_SIZE = 75
local GIGA_FART_MULTIPLIER = 2

local function GetPlayers(position)
    local players = { }
    for i = 1, Globals.Game:GetNumPlayers() do
        local player = Isaac.GetPlayer(i - 1)

        local hasGiganteBean = REPENTANCE and player:HasTrinket(TrinketType.TRINKET_GIGANTE_BEAN) or false
        local size = hasGiganteBean and FART_SIZE * GIGA_FART_MULTIPLIER or FART_SIZE

        if (position - player.Position):LengthSquared() <= size * size then
            table.insert(players, player)
        end
    end

    return players
end

function HolyFart.UpdateStats(player, fart)
    local pData = player:GetData()

    player.FireDelay = math.min(player.FireDelay, player.MaxFireDelay)
    player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY | CacheFlag.CACHE_DAMAGE)
    player:EvaluateItems()

    pData.Sewn_holyFart_timeLeft = pData.Sewn_holyFart_timeLeft - 1

    if pData.Sewn_holyFart_timeLeft >= 0 then
        Delay:DelayFunction(HolyFart.UpdateStats, nil, true, player, fart)
    else
        pData.Sewn_holyFart_timeLeft = nil
    end
end

function HolyFart:OnFartInit(fart)
    Globals.SFX:AdjustPitch(SoundEffect.SOUND_FART, 1.5)

    local players = GetPlayers(fart.Position)

    local eData = fart:GetData()
    eData.Sewn_holyFart_players = players

    for _, player in ipairs(players) do
        local pData = player:GetData()
        pData.Sewn_holyFart_timeLeft = HolyFart.Stats.BonusTime

        HolyFart.UpdateStats(player, fart)
    end
end

function HolyFart:OnNewRoom()
    for i = 1, Globals.Game:GetNumPlayers() do
        local player = Isaac.GetPlayer(i - 1)
        local pData = player:GetData()

        if pData.Sewn_holyFart_timeLeft ~= nil then
            player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY | CacheFlag.CACHE_DAMAGE)
            player:EvaluateItems()
        end
    end
end

function HolyFart:EvaluateCache(player, cacheFlag)
    local pData = player:GetData()

    if pData.Sewn_holyFart_timeLeft == nil then
        return
    end

    print(pData.Sewn_holyFart_timeLeft)

    if cacheFlag == CacheFlag.CACHE_FIREDELAY then
        player.MaxFireDelay = player.MaxFireDelay - player.MaxFireDelay * pData.Sewn_holyFart_timeLeft * (HolyFart.Stats.TearsBonusMaxPercentage / HolyFart.Stats.BonusTime)
    elseif cacheFlag == CacheFlag.CACHE_DAMAGE then
        player.Damage = player.Damage + player.Damage * pData.Sewn_holyFart_timeLeft * (HolyFart.Stats.DamageBonusMaxPercentage / HolyFart.Stats.BonusTime)
    end
end

Fart:RegisterFart(HolyFart)

return HolyFart