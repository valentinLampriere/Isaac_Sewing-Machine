local Debug = { }

local renderTextTable = { }

Debug.Stats = {
    PositionX = 50,
    PositionY = 30,
    RowHeight = 15
}

local function round(num, numDecimalPlaces)
    if numDecimalPlaces and numDecimalPlaces>0 then
      local mult = 10^numDecimalPlaces
      return math.floor(num * mult + 0.5) / mult
    end
    return math.floor(num + 0.5)
end

function Debug:OnRender()
    local i = 0;
    for id, text in pairs(renderTextTable) do
        Isaac.RenderText(text, Debug.Stats.PositionX, Debug.Stats.PositionY + i * Debug.Stats.RowHeight, 1, 1, 1, 1)
        i = i + 1
    end
end

function Debug:RenderText(text, id)
    text = tostring(text) or "[unset text]"
    id = tostring(id) or "0"

    renderTextTable[id] = text
end

function Debug:RenderVector(vector, id, decimal)
    vector = vector or Vector(-999, -999)
    decimal = decimal or 3
    
    Debug:RenderText("X : " .. round(vector.X, decimal) .. ", Y : " .. round(vector.Y, decimal), id)
end

return Debug