if not EID then
    return
end

local Enums = require("sewn_scripts.core.enums")

-- EID Collectibles
EID:addCollectible(Enums.CollectibleType.COLLECTIBLE_SEWING_BOX, "Temporarily upgrades familiars for a room#Using it twice upgrades familiars to Ultra")
EID:addCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD, "Upgrade every normal familiars to super#With Doll's Pure Body, upgrade every familiars to ultra#Add 20% chance to find a Sewing Machine in Devil rooms")
EID:addCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY, "Upgrade every normal familiars to super#With Doll's Tainted Head, upgrade every familiars to ultra#Add 20% chance to find a Sewing Machine in Angel rooms")

-- EID Trinkets
EID:addTrinket(Enums.TrinketType.TRINKET_THIMBLE, "Refunds familiars upgrade when using the Sewing Machine#Spawn pickups on the floor, pickups depends on the Sewing Machine type")
EID:addTrinket(Enums.TrinketType.TRINKET_CRACKED_THIMBLE, "Have 75% chance to reroll familiars crowns when getting hit")
EID:addTrinket(Enums.TrinketType.TRINKET_LOST_BUTTON, "100% chance to spawn sewing machine in Shops#50% chance to find a sewing machine in angel rooms {{AngelRoom}} or devil rooms {{DevilRoom}}")
--EID:addTrinket(Enums.TrinketType.TRINKET_CONTRASTED_BUTTON, "50% chance to find a sewing machine in angel rooms {{AngelRoom}} or devil rooms {{DevilRoom}}")
EID:addTrinket(Enums.TrinketType.TRINKET_PIN_CUSHION, "Interacting with a Sewing Machine gives the familiar back without upgrading.#This allows you to choose the familiar you want to upgrade by dropping the trinket with the drop button when the correct one is in the machine#{{Warning}} When smelted this effect is removed, but you have a decreased chance to break sewing machines")
EID:addTrinket(Enums.TrinketType.TRINKET_SEWING_CASE, "When entering a room, has a chance to temporarily upgrade a familiar based on the amount of available familiars and luck")

-- EID Cards
EID:addCard(Enums.Card.CARD_WARRANTY, "Spawns a sewing machine#The Sewing machine change depending on the room type")
EID:addCard(Enums.Card.CARD_STITCHING, "Rerolls familiar crowns#Gives a free upgrades if none of your familiars are upgraded")
EID:addCard(Enums.Card.CARD_SEWING_COUPON, "Upgrade all familiars for a single room#One time use of Sewing Box")

--------Chinese EID by 汐何/Saurtya
-- EID Collectibles
EID:addCollectible(Enums.CollectibleType.COLLECTIBLE_SEWING_BOX, "使用后在当前房间对【可升级跟班】升级一次#使用两次则可以升级到究极形态（蓝皇冠）", "便携缝纫包","zh_cn")
EID:addCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD, "拥有时可让所有拥有的可升级的跟班升级到超级形态（黄皇冠）#如果拥有 {{Collectible".. Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY .."}} \"受祝福的娃娃身体\"，则可让所有拥有的可升级的跟班升级到究极形态（蓝皇冠）# {{ArrowUp}} 恶魔房生成恶魔缝纫机的概率 +20%", "受诅咒的娃娃头","zh_cn")
EID:addCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY, "拥有时可让所有拥有的可升级的跟班升级到超级形态（黄皇冠）#如果拥有 {{Collectible".. Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD .."}} \"受诅咒的娃娃头\"，则可让所有拥有的可升级的跟班升级到究极形态（蓝皇冠）# {{ArrowUp}} 天使房生成天使缝纫机的概率 +20%", "受祝福的娃娃身体","zh_cn")

-- EID Trinkets
EID:addTrinket(Enums.TrinketType.TRINKET_THIMBLE, "携带后使用缝纫机将会额外产生掉落物 #掉落物的类型取决于缝纫机的类型", "顶针","zh_cn")
EID:addTrinket(Enums.TrinketType.TRINKET_CRACKED_THIMBLE, "每次受到伤害时有 75% 概率重roll跟班的皇冠，但皇冠总数不变", "破损的顶针","zh_cn")
EID:addTrinket(Enums.TrinketType.TRINKET_LOST_BUTTON, "携带后商店里生成缝纫机的概率变为100%（替代原先的25%）# {{DevilRoom}} 恶魔房与 {{AngelRoom}} 天使房生成对应的缝纫机概率变为50%", "丢失的纽扣","zh_cn")
--EID:addTrinket(Enums.TrinketType.TRINKET_CONTRASTED_BUTTON, " {{DevilRoom}} 恶魔房与 {{AngelRoom}} 天使房生成对应的缝纫机概率变为50%", "排扣","zh_cn")
EID:addTrinket(Enums.TrinketType.TRINKET_PIN_CUSHION, "携带此饰品时，将跟班放置在缝纫机上后再次触碰缝纫机将会取下跟班 #意味着拥有此饰品时将无法使用缝纫机，但可以反复尝试取下跟班再放置上去来选择想要升级的跟班#{{Warning}} 该饰品被吞下或熔炉融解后，饰品效果消失，取而代之的是缝纫机受爆炸后损坏的概率降低", "针垫","zh_cn")
EID:addTrinket(Enums.TrinketType.TRINKET_SEWING_CASE, "携带此饰品时，进入一个新房间内将基于{{Luck}}幸运值与跟班数量有概率升级一个跟班", "缝纫工具袋","zh_cn")

-- EID Cards
EID:addCard(Enums.Card.CARD_WARRANTY, "生成一台缝纫机 #根据房间种类的不同生成的缝纫机也不同", "保修卡","zh_cn")
EID:addCard(Enums.Card.CARD_STITCHING, "随机分配目前跟班的皇冠，与分配前的总数不变 #若目前拥有的跟班没有皇冠，则随机对一名跟班升级一次", "粘贴卡","zh_cn")
EID:addCard(Enums.Card.CARD_SEWING_COUPON, "当前房间内所有拥有的可升级跟班获得一次暂时性升级，离开房间后失去效果", "缝纫体验券","zh_cn")


local icon = Sprite()
icon:Load("/gfx/mapicon.anm2", true)
EID:addIcon("SewingMachine", "Icon", 0, 13, 13, 0, 0, icon)
EID:setModIndicatorIcon("SewingMachine")
EID:setModIndicatorName("Sewing Machine")