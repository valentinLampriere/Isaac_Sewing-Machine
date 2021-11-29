local Player = require("sewn_scripts.entities.player.player")
local DollTaintedHead = require("sewn_scripts.items.passive.doll_tainted_head")
local DollPureBody = require("sewn_scripts.items.passive.doll_pure_body")

local GetLoseCollectible = { }

function GetLoseCollectible:LilDelirium(player, getCollectible)
    if getCollectible == true then
        Player:GetLilDelirium(player)
    end
end
function GetLoseCollectible:DollsTaintedHead(player, getCollectible)
    if getCollectible == true then
        DollTaintedHead:GetCollectible(player)
    else
        DollTaintedHead:LoseCollectible(player)
    end
end
function GetLoseCollectible:DollsPureBody(player, getCollectible)
    if getCollectible == true then
        DollPureBody:GetCollectible(player)
    else
        DollPureBody:LoseCollectible(player)
    end
end

return GetLoseCollectible
