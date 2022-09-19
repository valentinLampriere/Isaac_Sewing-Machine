--- Translation by Ferpe and Goncholito

--- -- Name of the card in english, do not change it!
--- {
---     "Card Name",
---     "Description of the card effect",
--- }

local Icons = require("sewn_scripts.localization.localization_helpers")

local cards = {
    -- Warranty Card
    {
        "保修卡",
        "生成一台缝纫机 #根据房间种类的不同生成的缝纫机也不同"
    },
    
    -- Stitching Card
    {
        "粘贴卡",
        "随机分配目前跟班的皇冠，与分配前的总数不变 #若目前拥有的跟班没有皇冠，则随机对一名跟班升级一次"
    },
    
    -- Sewing Coupon
    {
        "缝纫体验券",
        "当前房间内所有拥有的可升级跟班获得一次暂时性升级，离开房间后失去效果"
    },
}

return cards