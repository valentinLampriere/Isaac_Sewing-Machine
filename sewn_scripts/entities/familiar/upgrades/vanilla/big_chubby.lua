local BigChubby = { }

BigChubby.Stats = {
    SizeDecreaseBonusFrameFormula = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = function(coefficient) return (1/3000) * (coefficient * coefficient)+ 0.01 end,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = function(coefficient) return (1/3000) * (coefficient * coefficient) + 0.01 end
    },
    SizeIncreaseFormulaEatBullet = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = function (bullet) return 1 * bullet.CollisionDamage end,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = function (bullet) return 1.25 * bullet.CollisionDamage end,
    },
    SizeIncreaseFormulaKillNpc = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = function (npc) return math.sqrt(npc.MaxHitPoints) * 0.8 end,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = function (npc) return math.sqrt(npc.MaxHitPoints) end,
    },
    SizeIncreaseFormulaHitNpc = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = function (npc) return 0 end,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = function (npc) return 0.25 end,
    },
    SizeFormula = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = function (coefficient) return math.sqrt(coefficient * 0.2) end,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = function (coefficient) return math.sqrt(coefficient * 0.2) end,
    },
    DamageCoefficient = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 1
    },
    SizeCoefficient = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0.2,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 0.2
    },
    ScaleCoefficient = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0.25,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 0.25
    },
    FireCooldownBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 15
    },
}

local BASE_DAMAGE = 2.7
local BASE_SIZE = 13

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.BIG_CHUBBY, CollectibleType.COLLECTIBLE_BIG_CHUBBY)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BIG_CHUBBY,
    "Increase its size and damage when eating bullets and when killing monsters.#Reduce its size over time and on a new level.",
    "Increase its size even more while dealing damage to enemies.#Do no more lose it damage bonus on a new level.#{{ArrowUp}} Reduce cooldown", nil, "Big Chubby"
)

local function UpdateSize(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    local bonus = BigChubby.Stats.SizeFormula[level](fData.Sewn_bigChubby_sizeCoefficient)
    local scale = bonus * BigChubby.Stats.ScaleCoefficient[level] + 1
    
    familiar.SpriteScale = Vector(scale, scale)
    familiar.CollisionDamage = BASE_DAMAGE + BASE_DAMAGE * bonus * BigChubby.Stats.DamageCoefficient[level]
    familiar.Size = BASE_SIZE + BASE_SIZE * bonus * BigChubby.Stats.SizeCoefficient[level]
end

function BigChubby:OnInit(familiar)
    local fData = familiar:GetData()
    fData.Sewn_bigChubby_sizeCoefficient = 0
end

function BigChubby:OnUpdate(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    if fData.Sewn_bigChubby_sizeCoefficient > 0 then
        UpdateSize(familiar)

        fData.Sewn_bigChubby_sizeCoefficient = fData.Sewn_bigChubby_sizeCoefficient - BigChubby.Stats.SizeDecreaseBonusFrameFormula[level](fData.Sewn_bigChubby_sizeCoefficient)
    end
end

function BigChubby:OnUpdateUltra(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    if familiar.FireCooldown > BigChubby.Stats.FireCooldownBonus[level] then
        familiar.FireCooldown = BigChubby.Stats.FireCooldownBonus[level]
    end
end

function BigChubby:OnPreFamiliarCollision(familiar, collider)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    if collider.Type == EntityType.ENTITY_PROJECTILE then
        fData.Sewn_bigChubby_sizeCoefficient = fData.Sewn_bigChubby_sizeCoefficient + BigChubby.Stats.SizeIncreaseFormulaEatBullet[level](collider)
        collider:Die()
    end
end

function BigChubby:OnKillNpc(familiar, npc)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    fData.Sewn_bigChubby_sizeCoefficient = fData.Sewn_bigChubby_sizeCoefficient + BigChubby.Stats.SizeIncreaseFormulaKillNpc[level](npc)
end

function BigChubby:OnHitNpc(familiar, npc)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)

    fData.Sewn_bigChubby_sizeCoefficient = fData.Sewn_bigChubby_sizeCoefficient + BigChubby.Stats.SizeIncreaseFormulaHitNpc[level](npc)
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_INIT, BigChubby.OnInit, FamiliarVariant.BIG_CHUBBY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, BigChubby.OnInit, FamiliarVariant.BIG_CHUBBY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, BigChubby.OnUpdate, FamiliarVariant.BIG_CHUBBY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.PRE_FAMILIAR_COLLISION, BigChubby.OnPreFamiliarCollision, FamiliarVariant.BIG_CHUBBY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_KILL_NPC, BigChubby.OnKillNpc, FamiliarVariant.BIG_CHUBBY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_NEW_LEVEL, BigChubby.OnInit, FamiliarVariant.BIG_CHUBBY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_SUPER)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_HIT_NPC, BigChubby.OnHitNpc, FamiliarVariant.BIG_CHUBBY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, BigChubby.OnUpdateUltra, FamiliarVariant.BIG_CHUBBY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)