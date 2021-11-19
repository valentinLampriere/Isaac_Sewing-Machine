local Globals = require("sewn_scripts.core.globals")

local RottenBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.ROTTEN_BABY, CollectibleType.COLLECTIBLE_ROTTEN_BABY)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.ROTTEN_BABY,
    "Spawn an additional blue fly",
    "Spawn a random locuts"
)

local function CheckIfStillFlyExists(tableFlies)
    for _, flyPtr in ipairs(tableFlies) do
        if flyPtr ~= nil and flyPtr:Exists() then
            return true
        end
    end
    return false
end
local function SpawnFly(familiar)
    local fData = familiar:GetData()
    local newFly = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, 0, familiar.Position, Globals.V0, familiar)
    table.insert(fData.Sewn_rottenBaby_additionalLocusts, EntityPtr(newFly))
end
local function SpawnLocusts(familiar)
    local fData = familiar:GetData()
    local rollLocust = familiar:GetDropRNG():RandomInt(5) + 1
    for i = 1, rollLocust == 5 and 2 or 1 do
        local newLocust = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, rollLocust, familiar.Position, Globals.V0, familiar)
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
        local level = Sewn_API:GetLevel(fData)
        
        if not CheckIfStillFlyExists(fData.Sewn_rottenBaby_additionalFlies) then
            local newFly = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, 0, familiar.Position, Globals.V0, familiar)
        table.insert(fData.Sewn_rottenBaby_additionalLocusts, EntityPtr(newFly))
            familiar.Player:AddBlueFlies(RottenBaby.Stats.AmountAdditionalFlies[level], familiar.Position, familiar.Player)
        end
        if Sewn_API:IsUltra(fData) then
            if not CheckIfStillFlyExists(fData.Sewn_rottenBaby_additionalLocusts) then
                SpawnLocusts(familiar)
            end
        end
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, RottenBaby.OnFamiliarUpgraded, FamiliarVariant.ROTTEN_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_PLAY_ANIM, RottenBaby.OnFamiliarShoot, FamiliarVariant.ROTTEN_BABY, nil, "FloatShootDown", "FloatShootUp", "FloatShootSide", "ShootDown", "ShootUp", "ShootSide")