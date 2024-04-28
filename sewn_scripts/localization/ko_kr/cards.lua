--- -- Name of the card in english, do not change it!
--- {
---     "Card Name",
---     "Description of the card effect",
--- }

local Icons = require("sewn_scripts.localization.localization_helpers")

local cards = {
    -- Warranty Card
    {
        "보증 카드",
        "재봉틀 머신을 소환합니다.#소환되는 재봉틀 머신은 방 종류에 따라 다릅니다."
    },
    
    -- Stitching Card
    {
        "바느질 카드",
        "가능한 경우 모든 패밀리어의 등급을 뒤섞습니다.#업그레이드된 패밀리어가 없을 경우 랜덤 패밀리어 하나의 등급을 올립니다."
    },
    
    -- Sewing Coupon
    {
        "재봉틀 쿠폰",
        Icons.SewingBox.." 가능한 경우 그 방에서 모든 패밀리어의 등급을 를 한 단계 상승시킵니다."
    },
}

return cards