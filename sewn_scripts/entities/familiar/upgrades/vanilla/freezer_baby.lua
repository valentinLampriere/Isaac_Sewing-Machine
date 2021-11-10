local ShootTearsCircular = require("sewn_scripts.helpers.shoot_tears_circular")
local Random = require("sewn_scripts.helpers.random")

local FreezerBaby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.FREEZER_BABY, CollectibleType.COLLECTIBLE_FREEZER_BABY)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.FREEZER_BABY,
    "{{ArrowUp}} Damage Up#{{ArrowUp}} Range Up#Increase the chance to freeze enemies",
    "Enemies it kills explodes into ice tears#{{ArrowUp}} Damage Up"
)

FreezerBaby.Stats = {
    TearDamageMultiplier = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1.5,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1.75
    },
    TearRange = 3,
    AdditionalFreezeChance = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 10,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 15
    }
}


function FreezerBaby:OnFamiliarFireTear(familiar, tear)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    tear.CollisionDamage = tear.CollisionDamage * FreezerBaby.Stats.TearDamageMultiplier[level]
    tear.FallingAcceleration = 0.02 + -0.02 * FreezerBaby.Stats.TearRange
end

function FreezerBaby:OnFamiliarKillNpc_Ultra(familiar, npc)
    local fData = familiar:GetData()
    local amountTears = math.ceil(math.sqrt(npc.MaxHitPoints * 3))
    if amountTears < 5 then
        amountTears = 5
    end
    if amountTears > 15 then
        amountTears = 15
    end
    ShootTearsCircular(familiar, amountTears, TearVariant.ICE, npc.Position, 7, 3.5, TearFlags.TEAR_ICE, npc.Size * 0.15)
    fData.Sewn_freezerBaby_deadNpcs[GetPtrHash(npc)] = true
end

function FreezerBaby:OnFamiliarNewRoom_Ultra(familiar, isPermanentUpgrade)
    local fData = familiar:GetData()
    fData.Sewn_freezerBaby_deadNpcs = { }
end

function FreezerBaby:OnFamiliarTearCollision(familiar, tear, collider)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    if fData.Sewn_freezerBaby_deadNpcs[GetPtrHash(collider)] == true then
        return true
    end

    if Random:CheckRoll(level) then
        collider:AddFreeze(EntityRef(familiar), math.random(30, 90))
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, FreezerBaby.OnFamiliarFireTear, FamiliarVariant.FREEZER_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_NEW_ROOM, FreezerBaby.OnFamiliarNewRoom_Ultra, FamiliarVariant.FREEZER_BABY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, FreezerBaby.OnFamiliarNewRoom_Ultra, FamiliarVariant.FREEZER_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_KILL_NPC, FreezerBaby.OnFamiliarKillNpc_Ultra, FamiliarVariant.FREEZER_BABY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.PRE_FAMILIAR_TEAR_COLLISION, FreezerBaby.OnFamiliarTearCollision, FamiliarVariant.FREEZER_BABY)