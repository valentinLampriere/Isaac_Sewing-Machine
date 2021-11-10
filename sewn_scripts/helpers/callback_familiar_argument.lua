local Enums = require("sewn_scripts.core.enums")

local CallbackFamiliarArgument = { }

function CallbackFamiliarArgument:LevelFlagCheck(familiar, flag)
    local fData = familiar:GetData()
    local isValid = false
    if flag & Enums.FamiliarLevelFlag.FLAG_NORMAL == Enums.FamiliarLevelFlag.FLAG_NORMAL then
        if not Sewn_API:IsSuper(fData, false) and not Sewn_API:IsUltra(fData) then
            isValid = true
        end
    end
    if flag & Enums.FamiliarLevelFlag.FLAG_SUPER == Enums.FamiliarLevelFlag.FLAG_SUPER and Sewn_API:IsSuper(fData, false) then
        isValid = true
    end
    if flag & Enums.FamiliarLevelFlag.FLAG_ULTRA == Enums.FamiliarLevelFlag.FLAG_ULTRA and Sewn_API:IsUltra(fData) then
        isValid = true
    end
    return isValid
end
function CallbackFamiliarArgument:Check(familiar, variant, flag)
    return (variant == -1 or variant == familiar.Variant) and CallbackFamiliarArgument:LevelFlagCheck(familiar, flag)
end

return CallbackFamiliarArgument