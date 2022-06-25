local Globals = require("sewn_scripts.core.globals")

local RottenBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.ROTTEN_BABY, CollectibleType.COLLECTIBLE_ROTTEN_BABY)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.ROTTEN_BABY,
    "Spawns an additional blue fly",
    "Spawns a random locust", nil, "Rotten Baby"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.ROTTEN_BABY,
    "每次额外生成一只蓝苍蝇",
    "生成一个随机蝗虫 #若生成征服蝗虫则生成两只", nil, "腐烂宝宝","zh_cn"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.ROTTEN_BABY,
    nil,
    "Spawn a random locust#Spawn two conquest locusts at a time"
)

local function CheckIfStillFlyExists(tableFlies)
    for _, flyPtr in ipairs(tableFlies) do
        if flyPtr ~= nil and flyPtr.Ref ~= nil and flyPtr.Ref:Exists() then
            return true
        end
    end
    return false
end
local function SpawnFly(familiar)
    local fData = familiar:GetData()
    local newFly = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, 0, familiar.Position, Globals.V0, familiar)
    newFly:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
    table.insert(fData.Sewn_rottenBaby_additionalFlies, EntityPtr(newFly))
end
local function SpawnLocusts(familiar)
    local fData = familiar:GetData()
    local rollLocust = familiar:GetDropRNG():RandomInt(5) + 1
    for i = 1, rollLocust == 5 and 2 or 1 do
        local newLocust = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, rollLocust, familiar.Position, Globals.V0, familiar)
        newLocust:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
        table.insert(fData.Sewn_rottenBaby_additionalLocusts, EntityPtr(newLocust))
    end
end

function RottenBaby:OnFamiliarUpgraded(familiar, isPermanentUpgrade)
    local fData = familiar:GetData()
    
    fData.Sewn_rottenBaby_additionalFlies = { }
    fData.Sewn_rottenBaby_additionalLocusts = { }
end

function RottenBaby:OnFamiliarShoot(familiar, sprite)
    if sprite:GetFrame() == 0 then
        local fData = familiar:GetData()
        
        if not CheckIfStillFlyExists(fData.Sewn_rottenBaby_additionalFlies) then
            SpawnFly(familiar)
        end
        if Sewn_API:IsUltra(fData) then
            if not CheckIfStillFlyExists(fData.Sewn_rottenBaby_additionalLocusts) then
                SpawnLocusts(familiar)
            end
        end
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, RottenBaby.OnFamiliarUpgraded, FamiliarVariant.ROTTEN_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_INIT, RottenBaby.OnFamiliarUpgraded, FamiliarVariant.ROTTEN_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_PLAY_ANIM, RottenBaby.OnFamiliarShoot, FamiliarVariant.ROTTEN_BABY, nil, "FloatShootDown", "FloatShootUp", "FloatShootSide", "ShootDown", "ShootUp", "ShootSide")