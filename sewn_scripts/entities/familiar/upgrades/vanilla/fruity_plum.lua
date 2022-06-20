local CColor = require("sewn_scripts.helpers.ccolor")
local FindCloserNpc = require("sewn_scripts.helpers.find_closer_npc")
local ShootTearsCircular = require("sewn_scripts.helpers.shoot_tears_circular")

local FruityPlum = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.FRUITY_PLUM, CollectibleType.COLLECTIBLE_FRUITY_PLUM)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.FRUITY_PLUM,
    "{{ArrowUp}} Damage Up#Small homing effect",
    "Gains a Playdough Cookie {{Collectible"..CollectibleType.COLLECTIBLE_PLAYDOUGH_COOKIE.."}} effect#After an attack, fire tears in all directions", nil, "Fruity Plum"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.FRUITY_PLUM,
    "{{ArrowUp}} 攻击提升 #微量的跟踪效果",
    "获得 {{Collectible"..CollectibleType.COLLECTIBLE_PLAYDOUGH_COOKIE.."}} 黏土饼干的效果 #在攻击完成后向所有方向发射眼泪", nil, "Fruity Plum", "zh_cn"
)

local function TEARFLAGS(x)
    return x >= 64 and BitSet128(0,1<<(x - 64)) or BitSet128(1<<x,0)
end

FruityPlum.Stats = {
    TearDamage = 1.33,
    TearScale = 1.07
}

local fruityPlumTearEffect = {
    {  },
    { TearFlag = TearFlags.TEAR_POISON, Color = CColor(0.4, 0.97, 0.5, 1) },
    { TearFlag = TearFlags.TEAR_FEAR, CColor(1, 1, 0.455, 1, 0.169, 0.145, 0) },
    { TearFlag = TearFlags.TEAR_SHRINK },
    { TearFlag = TEARFLAGS(65) }, -- ICE
    { TearFlag = TearFlags.TEAR_CHARM, Color = CColor(1, 0, 1, 1, 0.196, 0, 0) },
    { TearFlag = TearFlags.TEAR_FREEZE, Color = CColor(1.25, 0.05, 0.15, 1) },
    { TearFlag = TearFlags.TEAR_BURN, Color = CColor(1, 1, 1, 1, 0.3, 0, 0), Function = function(tear) tear:Update() end },
    { TearFlag = TearFlags.TEAR_HOMING, Color = CColor(0.4, 0.15, 0.38, 1, 0.27843, 0, 0.4549) },
    { TearFlag = TEARFLAGS(67), Color = CColor(0.7, 0.14, 0.1, 1, 0.3, 0, 0) }, -- BAIT

}

function FruityPlum:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()

    if fData.Sewn_fruityPlum_targetNpc == nil then
        if familiar.State == 4 or familiar.State == 6 then
            local npc = FindCloserNpc(familiar.Position + familiar.Velocity * 10, 150)
            fData.Sewn_fruityPlum_targetNpc = npc
        end
    end

    if fData.Sewn_fruityPlum_targetNpc ~= nil then
        if not fData.Sewn_fruityPlum_targetNpc:Exists() or fData.Sewn_fruityPlum_targetNpc:IsDead() or fData.Sewn_fruityPlum_targetNpc:IsInvincible() then
            fData.Sewn_fruityPlum_targetNpc = nil
        else
            local direction = (fData.Sewn_fruityPlum_targetNpc.Position - familiar.Position):Normalized()
            familiar.Velocity = familiar.Velocity + direction * 0.3
        end
    end
end

function FruityPlum:OnFamiliarUpdate_Ultra(familiar)
    local fData = familiar:GetData()
    if fData.Sewn_fruityPlum_previousState == 6 and familiar.State ~= 6 then
        local tears = ShootTearsCircular(familiar, 8, TearVariant.BLUE, nil, 4, 3)
        for _, tear in ipairs(tears) do
            tear = tear:ToTear()
            tear.Scale = tear.Scale * 0.7
        end
        fData.Sewn_fruityPlum_targetNpc = nil
    end
    fData.Sewn_fruityPlum_previousState = familiar.State
end

function FruityPlum:OnFamiliarFireTear(familiar, tear)
    tear.CollisionDamage = tear.CollisionDamage * FruityPlum.Stats.TearDamage
    tear.Scale = tear.Scale * FruityPlum.Stats.TearScale
end
function FruityPlum:OnFamiliarFireTear_Ultra(familiar, tear)
    local rollEffect = familiar:GetDropRNG():RandomInt(#fruityPlumTearEffect) + 1
    local effect = fruityPlumTearEffect[rollEffect]

    if effect.TearFlag ~= nil then
        tear:AddTearFlags(effect.TearFlag)
    end
    if effect.Color ~= nil then
        tear:SetColor(effect.Color, -1, 1, false, false)
    end
    if effect.Function ~= nil then
        effect.Function(tear)
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, FruityPlum.OnFamiliarUpdate, FamiliarVariant.FRUITY_PLUM)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, FruityPlum.OnFamiliarFireTear, FamiliarVariant.FRUITY_PLUM)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, FruityPlum.OnFamiliarUpdate_Ultra, FamiliarVariant.FRUITY_PLUM, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, FruityPlum.OnFamiliarFireTear_Ultra, FamiliarVariant.FRUITY_PLUM, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)