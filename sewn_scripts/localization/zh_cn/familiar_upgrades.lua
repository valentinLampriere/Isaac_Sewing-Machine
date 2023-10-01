--- Translation by 汐何 / Saurtya

--- -- Name of the familiar in english, do not change it!
--- {
---     "First upgrade description",
---     "Second upgrade description",
---     "Name of the familiar" (optional)
--- }

local Icons = require("sewn_scripts.localization.localization_helpers")

local familiarsUpgrades = {
    -- Brother Bobby
    {
        "{{ArrowUp}} 射速提升",
        "{{ArrowUp}} 射速提升#{{ArrowUp}} 攻击提升"
    },
    
    -- Sister Maggy
    {
        "{{ArrowUp}} 攻击提升",
        "{{ArrowUp}} 攻击提升#{{ArrowUp}} 射速提升"
    },
    
    -- Dead Cat
    {
        "角色复活时额外生成一个魂心",
        "角色复活时额外生成一个魂心的同时额外获得一个心之容器"
    },
    
    -- Little Chubby
    {
        "冷却时间减少 50% ，可以被更快扔出",
        "接触到敌人时将会附着在敌人身上持续造成伤害0.5秒，然后继续向前行进"
    },
    
    -- Robo Baby
    {
        "{{ArrowUp}} 射速提升",
        "{{ArrowUp}} 射速提升"
    },
    
    -- Little Gish
    {
        "眼泪在击中时将会额外生成一滩减速液体 #{{ArrowUp}} 射速略微提升",
        "生成更大范围的减速液体 #{{ArrowUp}} 射速提升#{{ArrowUp}} 攻击提升"
    },
    
    -- Little Steven
    {
        "眼泪在击中敌人或杀死敌人时有几率生成Boss史蒂夫死亡时爆开的特殊环状眼泪弹幕 #杀死敌人生成的弹幕攻击会更强 #{{ArrowUp}} 射程增加#{{ArrowDown}} 弹速降低#{{ArrowUp}} 攻击提升",
        "提升生成特殊弹幕的几率/特殊弹幕击中或杀死敌人也可以继续触发特殊弹幕，产生连锁反应#{{ArrowUp}} 攻击提升"
    },
    
    -- Demon Baby
    {
        "眼泪变为幽灵眼泪",
        "{{ArrowUp}} 射程增加#{{ArrowUp}} 射速提升"
    },
    
    -- Bomb Bag
    {
        "不再生成即爆炸弹 #产生更好的炸弹掉落 #角色走过的地方将会掉落火药粉末，着火的敌人与炸弹均可引燃",
        "更加好的炸弹掉落 #可掉落Giga炸弹（矿层可毁灭地形的大炸弹）[Rep]#敌人接近时有概率爆炸"
    },
    
    -- The Peeper
    {
        "每隔一段时间向不同的方向发射 5 颗眼泪 #在接近敌人时有短距离的跟踪效果",
        "额外生成一个 ".. Icons.Peeper .." 窥眼 #新的窥眼同样具有超级形态的效果 #如果持有 ".. Icons.InnerEye .." 内眼，则再额外生成一个窥眼"
    },
    
    -- Ghost Baby
    {
        "眼泪可穿透敌人#{{ArrowUp}} 攻击提升",
        "眼泪大小更大 #{{ArrowUp}} 攻击提升"
    },
    
    -- Harlequin Baby
    {
        "向两边额外发射一颗眼泪",
        "{{ArrowUp}} 攻击提升"
    },
    
    -- Daddy Longlegs
    {
        "有概率掉落的是蜘蛛的头，造成原先伤害的 2 倍；头和脚有概率替换成Boss-Triachnid的样子，如果替换则向周围发射 5 颗减速眼泪",
        "提升Boss-Triachnid出现的概率，下落一次后有概率再触发一次下落，额外触发的一次下落也可继续触发"
    },
    
    -- Sacrificial Dagger
    {
        "额外造成流血效果 #{{ArrowUp}} 攻击小幅提升",
        "{{ArrowUp}} 攻击提升"
    },
    
    -- Rainbow Baby
    {
        "{{ArrowUp}} 攻击提升#{{ArrowUp}} 射速提升",
        "原本随机的眼泪效果全部都会触发"
    },
    
    -- Guppy's Hairball
    {
        "每层初始时直接提升到第二形态的大小，击杀或阻挡弹幕时有概率生成蓝苍蝇",
        "每层初始时直接提升到第三形态的大小，击杀或阻挡弹幕时有概率生成更多蓝苍蝇"
    },
    
    -- Dry Baby
    {
        "{{ArrowUp}} 更容易触发死灵之书效果 #触发效果时清除所有敌方子弹",
        "更加容易触发死灵书效果 #触发效果时将所有敌方子弹转换为可阻挡弹幕的漂浮骨头"
    },
    
    -- Juicy Sack
    {
        "可发射蜘蛛卵眼泪 #击中敌人时生成蓝苍蝇或蓝蜘蛛 #产生更大的减速水迹",
        "发射更多蜘蛛卵眼泪"
    },
    
    -- Rotten Baby
    {
        "每次额外生成一只蓝苍蝇",
        "生成一个随机蝗虫 #若生成征服蝗虫则生成两只"
    },
    
    -- Headless Baby
    {
        "产生范围更大的血迹 #{{ArrowUp}} 血迹伤害提升",
        "额外发射向上的爆裂眼泪 #{{ArrowUp}} 血迹伤害大幅提升"
    },
    
    -- Leech
    {
        "攻击敌人时额外生成血迹 #{{ArrowUp}} 攻击提升",
        "敌人被杀死时爆出眼泪#{{ArrowUp}} 攻击提升"
    },
    
    -- Lil Brimstone
    {
        "{{ArrowUp}} 攻击提升",
        "{{ArrowUp}} 攻击大幅提升 #硫磺火持续更长时间 #蓄力更快"
    },
    
    -- Isaac's Heart
    {
        "角色在不攻击的时候，心脏与角色距离更近 #蓄力时间变短",
        "当蓄力满时，若有敌人或者弹幕距离心脏很近，心脏将自动释放充能弹开敌人与弹幕（该能力有cd）#蓄力时间大幅变短"
    },
    
    -- Sissy Longlegs
    {
        "所生成的蓝蜘蛛额外具有魅惑效果 #生成的蓝蜘蛛接触敌人时具有范围伤害",
        "生成更多的蓝蜘蛛 #生成的蓝蜘蛛接触敌人时的范围伤害提升"
    },
    
    -- Punching Bag
    {
        "像敌人一样具有精英形态，每隔一段时间随机改变颜色，可阻挡弹幕 {{Blank}}粉色：向随机方向发射眼泪 {{Blank}}紫色：将敌人和弹幕牵引到自身 {{Blank}}淡蓝色：玩家受伤时发射 8 向弹幕 {{Blank}}蓝色：玩家受伤时生成 2-3 只蓝蜘蛛 {{Blank}}橙色：玩家受伤时掉落一枚硬币 #可阻挡弹幕",
        "具有更多的精英形态： {{Blank}}绿色：移动路径生成绿色水迹造成伤害 {{Blank}}黑色：玩家受伤时爆炸，造成40点伤害 {{Blank}}彩虹色：具有以上所有形态的能力，但持续时间比上述形态都短 #可造成接触伤害"
    },
    
    -- Cain's Other Eye
    {
        --"发射 2 颗眼泪而非 1 颗 # 眼泪具有 ".. Icons.RubberCement .." 橡胶胶水特效",
        --"发射 4 颗眼泪 #射程增加"
    },
    
    -- Incubus
    {
        "{{ArrowUp}} 攻击提升 #[REP] : 现在造成与玩家相同的伤害",
        "{{ArrowUp}} 攻击大幅提升"
    },
    
    -- Lil Gurdy
    {
        "{{ArrowUp}} 充能更快 #在充能时可向四周方向发射环状眼泪",
        "{{ArrowUp}} 充能更快 #在冲撞时在地上留下血迹造成伤害，在冲撞结束后发射 3 次环状眼泪"
    },
    
    -- Seraphim
    {
        "概率发射圣光眼泪",
        "更高概率发射圣光眼泪 #{{ArrowUp}} 射速提升"
    },
    
    -- Spider Mod
    {
        "行走时有几率生成一个蜘蛛卵，敌人经过蜘蛛卵时随机获得debuff #蜘蛛卵持续20秒",
        "有更高的概率生成蜘蛛卵 #清理房间后，蜘蛛卵将会生成蓝蜘蛛"
    },
    
    -- Farting Baby
    {
        "{{ArrowUp}} 增加被攻击时放屁的几率 #每隔几秒就放一次屁。其越接近敌人，就越大几率放屁",
        "{{ArrowUp}} 增加放屁的几率 #额外获得两个类型的屁(燃烧屁和圣光屁)"
    },
    
    -- Papa Fly
    {
        "可以阻挡弹幕 #阻挡弹幕时有几率生成一个 {{Collectible504}} 棕色粪块生成的棕色金块跟班（苍蝇炮塔）",
        "一次发射5颗眼泪 #{{ArrowUp}} 射程增加 #更高的概率生成一个 {{Collectible504}} 棕色粪块生成的棕色金块跟班（苍蝇炮塔）"
    },
    
    -- Lil Loki
    {
        "发射 8 向眼泪",
        "{{ArrowUp}} 攻击提升"
    },
    
    -- Hushy
    {
        {
            "每 4 秒在一个随机的圆形图案中发射 15 次眼泪 #眼泪造成 3 点伤害",
            "蓄力几秒钟后生成迷你以撒(仅限有敌人的房间) #{{ArrowUp}} 攻击提升"
        },
        {
            "每 4 秒在一个随机的圆形图案中发射 15 次眼泪 #眼泪造成 3 点伤害",
            "蓄力几秒钟后生成迷你以撒(仅限有敌人的房间) #{{ArrowUp}} 攻击提升"
        }
    },
    
    -- Lil Monstro
    {
        "每颗发射的眼泪有概率替换成牙齿 #牙齿造成 x3.2 伤害",
        "发射更多眼泪"
    },
    
    -- Big Chubby
    {
        "通过阻挡敌方弹幕和杀敌来增加它的大小和伤害 #随着时间流逝或到达新的一层时，会失去其获得的加成",
        "在对敌人造成伤害时会更加增加它的大小 #到达新的一层时不再失去其获得的伤害加成 #{{ArrowUp}} 减少冷却时间"
    },
    
    -- Mom's Razor
    {
        "{{ArrowUp}} 延长流血效果的持续时间，Boss不受此影响",
        "当敌人以流血状态死亡时，会生成一滩血迹 # 有概率生成 {{HalfHeart}} 半颗红心 #{{ArrowUp}} 延长流血效果的持续时间"
    },
    
    -- Bloodshot Eye
    {
        "一次发射三颗眼泪",
        "攻击方式更改为发射小硫磺火"
    },
    
    -- Buddy in a Box
    {
        "额外获得一个盲盒宝宝的眼泪效果 ",
        "额外再获得一个盲盒宝宝的眼泪效果"
    },
    
    -- Angelic Prism
    {
        "当天使棱镜将要经过角色眼泪发射的方向时，将主动靠近到角色身前 #眼泪获得穿透效果",
        "将会靠的更近 #眼泪将同时获得跟踪效果"
    },
    
    -- Lil Spewer
    {
        "将会额外发射眼泪，根据宝宝当前的形态眼泪效果也不同 {{Blank}}普通：发射三颗 5 伤害的眼泪 {{Blank}}黑色与白色：发射三颗 3.5 伤害的减速眼泪 {{Blank}}黄色：发射三颗同方向的眼泪 {{Blank}}红色：发射一颗 12.5 伤害的巨型血泪",
        "跟班同时可以拥有两种形态"
    },
    
    -- Pointy Rib
    {
        "概率对非boss敌人造成流血效果 #杀死敌人时有概率生成骨头",
        "造成流血效果和生成骨头的概率提高 #接触伤害提升"
    },
    
    -- Paschal Candle
    {
        "角色受到伤害时，蜡烛会向四周抛出大量火焰 #抛出的火焰大小取决于蜡烛大小",
        "现在角色受到伤害时蜡烛并不会直接熄灭，而是减少一级"
    },
    
    -- Blood Oath
    {
        "角色额外生成血迹，生成血迹的概率与伤害跟血誓抽掉的 {{Heart}} 红心成正比",
        "每层初始房间血誓对角色造成伤害时将额外掉落 {{Heart}} 红心"
    },
    
    -- Psy Fly
    {
        "阻挡弹幕后向弹幕发射的反方向发射一颗跟踪眼泪",
        "{{ArrowUp}} 攻击提升，并具有接触伤害"
    },
    
    -- Boiled Baby
    {
        "发射更多的眼泪",
        "发射方向更改为角色攻击的方向"
    },
    
    -- Freezer Baby
    {
        "{{ArrowUp}} 攻击提升 #{{ArrowUp}} 射程增加 #冰冻敌人的几率上升",
        "击杀敌人时敌人额外爆出冰冻眼泪 #{{ArrowUp}} 攻击提升"
    },
    
    -- Lil Dumpy
    {
        "进入每个房间后，都有几率变为另一个屁宝变体：" ..
        "#".. Icons.LilDumpy.DUMPLING .." 基础的放屁效果"..
        "#".. Icons.LilDumpy.SKINLING .." 放屁时，会使敌人中毒"..
        "#".. Icons.LilDumpy.SCABLING .." 放屁时，会以圆形的方式发射出 6 道眼泪"..
        "#".. Icons.LilDumpy.SCORCHLING .." 放屁时，产生一个造成15点伤害的火焰"..
        "#".. Icons.LilDumpy.FROSTLING .." 其杀死的敌人会变成被冻结，休息时获得冰冻光环"..
        "#".. Icons.LilDumpy.DROPLING .." 放屁时，会朝相反的方向发射火焰眼泪，造成 3 点伤害",
        "在随机的几秒钟后会回到玩家身边，即使与玩家距离很远"
    },
    
    -- Bot Fly
    {
        "发射眼泪时，眼泪与跟班之间将会有一道激光连接 #激光可对敌人造成伤害并且可以阻挡弹幕 #{{ArrowUp}} 属性上升(射程，弹速，眼泪大小)",
        "{{ArrowUp}} 属性上升 # 眼泪获得穿透效果 #有概率主动攻击敌人"
    },
    
    -- Fruity Plum
    {
        "{{ArrowUp}} 攻击提升 #微弱的跟踪效果",
        "获得 ".. Icons.PlaydoughCookie .." 黏土饼干的效果 #在攻击完成后向所有方向发射眼泪"
    },
    
    -- Cube Baby
    {
        "具有一圈冰冻光环，敌人在其中停留一定时间将会直接冰冻",
        "在移动路径上留下一道可造成伤害的水迹 #移动越快，留下的水迹越多"
    },
    
    -- Lil Abaddon
    {
        "{{ArrowUp}} 攻击提升#当亚巴顿宝宝在蓄力条满的时候，有概率在其当前的位置留下一个黑色漩涡，释放蓄力条时黑色漩涡也会释放黑圈（上限四个）",
        "黑色漩涡出现的概率提升 #黑色漩涡里产生的黑圈造成更高伤害，范围更大且持续时间也更长 #黑圈造成伤害时有概率生成 {{BlackHeart}} 黑心"
    },
    
    -- Vanishing Twin
    {
        "复制生成的Boss血量减少25%",
        "击杀额外boss后将会生成等级更高的道具 #从 {{TreasureRoom}} 道具房与 {{BossRoom}} Boss房道具池中生成"
    },
    
    -- Twisted Pair
    {
        "与角色之间的距离靠的更近 #+0.33攻击",
        "眼泪弹道将和玩家射击的方向一致"
    },
    
    -- BBF
    {
        "",
        ""
    },
    
    -- King Baby
    {
        "Summon tears while Isaac is firing",
        "{{ArrowUp}}Tears Up#Each familiars improve in their own way the summoned tear"
    },
    
    -- Worm Friend
    {
        "While it grabs an enemy, it attract close bullets. Each bullet deals 1 dmg to the target#{{ArrowUp}} Greatly decrease cooldown",
        "{{ArrowUp}} Damage dealt to the Worm Friend's target are increased.#Damages from any sources are affected (Isaac, Worm Friend, familiars etc.)"
    },
    
    -- Angry Fly
    {
        "While in hostile rooms, it become enraged when it doesn't deal damage to enemies#{{ArrowUp}} The more it is enraged, the more damage it deals#Dealing damage slowly dissipate the rage",
        "{{ArrowUp}} Rage up"
    }
}

return familiarsUpgrades