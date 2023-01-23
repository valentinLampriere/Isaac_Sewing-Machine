if Sewn_Debug ~= nil then
    return Sewn_Debug
end

local MathHelper = require("sewn_scripts.helpers.math_helper")
local StringHelper = require("sewn_scripts.helpers.string_helper")

local Debug = {
    Enabled = false
}

local renderTextTable = { }

Debug.Color = {
    White = {1, 1, 1},
    Red = {1, 0, 0},
    Blue = {0, 0, 1},
    Green = {0, 1, 0},
}

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
    for id, log in pairs(renderTextTable) do
        local color = log.Color
        Isaac.RenderText(log.Text, Debug.Stats.PositionX, Debug.Stats.PositionY + i * Debug.Stats.RowHeight, color[1], color[2], color[3], 1)
        i = i + 1
    end
end

function Debug:OnExecuteCmd(cmd, args)
    if cmd == "sewn" and args[1] == "debug" then
        Debug.Enabled = not Debug.Enabled
        if Debug.Enabled == true then
            print("Sewing Machine debug enabled")
        else
            print("Sewing Machine debug disabled")
        end
    end
end

function Debug:RenderText(text, id, color)
    text = tostring(text) or "[unset text]"
    id = tostring(id) or "0"
    color = color or Debug.Color.White

    renderTextTable[id] = { Text = text, Color = color }
end

function Debug:RenderVector(vector, id, color, decimal)
    if vector == nil then
        Debug:RenderText("[unset vector]")
        return
    end

    decimal = decimal or 3

    local spaceAmount = 1

    local x = MathHelper:Round(vector.X, decimal)
    local xSplitStr = StringHelper:Split(tostring(x), ".")
    local xDecimalStr = xSplitStr[2]

    if xDecimalStr ~= nil then
        -- For decimals
        spaceAmount = spaceAmount + (decimal - #xDecimalStr)
    end
    -- For minus sign
    spaceAmount = spaceAmount - ((x < 0) and 1 or 0)

    local strVector = "X : " .. x

    for i = 0, spaceAmount do
        strVector = strVector .. " "
    end

    strVector = strVector .. " Y : " .. MathHelper:Round(vector.Y, decimal)
    
    Debug:RenderText(strVector, id, color)
end

function Debug:RenderColor(color)
    if color == nil then
        Debug:RenderText("[unset color]")
        return
    end

    if color.A == nil then
        Debug:RenderText("[not valid color]")
    end

    Debug:RenderText( "(" .. color.R .. ", " .. color.G .. ", " .. color.B .. ")" .. "[".. color.A .."]" .. "(" .. color.RO .. ", " .. color.GO .. ", " .. color.BO .. ")"  )
end

Sewn_Debug = Debug
return Debug