
local function GetDirectionFromAngle(angle)
    if angle == nil then return Direction.NO_DIRECTION end
    if angle > 45 and angle < 135 then
        return Direction.DOWN
    elseif angle > 135 and angle < 180 or angle > -180 and angle < -135 then
        return Direction.LEFT
    elseif angle > -135 and angle < -45 then
        return Direction.UP
    elseif angle > -45 and angle < 0 or angle > 0 and angle < 45 then
        return Direction.RIGHT
    end
    return Direction.NO_DIRECTION
end

return GetDirectionFromAngle