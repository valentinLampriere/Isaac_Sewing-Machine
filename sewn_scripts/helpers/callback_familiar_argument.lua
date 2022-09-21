local Enums = require("sewn_scripts.core.enums")

local CallbackFamiliarArgument = { }

function CallbackFamiliarArgument:LevelFlagCheck(familiar, flag)
    local fData = familiar:GetData()
    if flag & Enums.FamiliarLevelFlag.FLAG_NORMAL == Enums.FamiliarLevelFlag.FLAG_NORMAL then
        if not Sewn_API:IsSuper(fData, false) and not Sewn_API:IsUltra(fData) then
            return true
        end
    end
    if flag & Enums.FamiliarLevelFlag.FLAG_SUPER == Enums.FamiliarLevelFlag.FLAG_SUPER and Sewn_API:IsSuper(fData, false) then
        return true
    end
    if flag & Enums.FamiliarLevelFlag.FLAG_ULTRA == Enums.FamiliarLevelFlag.FLAG_ULTRA and Sewn_API:IsUltra(fData) then
        return true
    end
    if flag & Enums.FamiliarLevelModifierFlag.PURE == Enums.FamiliarLevelModifierFlag.PURE and Sewn_API:IsPure(fData) then
        return true
    end
    if flag & Enums.FamiliarLevelModifierFlag.TAINTED == Enums.FamiliarLevelModifierFlag.TAINTED and Sewn_API:IsTainted(fData) then
        return true
    end

    return false
end
function CallbackFamiliarArgument:Check(familiar, variant, flag)
    return (variant == -1 or variant == familiar.Variant) and CallbackFamiliarArgument:LevelFlagCheck(familiar, flag)
end

return CallbackFamiliarArgument