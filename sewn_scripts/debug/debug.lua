local MathHelper = require("sewn_scripts.helpers.math_helper")
local StringHelper = require("sewn_scripts.helpers.string_helper")

local Debug = {
    Enabled = false
}

local renderTextTable = { }

Debug.Stats = {
    PositionX = 50,
    PositionY = 30,
    RowHeight = 15
}

function Debug:OnRender()
    if Debug.Enabled == false then
        return
    end
    
    local i = 0;
    for id, text in pairs(renderTextTable) do
        Isaac.RenderText(text, Debug.Stats.PositionX, Debug.Stats.PositionY + i * Debug.Stats.RowHeight, 1, 1, 1, 1)
        i = i + 1
    end
end

function Debug:OnExecuteCmd(cmd, args)
    if cmd == "sewn" and args[1] == "debug" then
        Debug.Enabled = not Debug.Enabled
    end
end

-- TODO : Add a third parameter for colors.
function Debug:RenderText(text, id)
    text = tostring(text) or "[unset text]"
    id = tostring(id) or "0"

    renderTextTable[id] = text
end

function Debug:RenderVector(vector, id, decimal)

    if vector == nil then
        Debug:RenderText("[unset vector]")
        return
    end

    decimal = decimal or 3

    local spaceAmount = 1

    local x = MathHelper:Round(vector.X, decimal)
    local xSplitStr = StringHelper:Split(tostring(x), ".")
    local xDecimalStr = xSplitStr[2]

    -- For decimals
    spaceAmount = spaceAmount + (decimal - #xDecimalStr)
    -- For minus sign
    spaceAmount = spaceAmount - ((x < 0) and 1 or 0)

    local strVector = "X : " .. x

    for i = 0, spaceAmount do
        strVector = strVector .. " "
    end

    strVector = strVector .. " Y : " .. MathHelper:Round(vector.Y, decimal)
    
    Debug:RenderText(strVector, id)
end

return Debug