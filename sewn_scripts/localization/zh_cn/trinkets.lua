--- Translation by 汐何 / Saurtya

--- -- Name of the trinket in english, do not change it!
--- {
---     "Trinket Name",
---     "Description of the trinket",
--- }

local trinkets = {
    -- Thimble
    {
        "顶针",
        "携带后使用缝纫机将会额外产生掉落物 #掉落物的类型取决于缝纫机的类型",
    },

    -- Cracked Thimble
    {
        "破损的顶针",
        "每次受到伤害时有 75% 概率重roll跟班的皇冠，但皇冠总数不变",
    },

    -- Lost Button
    {
        "丢失的纽扣",
        "携带后商店里生成缝纫机的概率变为100%（替代原先的25%）# {{DevilRoom}} 恶魔房与 {{AngelRoom}} 天使房生成对应的缝纫机概率变为50%",
    },

    -- Pin Cushion
    {
        "针垫",
        "携带此饰品时，将跟班放置在缝纫机上后再次触碰缝纫机将会取下跟班 #意味着拥有此饰品时将无法使用缝纫机，但可以反复尝试取下跟班再放置上去来选择想要升级的跟班#{{Warning}} 该饰品被吞下或熔炉融解后，饰品效果消失，取而代之的是缝纫机受爆炸后损坏的概率降低",
    },
    
    -- Sewing Case
    {
        "缝纫工具袋",
        "携带此饰品时，进入一个新房间内将基于{{Luck}}幸运值与跟班数量有概率升级一个跟班",
    },
}

return trinkets