local BigChubby = { }

BigChubby.Stats = {
    TearBonus = 1,
    FrameLoseBonus = 0.0,
    HitBonus = 0.33,
    DamageCoefficient = 1,
    SizeCoefficient = 0.25,
    ScaleCoefficient = 0.25
}

local BASE_DAMAGE = 2.7
local BASE_SIZE = 13

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.BIG_CHUBBY, CollectibleType.COLLECTIBLE_BIG_CHUBBY)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BIG_CHUBBY,
    "",
    "", nil, "Big Chubby"
)

local function UpdateSize(familiar)
    local fData = familiar:GetData()

    --local bonus = math.log(fData.Sewn_bigChubby_sizeCoefficient + 1, 10)
    local bonus = math.sqrt(fData.Sewn_bigChubby_sizeCoefficient * 0.2)
    local scale = bonus * BigChubby.Stats.ScaleCoefficient + 1
    print(fData.Sewn_bigChubby_sizeCoefficient .. " => " .. bonus)
    familiar.SpriteScale = Vector(scale, scale)
    familiar.CollisionDamage = BASE_DAMAGE + BASE_DAMAGE * bonus * BigChubby.Stats.DamageCoefficient
    familiar.Size = BASE_SIZE + BASE_SIZE * bonus * BigChubby.Stats.SizeCoefficient
end

function BigChubby:OnInit(familiar)
    local fData = familiar:GetData()
    fData.Sewn_bigChubby_sizeCoefficient = 0
end

function BigChubby:OnUpdate(familiar)
    local fData = familiar:GetData()
    if fData.Sewn_bigChubby_sizeCoefficient > 0 then
        UpdateSize(familiar)
        local f = (1/3000) * (fData.Sewn_bigChubby_sizeCoefficient * fData.Sewn_bigChubby_sizeCoefficient)
        fData.Sewn_bigChubby_sizeCoefficient = fData.Sewn_bigChubby_sizeCoefficient - f - BigChubby.Stats.FrameLoseBonus
    end
end

function BigChubby:OnUpdateUltra(familiar)
    if familiar.FireCooldown > 15 then
        familiar.FireCooldown = 15
    end
end

function BigChubby:OnPreFamiliarCollision(familiar, collider)
    local fData = familiar:GetData()
    if collider.Type == EntityType.ENTITY_PROJECTILE then
        fData.Sewn_bigChubby_sizeCoefficient = fData.Sewn_bigChubby_sizeCoefficient + BigChubby.Stats.TearBonus * collider.CollisionDamage
        collider:Die()
    end
end

function BigChubby:OnKillNpc(familiar, npc)
    local fData = familiar:GetData()

    fData.Sewn_bigChubby_sizeCoefficient = fData.Sewn_bigChubby_sizeCoefficient + math.sqrt(npc.MaxHitPoints)
end
function BigChubby:OnHitNpc(familiar, npc)
    local fData = familiar:GetData()

    fData.Sewn_bigChubby_sizeCoefficient = fData.Sewn_bigChubby_sizeCoefficient + BigChubby.Stats.HitBonus
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_INIT, BigChubby.OnInit, FamiliarVariant.BIG_CHUBBY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, BigChubby.OnInit, FamiliarVariant.BIG_CHUBBY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, BigChubby.OnUpdate, FamiliarVariant.BIG_CHUBBY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.PRE_FAMILIAR_COLLISION, BigChubby.OnPreFamiliarCollision, FamiliarVariant.BIG_CHUBBY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_KILL_NPC, BigChubby.OnKillNpc, FamiliarVariant.BIG_CHUBBY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_HIT_NPC, BigChubby.OnHitNpc, FamiliarVariant.BIG_CHUBBY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, BigChubby.OnUpdateUltra, FamiliarVariant.BIG_CHUBBY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)