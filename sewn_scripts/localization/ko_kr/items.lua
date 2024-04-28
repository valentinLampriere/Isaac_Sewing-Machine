--- -- Name of the item in english, do not change it!
--- {
---     "Item Name",
---     "Description of the item",
--- }

local Icons = require("sewn_scripts.localization.localization_helpers")

local items = {
    -- Sewing Box
    {
        "바느질 상자",
        "사용 시 그 방에서 모든 패밀리어의 등급을 를 한 단계 상승시킵니다.#{{UltraCrown}} (그 방에서 2회 사용 시 최대 등급)#{{SuperCrown}} 업그레이드 가능한 패밀리어가 없을 경우 그 방에서 랜덤 2단계 패밀리어를 소환합니다."
    },
    
    -- Doll's Tainted Head
    {
        "더럽혀진 인형 머리",
        "{{SuperCrown}}모든 패밀리어가 최소 2단계인 상태로 등장합니다.#".. Icons.PureBody .." Doll's Pure Body 소지 시 모든 패밀리어가 {{UltraCrown}}최대 등급이 됩니다.#{{DevilRoom}} 악마방에서의 재봉틀 머신 등장 확률 +20%"
    },
    
    -- Doll's Pure Body
    {
        "순수한 인형 몸체",
        "{{SuperCrown}}모든 패밀리어가 최소 2단계인 상태로 등장합니다.#".. Icons.TaintedHead .." Doll's Tainted Head 소지 시 모든 패밀리어가 {{UltraCrown}}최대 등급이 됩니다.#{{AngelRoom}} 천사방에서의 재봉틀 머신 등장 확률 +20%"
    },
}

return items