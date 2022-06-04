local Fart = require("sewn_scripts.entities.effects.fart")

local BurningFart = { }
BurningFart.SubType = 75
BurningFart.Gfx = "/gfx/effects/burning_fart.png"

BurningFart.Stats = {
    BurningDurationMin = 62,
    BurningDurationMax = 152
}

function BurningFart:OnEntityTakeFartDamage(entity, amount, flags, fartSource, countdown)
    local rng = fartSource:GetDropRNG()
    local duration = rng:RandomInt( BurningFart.Stats.BurningDurationMax - BurningFart.Stats.BurningDurationMin ) + BurningFart.Stats.BurningDurationMin
    entity:AddBurn(EntityRef(fartSource), duration, 1)
end

Fart:RegisterFart(BurningFart)

return BurningFart