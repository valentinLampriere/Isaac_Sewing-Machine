local Globals = require("sewn_scripts.core.globals")

local Random = { }

function Random:Roll(rng)
    rng = rng or Globals.rng
    return rng:RandomFloat() * 100
end
function Random:CheckRoll(percentChance, rng)
    local roll = Random:Roll(rng)
    return roll <= percentChance
end

return Random