---@diagnostic disable: undefined-global
local function CColor(r, g, b, a, ro, go, bo)
    a = a or 1
    ro = ro or 0
    go = go or 0
    bo = bo or 0

    if REPENTANCE then
        return Color(r, g, b, a, ro, go, bo)
    else
        return Color(r, g, b, a, math.floor(ro * 255), math.floor(go * 255), math.floor(bo * 255))
    end
end

return CColor