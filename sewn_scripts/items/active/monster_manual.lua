local GetPlayerUsingItem = require("sewn_scripts.helpers.get_player_using_item")
local Delay = require("sewn_scripts.helpers.delay")

local MonsterManual = { }

function MonsterManual:OnUseItem(collectibleType, rng)
    if collectibleType ~= CollectibleType.COLLECTIBLE_MONSTER_MANUAL then
        return
    end
    local player = GetPlayerUsingItem()
    
    Delay:DelayFunction(function ()
        local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)

        -- Detecting familiars which just spawn
        for _, familiar in ipairs(familiars) do
            familiar = familiar:ToFamiliar()
            if GetPtrHash(player) == GetPtrHash(familiar.Player) then
                if familiar.FrameCount <= 1 then
                    local fData = familiar:GetData()
                    fData.Sewn_noUpgrade = true
                end
            end
        end
    end)
end

return MonsterManual