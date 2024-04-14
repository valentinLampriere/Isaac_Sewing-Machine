--- Translation by 汐何 / Saurtya

--- -- Name of the trinket in english, do not change it!
--- {
---     "Trinket Name",
---     "Description of the trinket",
--- }

local trinkets = {
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
    
    -- Sewing Case
    {
        "缝纫工具袋",
        "携带此饰品时，进入一个新房间内将基于{{Luck}}幸运值与跟班数量有概率升级一个跟班",
    },
}

return trinkets