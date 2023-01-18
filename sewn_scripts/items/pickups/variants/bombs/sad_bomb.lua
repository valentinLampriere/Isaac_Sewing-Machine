local Enums = require("sewn_scripts.core.enums")
local Pickup = require("sewn_scripts.items.pickups.pickup")

local SadBomb = { }

SadBomb.Variant = PickupVariant.PICKUP_BOMB
SadBomb.SubType = Enums.BombVariant.SAD_BOMB

function SadBomb:OnPickedUp(pickup, player)
    local pData = player:GetData()

    pData.Sewn_bonusBombFlag = pData.Sewn_bonusBombFlag or 0
    pData.Sewn_bonusBombFlag = pData.Sewn_bonusBombFlag | TearFlags.TEAR_SAD_BOMB

    player:AddBombs(1)
end

Pickup:RegisterNewPickup(SadBomb)

return SadBomb