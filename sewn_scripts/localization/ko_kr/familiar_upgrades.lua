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
        "{{ArrowUp}} 연사 +",
        "{{ArrowUp}} 연사 ++#{{ArrowUp}} 공격력 +"
    },
    
    -- Sister Maggy
    {
        "{{ArrowUp}} 공격력 +",
        "{{ArrowUp}} 공격력 ++#{{ArrowUp}} 연사 +"
    },
    
    -- Dead Cat
    {
        "{{SoulHeart}} 부활 시 추가 소울하트 +1",
        "{{Heart}} 부활 시 추가 최대 체력 +1#{{SoulHeart}} 부활 시 추가 소울하트 +1"
    },
    
    -- Little Chubby
    {
        "{{ArrowUp}} 처비 쿨타임 50% 감소#{{Throwable}} 날아가는 속도 +",
        "적과 접촉 시 0.5초동안 적에게 달라붙습니다."
    },
    
    -- Robo Baby
    {
        "{{ArrowUp}} 연사 +",
        "{{ArrowUp}} 연사 ++"
    },
    
    -- Little Gish
    {
        "{{ArrowUp}} 연사 +#눈물이 무언가에 부딪힐 때 둔화 장판을 생성합니다.",
        "{{ArrowUp}} 공격력 +#{{ArrowUp}} 연사 ++#{{ArrowUp}} 장판 크기 +"
    },
    
    -- Little Steven
    {
        "{{ArrowUp}} 공격력 +#{{ArrowUp}} 사거리 +#{{ArrowDown}} 탄속 -#적 명중/처치 시 일정 확률로 8방향의 눈물을 발사합니다.",
        "{{ArrowUp}} 공격력 ++#{{ArrowUp}} 8방향 눈물 확률 +# 8방향 눈물 효과가 연쇄적으로 작용합니다."
    },
    
    -- Demon Baby
    {
        "공격이 적을 관통합니다.",
        "{{ArrowUp}} 사거리 +#{{ArrowUp}} 연사 +"
    },
    
    -- Bomb Bag
    {
        "{{ArrowUp}} 폭탄 등급 +#트롤 폭탄을 더 이상 소환하지 않습니다.#패밀리어 위치에 화약을 깔며 불 및 폭발 시 점화합니다.",
        "{{ArrowUp}} 폭탄 등급 ++#{{ArrowUp}} 기가폭탄을 드랍할 확률이 생깁니다. [Rep]#적이 가까이 있을 때 때때로 폭발합니다."
    },
    
    -- The Peeper
    {
        "주기적으로 랜덤 방향으로 5개의 눈물을 발사합니다#적에게 서서히 다가갑니다.",
        "".. Icons.Peeper .." 눈알 +1#".. Icons.InnerEye .." The Inner Eye 소지 시 추가 눈알 +1#모든 눈알이 업그레이드된 채로 등장합니다."
    },
    
    -- Ghost Baby
    {
        "{{ArrowUp}} 공격력 +#".. Icons.PupulaDuplex .." 공격이 지형을 관통합니다.",
        "{{ArrowUp}} 눈물 크기 +#{{ArrowUp}} 공격력 ++"
    },
    
    -- Harlequin Baby
    {
        "각 방향마다 눈물을 추가로 발사합니다.",
        "{{ArrowUp}} 공격력 +"
    },
    
    -- Daddy Longlegs
    {
        "확률적으로 발 대신 머리로 찍습니다. (피해량 x2)#확률적으로 찍을 때 둔화 눈물을 5방향으로 발사하는 Triachnid의 모습으로 찍습니다.",
        "{{ArrowUp}} Triachnid 모습 및 머리 모습 확률 +#확률적으로 2번 찍습니다."
    },
    
    -- Sacrificial Dagger
    {
        "{{ArrowUp}} 공격력 +#{{BleedingOut}} 접촉한 적을 출혈시킵니다.",
        "{{ArrowUp}} 공격력 ++"
    },
    
    -- Rainbow Baby
    {
        "{{ArrowUp}} 공격력 +#{{ArrowUp}} 연사 +",
        "2개 이상의 눈물 효과가 나갑니다."
    },
    
    -- Guppy's Hairball
    {
        "최소 2단계부터 시작#적 처치 및 탄환 방어 시 확률적으로 자폭 파리를 소환합니다.",
        "최소 3단계부터 시작#적 처치 및 탄환 방어 시 자폭 파리 수 +"
    },
    
    -- Dry Baby
    {
        "{{ArrowUp}} Necronomicon 효과 발동 확률 +#Necronomicon 효과 발동 시 적 탄환을 추가로 제거합니다.",
        "{{ArrowUp}} Necronomicon 효과 발동 확률 ++#Necronomicon 효과 발동 시 적 탄환을 뼛조각으로 바꿉니다."
    },
    
    -- Juicy Sack
    {
        "{{ArrowUp}} 장판 크기 +#"..Icons.Parasitoid.." 공격하는 방향으로 Parasitoid 눈물을 발사합니다.",
        "{{ArrowUp}} 눈물 발사 수 +"
    },
    
    -- Rotten Baby
    {
        "{{ArrowUp}} 자폭 파리 수 +",
        "기본 자폭 파리 대신 랜덤 자폭 파리를 소환합니다."
    },
    
    -- Headless Baby
    {
        "{{ArrowUp}} 장판 피해량 +#{{ArrowUp}} 장판 크기 +",
        "{{ArrowUp}} 장판 피해량 ++#주변에 눈물을 흩뿌립니다."
    },
    
    -- Leech
    {
        "{{ArrowUp}} 공격력 +#적에게 피해를 주는 장판을 생성합니다.",
        "{{ArrowUp}} 공격력 ++#적 처치 시 주변에 눈물을 흩뿌립니다."
    },

    -- BBF
    {
        "{{ArrowUp}} 폭발 피해량 +#{{Warning}} 폭발 반경 +",
        "매우 가까이 있지 않은 경우 캐릭터가 해당 폭발 피해를 받지 않습니다."
    },
    
    -- Lil Brimstone
    {
        "{{ArrowUp}} 공격력 +",
        "{{ArrowUp}} 공격력 ++#{{ArrowUp}} 혈사 지속시간 +#{{ArrowUp}} 충전 속도 +"
    },
    
    -- Isaac's Heart
    {
        "{{ArrowUp}} 충전 속도 +#공격 중이지 않을 때 캐릭터와 더 가까이 붙게 됩니다.",
        "{{ArrowUp}} 충전 속도 ++#완충 상태에서 자동으로 적과 탄환을 밀쳐냅니다.#!!! (짧은 시간동안 충전 불가)"
    },
    
    -- Sissy Longlegs
    {
        "{{ArrowUp}} 자폭 거미의 피해량 +3#자폭 거미가 적을 매혹시킵니다.",
        "{{ArrowUp}} 매혹 지속시간 +#{{ArrowUp}} 자폭 거미의 피해량 +5#자폭 거미를 추가로 소환합니다."
    },
    
    -- Punching Bag
    {
        "일정 시간마다 랜덤 색상의 챔피언 형태로 바뀝니다:#"..
        "{{ColorPink}}분홍{{CR}}: 랜덤 방향 눈물#"..
        "{{ColorPurple}}보라{{CR}}: 주변의 적 및 탄환을 빨아들임#"..
        "{{ColorCyan}}연한파랑{{CR}}: 캐릭터 피격 시 8방향 눈물#"..
        "{{ColorCyan}}파랑{{CR}}: 캐릭터 피격 시 자폭 파리 2~3마리#"..
        "{{ColorOrange}}오렌지{{CR}}: 캐릭터 피격 시 동전 소환#"..
        "공통:적의 탄환을 막아줍니다.",
        "아래의 챔피언 형태 추가:#"..
        "{{ColorGreen}}초록{{CR}}: 독 장판 생성#"..
        "{{ColorGray}}검정{{CR}}: 캐릭터 피격 시 주변의 적에게 40의 폭발 피해#"..
        "{{ColorRainbow}}레인보우{{CR}}: 모든 색상의 특성을 지니나, 지속 시간이 짧음#"..
        "공통:접촉한 적에게 피해를 줍니다."
    },
    
    -- Cain's Other Eye
    {
        "랜덤 대각선 방향으로 눈물을 추가로 발사",
        "" .. Icons.RubberCement.. " 추가 발사 눈물이 무언가에 반사#{{ArrowUp}} 공격력 +"
    },
    
    -- Incubus
    {
        "{{ArrowUp}} 공격력 +",
        "{{ArrowUp}} 공격력 ++"
    },
    
    -- Lil Gurdy
    {
        "{{ArrowUp}} 충전 속도 +#충전 중일 때 랜덤 방향으로 눈물 발사",
        "{{ArrowUp}} 충전 속도 ++#돌진 중 적에게 피해를 주는 장판 생성#돌진 이후 랜덤 방향으로 눈물 3회 발사"
    },
    
    -- Seraphim
    {
        "" .. Icons.HolyLight .." 확률적으로 빛줄기 눈물 발사",
        "{{ArrowUp}} 연사 +#{{ArrowUp}} 빛줄기 눈물 확률 +"
    },
    
    -- Spider Mod
    {
        "주기적으로 거미알을 소환하여 지나가는 적에게 랜덤 상태이상 효과를 줍니다.#거미알은 20초동안 지속됩니다.",
        "↑ 거미알 소환 빈도 및 지속 시간 증가#방 클리어 시 방 안의 거미알에서 자폭 거미를 소환합니다."
    },
    
    -- Farting Baby
    {
        "{{ArrowUp}} 방귀 확률 +#확률적으로 방귀를 연속적으로 뀝니다.#{{Blank}} (확률은 적과의 거리에 반비례)",
        "{{ArrowUp}} 방귀 확률 ++#화상 방귀와 신성한 방귀를 뀔 수 있습니다."
    },
    
    -- Papa Fly
    {
        "적의 탄환을 막아줍니다.#탄환 방어 시 확률적으로 Brown Nugget 파리 소환",
        "{{ArrowUp}} 사거리 +#{{ArrowUp}} Brown Nugget 파리 소환 확률 +#눈물을 5발 연속으로 발사합니다."
    },
    
    -- Lil Loki
    {
        "8방향으로 공격",
        "{{ArrowUp}} 공격력 +"
    },
    
    -- Hushy
    {
        {
            "멈춰있을 때 15방향으로 적에게 3의 피해를 주는 연속체 눈물을 발사합니다.",
            "{{ArrowUp}} 공격력 +#적이 있는 방에서 오래 멈춰있을 때 꼬마 아이작 패밀리어를 소환합니다."
        },
        {
            "멈춰있을 때 15방향으로 적에게 3의 피해를 주는 연속체 눈물을 발사합니다.",
            "{{ArrowUp}} 공격력 +#적이 있는 방에서 오래 멈춰있을 때 아군 Boil을 소환합니다."
        }
    },
    
    -- Lil Monstro
    {
        "".. Icons.ToughLove .." 확률적으로 이빨을 발사합니다.",
        "{{ArrowUp}} 눈물 양 +"
    },
    
    -- King Baby
    {
        "캐릭터가 공격하는 동안 눈물을 발사합니다.",
        "{{ArrowUp}} 연사 +#따라오는 패밀리어에 따라 눈물에 특수 효과가 추가됩니다."
    },
    
    -- Big Chubby
    {
        "탄환을 막거나 적을 죽일 때마다 크기와 피해량이 증가합니다.#증가한 크기와 피해량은 시간이 지나거나 스테이지 진입 시 감소합니다.",
        "{{ArrowUp}} 쿨타임 감소#{{ArrowUp}} 탄환 방어 및 적 처치 시의 크기 및 피해량 +#증가한 크기와 피해량이 더 이상 스테이지 진입 시 감소하지 않습니다."
    },
    
    -- Mom's Razor
    {
        "{{ArrowUp}} 일반 몬스터의 출혈 시간 +",
        "{{ArrowUp}} 일반 몬스터의 출혈 시간 ++#{{HalfHeart}} 출혈 중인 적 처치 시 커다란 장판을 남기며 확률적으로 빨간하트 반칸을 드랍합니다."
    },
    
    -- Bloodshot Eye
    {
        "눈물을 3방향으로 발사합니다.",
        "눈물 대신 레이저를 발사합니다."
    },
    
    -- Angry Fly
    {
        "적이 있는 방에서 적에게 피해를 주지 않는 동안 분노가 쌓입니다.#분노 수치에 비례하여 적에게 추가 피해를 줍니다.#적에게 피해를 줄 때마다 분노 감소",
        "{{ArrowUp}} 분노 축적량 +"
    },
    
    -- Buddy in a Box
    {
        "2가지의 특수 효과 눈물을 발사합니다.#기본 효과가 폭발성이 아닌 경우 폭발성 효과가 적용되지 않습니다.",
        "3가지의 특수 효과 눈물을 발사합니다."
    },
    
    -- Angelic Prism
    {
        "캐릭터의 공격 방향이 프리즘의 방향에 가까워질수록 프리즘이 캐릭터와 더 가까워집니다.#갈라져나간 눈물이 장애물을 관통합니다.",
        "프리즘이 캐릭터와 더 가까워집니다.#갈라져나간 눈물에 유도 효과가 생깁니다."
    },
    
    -- Lil Spewer
    {
        "장판을 뱉을 때 색상에 따라 다른 효과의 눈물을 추가로 발사합니다.",
        "2가지 색상의 장판을 동시에 뱉습니다."
    },
    
    -- Pointy Rib
    {
        "{{BleedingOut}} 접촉한 일반 몬스터를 확률적으로 출혈시킵니다.#적 처치 시 확률적으로 뼛조각 소환",
        "{{ArrowUp}} 공격력 +#{{ArrowUp}} 출혈 확률 +#{{ArrowUp}} 뼛조각 확률 +"
    },
    
    -- Paschal Candle
    {
        "피격 시 촛불 크기에 비례한 수만큼 불꽃을 발사합니다.",
        "패널티 피격 시 연사 초기화 대신 한 단계만 감소합니다."
    },
    
    -- Blood Oath
    {
        "지나간 자리에 빨간 장판이 생기며 닿은 적은 {{HalfHeart}}깎은 빨간하트에 비례한 피해를 입습니다.",
        "{{Heart}} 빨간하트 반칸을 깎을 때마다 일정 확률로 하트 픽업을 소환합니다."
    },
    
    -- Psy Fly
    {
        "적의 탄환을 유도탄으로 반사합니다.",
        "{{ArrowUp}} 접촉 대미지 +#{{ArrowUp}} 반사탄 공격력 +"
    },
    
    -- Boiled Baby
    {
        "{{ArrowUp}} 눈물 발사 수 +",
        "캐릭터의 공격하는 방향으로 발사합니다."
    },
    
    -- Freezer Baby
    {
        "{{ArrowUp}} 공격력 +#{{ArrowUp}} 사거리 +#{{ArrowUp}} 빙결 확률 +",
        "{{ArrowUp}} 공격력 +#빙결시킨 적을 즉시 파괴합니다."
    },
    
    -- Lost Soul
    {
        "{{ArrowUp}} 보상 등급 +#"..Icons.HolyCard.." 피격을 1회 방어합니다.",
        ""..Icons.HolyMantle .. " 그 방에서 피격을 1회 방어합니다."
    },
    
    -- Lil Dumpy
    {
        "방 입장 시 타입이 변경됩니다:" ..
        "#".. Icons.LilDumpy.DUMPLING .." 기본형"..
        "#".. Icons.LilDumpy.SKINLING .." 독성 : 주변의 적을 중독"..
        "#".. Icons.LilDumpy.SCABLING .." 방귀를 뀔 때 6방향 눈물"..
        "#".. Icons.LilDumpy.SCORCHLING .." 방귀를 뀔 때 불꽃 소환"..
        "#".. Icons.LilDumpy.FROSTLING .." 적 처치 시 빙결 + 비활성화 시 빙결 오라"..
        "#".. Icons.LilDumpy.DROPLING .." 방귀를 뀔 때 반대 방향으로 눈물 발사",
        "일정 시간 후 자동으로 다시 활성화됩니다."
    },
    
    -- Bot Fly
    {
        "{{ArrowUp}} 사거리, 탄속, 눈물 크기 +#눈물과 파리 사이에 레이저가 생깁니다.#레이저가 확률적으로 적의 탄환을 막아줍니다.",
        "{{ArrowUp}} 사거리, 탄속, 눈물 크기 +#공격이 적 및 탄환을 관통합니다.#낮은 확률로 적을 공격합니다."
    },
    
    -- Fruity Plum
    {
        "{{ArrowUp}} 공격력 +#약한 유도 눈물을 발사합니다.",
        "".. Icons.PlaydoughCookie .." 랜덤 효과의 눈물을 발사합니다.#공격 종료 후 8방향으로 눈물을 추가로 발사합니다."
    },
    
    -- Cube Baby
    {
        "주변의 적에 냉기 피해를 주는 오라를 발산합니다.",
        "{{ArrowUp}} 오라 크기 +#속력에 비례한 간격으로 적에게 피해를 주는 장판을 생성합니다."
    },
    
    -- Lil Abaddon
    {
        "{{ArrowUp}} 공격력 +#충전 중 패밀리어 위치에 소용돌이를 설치하며 공격키를 떼면 소용돌이 주위에 검은 고리를 추가로 두릅니다.",
        "{{ArrowUp}} 소용돌이 설치 빈도 +#{{ArrowUp}} 소용돌이 고리의 지속시간 및 피해량 +#{{BlackHeart}} 낮은 확률로 블랙하트 드랍"
    },
    
    -- Worm Friend
    {
        "구속한 적 주변의 탄환을 해당 적으로 끌어들입니다.#{{ArrowUp}} 쿨타임 -",
        "{{ArrowUp}} 구속한 적이 모든 종류의 피해에 추가 피해를 받습니다."
    },
    
    -- Vanishing Twin
    {
        "복사된 보스의 체력 -25%",
        "복사된 보스 처치 시 확률적으로 더 높은 등급의 아이템이 소환됩니다.#!!! (부득이한 경우 보물방 배열의 아이템이 나올 수 있음)"
    },
    
    -- Twisted Pair
    {
        "{{ArrowUp}} 공격력 +0.33#공격 중 캐릭터와 더 가까워집니다.",
        "캐릭터와 같은 축에서 눈물을 발사합니다."
    },
}

return familiarsUpgrades