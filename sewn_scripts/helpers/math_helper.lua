local MathHelper = { }

function MathHelper:Round(number, numDecimalPlaces)
    if numDecimalPlaces and numDecimalPlaces>0 then
      local mult = 10^numDecimalPlaces
      return math.floor(number * mult + 0.5) / mult
    end
    return math.floor(number + 0.5)
end

return MathHelper