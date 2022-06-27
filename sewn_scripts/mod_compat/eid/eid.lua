if not EID then
    return
end

local Enums = require("sewn_scripts.core.enums")


local sewingMachineIcon = Sprite()
sewingMachineIcon:Load("gfx/mapicon.anm2", true)
EID:addIcon("SewingMachine", "Icon", 0, 13, 13, 0, 0, sewingMachineIcon)

local crownSprite = Sprite()
crownSprite:Load("gfx/sewn_familiar_crown.anm2", true)
EID:addIcon("SuperCrown", "Super", 0, 13, 10, 3, 10, crownSprite)
EID:addIcon("UltraCrown", "Ultra", 0, 13, 10, 3, 10, crownSprite)

EID:setModIndicatorIcon("SewingMachine")
EID:setModIndicatorName("Sewing Machine")

-- EID Collectibles
EID:addCollectible(Enums.CollectibleType.COLLECTIBLE_SEWING_BOX, "Temporarily upgrades familiars for a room#Using it twice upgrades familiars to Ultra {{UltraCrown}}")
EID:addCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD, "Upgrade every normal familiars to Super {{SuperCrown}}#With Doll's Pure Body {{Collectible".. Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY .."}}, upgrade every familiars to Ultra {{UltraCrown}}#Add 20% chance to find a Sewing Machine in Devil rooms")
EID:addCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY, "Upgrade every normal familiars to Super {{SuperCrown}}#With Doll's Tainted Head {{Collectible".. Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD .."}}, upgrade every familiars to Ultra {{UltraCrown}}#Add 20% chance to find a Sewing Machine in Angel rooms")

-- EID Trinkets
EID:addTrinket(Enums.TrinketType.TRINKET_THIMBLE, "Spawns pickups based on the type of sewing machine used when upgrading")
EID:addTrinket(Enums.TrinketType.TRINKET_CRACKED_THIMBLE, "Have 75% chance to reroll familiars crowns when getting hit")
EID:addTrinket(Enums.TrinketType.TRINKET_LOST_BUTTON, "100% chance to spawn sewing machine in Shops#50% chance to find a sewing machine in angel rooms {{AngelRoom}} or devil rooms {{DevilRoom}}")
--EID:addTrinket(Enums.TrinketType.TRINKET_CONTRASTED_BUTTON, "50% chance to find a sewing machine in angel rooms {{AngelRoom}} or devil rooms {{DevilRoom}}")
EID:addTrinket(Enums.TrinketType.TRINKET_PIN_CUSHION, "Interacting with a Sewing Machine gives the familiar back without upgrading.#This allows you to choose the familiar you want to upgrade by dropping the trinket with the drop button when the correct one is in the machine#{{Warning}} When smelted this effect is removed, but you have a decreased chance to break sewing machines")
EID:addTrinket(Enums.TrinketType.TRINKET_SEWING_CASE, "When entering a room, has a chance to temporarily upgrade a familiar based on the amount of available familiars and luck")

-- EID Cards
EID:addCard(Enums.Card.CARD_WARRANTY, "Spawns a sewing machine#The Sewing machine change depending on the room type")
EID:addCard(Enums.Card.CARD_STITCHING, "Rerolls familiar crowns#Gives a free upgrades if none of your familiars are upgraded")
EID:addCard(Enums.Card.CARD_SEWING_COUPON, "Upgrade all familiars for a single room#One time use of Sewing Box {{Collectible".. Enums.CollectibleType.COLLECTIBLE_SEWING_BOX .."}}")




-------- French EID
-- EID Collectibles
EID:addCollectible(Enums.CollectibleType.COLLECTIBLE_SEWING_BOX, "Améliore tous les familiers pour la durée d'une salle#Utiliser l'objet deux fois dans la même salle améliore les familiers en Ultra {{UltraCrown}}", "Boîte de couture", "fr")
EID:addCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD, "Améliore tous les familiers \"Normal\" en Super {{SuperCrown}}#Si Isaac a le Corps Pur de Poupée {{Collectible".. Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY .."}} améliore tous les familiers en Ultra {{UltraCrown}}#20% de chance de trouver une Machine à Coudre dans les Devil Rooms", "Tête Impure de Poupée", "fr")
EID:addCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY, "Améliore tous les familiers \"Normal\" en Super {{SuperCrown}}#Si Isaac a la Tête Impure de Poupée {{Collectible".. Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD .."}} améliore tous les familiers en Ultra {{UltraCrown}}#20% de chance de trouver une Machine à Coudre dans les Angel Rooms", "Corps Pur de Poupée", "fr")

-- EID Trinkets
EID:addTrinket(Enums.TrinketType.TRINKET_THIMBLE, "Utiliser une Machine à Coudre {{SewingMachine}} fait apparaître des ressources#Les ressources dépendent du type de Machine à Coudre", "Dé à Coudre", "fr")
EID:addTrinket(Enums.TrinketType.TRINKET_CRACKED_THIMBLE, "Subir un dégât a 75% de chances changer les couronnes des familiers", "Dé à Coudre Cassé", "fr")
EID:addTrinket(Enums.TrinketType.TRINKET_LOST_BUTTON, "100% de chances de trouver une Machine à Coudre {{SewingMachine}} dans le Shop#50% de chances de trouver une Machine à Coudre dans les Angel Rooms {{AngelRoom}} et Devil Rooms {{DevilRoom}}", "Le Bouton Perdu", "fr")
EID:addTrinket(Enums.TrinketType.TRINKET_PIN_CUSHION, "Intéragir avec une Machine à Coudre {{SewingMachine}} rend à Isaac son familier sans améliorations, mais gratuitement#Permet de choisir le familier à améliorer en déposant le trinket une fois le familier souhaité dans la machine#{{Warning}} Absorber le trinket supprime cet effet, mais les Machines à Coudre ont moins de chance de se casser", "Coussin à Épingles", "fr")
EID:addTrinket(Enums.TrinketType.TRINKET_SEWING_CASE, "Entrer dans une salle a une chance d'améliorer temporairement un familier", "Malette de Couture", "fr")

-- EID Cards
EID:addCard(Enums.Card.CARD_WARRANTY, "Fait apparaître une Machine à Coudre#Le type de Machine à Coudre dépend du type de la salle", "Carte de Garantie", "fr")
EID:addCard(Enums.Card.CARD_STITCHING, "Change les couronnes (= les améliorations) des familiers#Si Isaac n'a aucun familier amélioré, améliore un familier aléatoire", "Carte de Couture", "fr")
EID:addCard(Enums.Card.CARD_SEWING_COUPON, "Améliore tous les familiers pour la durée de la salle#Équivaut à une utilisation de la Boîte de Couture {{Collectible".. Enums.CollectibleType.COLLECTIBLE_SEWING_BOX .."}}", "Coupon de Couture", "fr")





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






--------Russian EID by Warhamm2000
-- EID Collectibles
EID:addCollectible(Enums.CollectibleType.COLLECTIBLE_SEWING_BOX, "Улучшает фамильяров до конца комнаты#Использовав дважды, они улучшатся до ультра", "Шкатулка для Шитья", "ru")
EID:addCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD, "Улучшает каждого обычного фамильяра до супер#С Чистым Телом Куклы улучшает каждого фамильара до ультра#Даёт 20% шанс найти машинку для шитья в Комнате Дьявола", "Порченая Голова Куклы", "ru")
EID:addCollectible(Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY, "Улучшает каждого обычного фамильяра до супер#C Порченой Головой Куклы улучшает каждого фамильяра до ультра#Даёт 20% шанс найти машинку для шитья в Комнате Ангела", "Чистое Тело Куклы", "ru")

-- EID Trinkets
EID:addTrinket(Enums.TrinketType.TRINKET_THIMBLE, "Возвращает улучшения с фамильяров при использовании машинки для шитья#После использования спавнит пикапы на полу, в зависимости от типа машинки", "Напёрсток", "ru")
EID:addTrinket(Enums.TrinketType.TRINKET_CRACKED_THIMBLE, "Имеет шанс 75% зареролить короны фамильяров при получении урона", "Треснувший Напёрсток", "ru")
EID:addTrinket(Enums.TrinketType.TRINKET_LOST_BUTTON, "Машинки для шитья имеют 100% появиться в магазинах#Также даёт 50% шанс появиться в комнате ангела {{AngelRoom}} или дьявола {{DevilRoom}}", "Потерянная Пуговица", "ru")
--EID:addTrinket(Enums.TrinketType.TRINKET_CONTRASTED_BUTTON, "Даёт 50% шанс появиться в комнате ангела {{AngelRoom}} или дьявола {{DevilRoom}}", "Контрастирующая Пуговица", "ru")
EID:addTrinket(Enums.TrinketType.TRINKET_PIN_CUSHION, "Взаимодействуя с машинкой фамильяр возвращается без улучшения.#Позволяет выбрать того фамильяра для улучшения которого сами хотите, выбрасывая брелок, когда нужный фамильяр в машинке#{{Warning}} Когда этот брелок приварен его свойство удаляется, однако понижается шанс уничтожить машинку для шитья", "Подушечка для Булавок", "ru")
EID:addTrinket(Enums.TrinketType.TRINKET_SEWING_CASE, "При входе в комнату даёт шанс улучшить случайного фамильяра в зависимости от их количества и вышей удачи", "Инструментарий для Шитья", "ru")

-- EID Cards
EID:addCard(Enums.Card.CARD_WARRANTY, "Спавнит машинку для шитья#Тип машинки зависит комнаты в которой она была заспавнена", "Карта Гарантии", "ru")
EID:addCard(Enums.Card.CARD_STITCHING, "Реролит короны фамильяров#Даёт бесплатные улучшения, если ни однин фамильяр их не имеет", "Карта Сшития", "ru")
EID:addCard(Enums.Card.CARD_SEWING_COUPON, "Улучшает фамильяров до конца комнаты#Одноразовая Шкатулка для Шитья", "Купон для Шитья", "ru")