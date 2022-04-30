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
    HeartDropChance = 10
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.MOMS_RAZOR, CollectibleType.COLLECTIBLE_MOMS_RAZOR)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.MOMS_RAZOR,
    "{{ArrowUp}} Extends the Bleed duration. Bosses are not affected.",
    "When it kills an enemy either from contact damage or bleed, spawn a large blood puddle. Also have a chance to spawn half a heart.#{{ArrowUp}} Extends the Bleed duration", nil, "Mom's Razor"
)

local function OnKillNpc(familiar, npc)
    local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_LEMON_MISHAP, 0, npc.Position, Globals.V0, familiar):ToEffect()
    creep:SetColor(CColor(0.627, 0, 0), -1, 1, false, false)
    creep.CollisionDamage = 3
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