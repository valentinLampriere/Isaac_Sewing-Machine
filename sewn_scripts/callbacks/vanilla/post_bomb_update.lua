local Bomb = require("sewn_scripts.entities.bombs.bomb")

local function MC_POST_BOMB_UPDATE(_, bomb)
    Bomb:OnBombUpdate(bomb)
end

return MC_POST_BOMB_UPDATE