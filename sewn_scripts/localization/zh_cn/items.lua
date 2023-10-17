--- Translation by 汐何 / Saurtya

--- -- Name of the item in english, do not change it!
--- {
---     "Item Name",
---     "Description of the item",
--- }

local Icons = require("sewn_scripts.localization.localization_helpers")

local items = {
    -- Sewing Box
    {
        "便携缝纫包",
        "使用后在当前房间对【可升级跟班】升级一次#使用两次则可以升级到究极形态（蓝皇冠）"
    },
    
    -- Doll's Tainted Head
    {
        "受诅咒的娃娃头",
        "拥有时可让所有拥有的可升级的跟班升级到超级形态（黄皇冠）#如果拥有 ".. Icons.PureBody .." \"受祝福的娃娃身体\"，则可让所有拥有的可升级的跟班升级到究极形态（蓝皇冠）# {{ArrowUp}} 恶魔房生成恶魔缝纫机的概率 +20%"
    },
    
    -- Doll's Pure Body
    {
        "受祝福的娃娃身体",
        "拥有时可让所有拥有的可升级的跟班升级到超级形态（黄皇冠）#如果拥有 ".. Icons.TaintedHead .." \"受诅咒的娃娃头\"，则可让所有拥有的可升级的跟班升级到究极形态（蓝皇冠）# {{ArrowUp}} 天使房生成天使缝纫机的概率 +20%"
    },
}

return items