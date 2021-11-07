---@diagnostic disable: undefined-global
local function CColor(r, g, b, a, ro, go, bo)
    a = a or 255
    ro = ro or 0
    go = go or 0
    bo = bo or 0

    if REPENTANCE then
        return Color(r / 255, g / 255, b / 255, a / 255, ro / 255, go / 255, bo / 255)
    else
        return Color(r / 255, g / 255, b, a / 255, ro, go, bo)
    end
end

return CColor