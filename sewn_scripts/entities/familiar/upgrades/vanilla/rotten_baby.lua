local Globals = require("sewn_scripts.core.globals")
local Random = require("sewn_scripts.helpers.random")

local RottenBaby = { }

RottenBaby.Stats = {
    KingBabySpawnFlyChance = {
        [Sewn_API.Enums.FamiliarLevel.NORMAL] = 25,
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 30,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 35
    }
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.ROTTEN_BABY, CollectibleType.COLLECTIBLE_ROTTEN_BABY)

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

function RottenBaby:OnFamiliarShootSuper(familiar, sprite)
    if sprite:GetFrame() == 0 then
        local fData = familiar:GetData()
        
        if not CheckIfStillFlyExists(fData.Sewn_rottenBaby_additionalFlies) then
            SpawnFly(familiar)
        end
    end
end

function RottenBaby:OnFamiliarShootUltra(familiar, sprite)
    if sprite:GetFrame() == 0 then
        local fData = familiar:GetData()
        
        if not CheckIfStillFlyExists(fData.Sewn_rottenBaby_additionalLocusts) then
            SpawnLocusts(familiar)
        end
    end
end

function RottenBaby:OnNpcTakeDamage(familiar, npc, amount, flags, source, countdown)
    if source == nil or source.Entity == nil then
        -- No source damage
        return
    end

    local sourceTear = source.Entity:ToTear()

    if sourceTear == nil then
        -- Source is not a tear (therfore not King Baby tear)
        return
    end

    local tData = sourceTear:GetData()

    if tData.Sewn_kingBaby_isSummonTear ~= true then
        -- Not a King Baby tear
        return true
    end

    local tearSpawner = sourceTear.SpawnerEntity

    if tearSpawner == nil or tearSpawner.Type ~= EntityType.ENTITY_FAMILIAR or tearSpawner.Variant ~= FamiliarVariant.KING_BABY then
        -- Not a King Baby tear (double check)
        return
    end

    tearSpawner = tearSpawner:ToFamiliar()

    if GetPtrHash(tearSpawner.Player) ~= GetPtrHash(familiar.Player) then
        -- Not from the same player
        return
    end

    local kingBabyFData = tearSpawner:GetData()

    if Sewn_API:IsUltra(kingBabyFData) == false then
        -- King Baby isn't Ultra
        return
    end

    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    if Random:CheckRoll(RottenBaby.Stats.KingBabySpawnFlyChance[level]) then
        familiar.Player:AddBlueFlies(1, tearSpawner.Position, nil)
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, RottenBaby.OnFamiliarUpgraded, FamiliarVariant.ROTTEN_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_INIT, RottenBaby.OnFamiliarUpgraded, FamiliarVariant.ROTTEN_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_PLAY_ANIM, RottenBaby.OnFamiliarShootSuper, FamiliarVariant.ROTTEN_BABY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_SUPER, "FloatShootDown", "FloatShootUp", "FloatShootSide", "ShootDown", "ShootUp", "ShootSide")
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_PLAY_ANIM, RottenBaby.OnFamiliarShootUltra, FamiliarVariant.ROTTEN_BABY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA, "FloatShootDown", "FloatShootUp", "FloatShootSide", "ShootDown", "ShootUp", "ShootSide")
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ENTITY_TAKE_DAMAGE, RottenBaby.OnNpcTakeDamage, FamiliarVariant.ROTTEN_BABY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ANY)