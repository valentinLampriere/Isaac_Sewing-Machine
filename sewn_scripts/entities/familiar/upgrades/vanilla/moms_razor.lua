local Globals = require("sewn_scripts.core.globals")
local CColor = require("sewn_scripts.helpers.ccolor")
local Delay = require("sewn_scripts.helpers.delay")
local Random = require("sewn_scripts.helpers.random")

local MomsRazor = { }

MomsRazor.Stats = {
    BleedDuration = {
        [Sewn_API.Enums.FamiliarLevel.NORMAL] = 120,
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 180,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 200
    },
    HeartDropChance = 10,
    BloodPuddleDamage = 2
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.MOMS_RAZOR, CollectibleType.COLLECTIBLE_MOMS_RAZOR)

-- Sewn_API:AddFamiliarDescription(
--     FamiliarVariant.MOMS_RAZOR,
--     "{{ArrowUp}} Extends the Bleed duration (Bosses are not affected)",
--     "{{ArrowUp}} Extends the Bleed duration#When an enemy dies while bleeding they spawn a large blood puddle#Have a chance to spawn half a heart {{HalfHeart}}", nil, "Mom's Razor"
-- )
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.MOMS_RAZOR,
    "{{ArrowUp}} 延长流血效果的持续时间，Boss不受此影响",
    "当敌人以流血状态死亡时，会生成一滩血迹 # 有概率生成 {{HalfHeart}} 半颗红心 #{{ArrowUp}} 延长流血效果的持续时间", nil, "妈妈的剃刀","zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.MOMS_RAZOR,
    "{{ArrowUp}} Длительность кровотока + (без учёта боссов)",
    "{{ArrowUp}} Длительность кровотока +#Когда враг умирает от кровотока, он оставляет после себя лужу крови#Получает шанс оставить половину красного сердца {{HalfHeart}}", nil, "Мамина Бритва", "ru"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.MOMS_RAZOR,
    "{{ArrowUp}} Augmente la durée du saignement, sauf pour les Boss",
    "{{ArrowUp}} Augmente la durée du saignement#Les ennemis qui meurent en saignant répandent une grande flaque de sang#Peut rarement laisser tomber un demi-cœur {{HalfHeart}}", nil, "Rasoir de Maman", "fr"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.MOMS_RAZOR,
    "{{ArrowUp}} Extiende la duración de sangrado. A los jefes no les afecta.",
    "Cuando un enemigo muere mientras sangra, spawnea un gran lago de sangre.#Tiene una probabilidad de spawnear medio corazón.#{{ArrowUp}} Extiende la duración de sangrado", nil, "Máquina de Afeitar de Mamá", "spa"
)

local function OnKillNpc(familiar, npc)
    local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_LEMON_MISHAP, 0, npc.Position, Globals.V0, familiar):ToEffect()
    creep:SetColor(CColor(0.627, 0, 0), -1, 1, false, false)
    creep.CollisionDamage = MomsRazor.Stats.BloodPuddleDamage
    creep.Visible = false
    Delay:DelayFunction(function ()
        creep.Visible = true
    end, 1)

    if Random:CheckRoll(MomsRazor.Stats.HeartDropChance, familiar:GetDropRNG()) then
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_HALF, familiar.Position, Globals.V0, familiar)
    end
end

function MomsRazor:OnNewRoom(familiar)
    local fData = familiar:GetData()

    fData.Sewn_momsRazor_bleedNpcs = { }
end
function MomsRazor:OnUpdate(familiar)
    local fData = familiar:GetData()

    for npcPtr, npc in pairs(fData.Sewn_momsRazor_bleedNpcs) do
        local nData = npc:GetData()

        if npc:IsDead() and Sewn_API:IsUltra(fData) then
            OnKillNpc(familiar, npc)
            fData.Sewn_momsRazor_bleedNpcs[npcPtr] = nil
        else
            if npc:HasEntityFlags(EntityFlag.FLAG_BLEED_OUT) == false then
                -- Re-apply bleed if the upgraded mom's razor's duration isn't reached.
                if nData.Sewn_momsRazor_bleedStopFrame > familiar.FrameCount then
                    npc:AddEntityFlags(EntityFlag.FLAG_BLEED_OUT)
                end
            else
                -- Remove the bleed effect when duration has passed.
                if nData.Sewn_momsRazor_bleedStopFrame and nData.Sewn_momsRazor_bleedStopFrame <= familiar.FrameCount then
                    npc:ClearEntityFlags(EntityFlag.FLAG_BLEED_OUT)
                    fData.Sewn_momsRazor_bleedNpcs[npcPtr] = nil
                end
            end
        end
    end
end
function MomsRazor:OnCollision(familiar, collider)
    local fData = familiar:GetData()
    local nData = collider:GetData()
    local level = Sewn_API:GetLevel(fData)

    if collider:IsBoss() == false and collider:IsVulnerableEnemy() then
        collider:AddEntityFlags(EntityFlag.FLAG_BLEED_OUT)
        nData.Sewn_momsRazor_bleedStopFrame = familiar.FrameCount + MomsRazor.Stats.BleedDuration[level]
        fData.Sewn_momsRazor_bleedNpcs[GetPtrHash(collider)] = collider
    end
end

function MomsRazor:OnKillNpc(familiar, npc)
    OnKillNpc(familiar, npc)
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_NEW_ROOM, MomsRazor.OnNewRoom, FamiliarVariant.MOMS_RAZOR)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_INIT, MomsRazor.OnNewRoom, FamiliarVariant.MOMS_RAZOR)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, MomsRazor.OnNewRoom, FamiliarVariant.MOMS_RAZOR)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, MomsRazor.OnUpdate, FamiliarVariant.MOMS_RAZOR)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.PRE_FAMILIAR_COLLISION, MomsRazor.OnCollision, FamiliarVariant.MOMS_RAZOR)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_KILL_NPC, MomsRazor.OnKillNpc, FamiliarVariant.MOMS_RAZOR, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)