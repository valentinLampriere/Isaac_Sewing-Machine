local Globals = require("sewn_scripts.core.globals")
local CColor = require("sewn_scripts.helpers.ccolor")

local BobsBrain = { }

BobsBrain.Stats = {
    
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.BOBS_BRAIN, CollectibleType.COLLECTIBLE_BOBS_BRAIN)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BOBS_BRAIN,
    "Spawn a large green creep when it explodes",
    "Sticks to enemies before exploding", nil, "Bob's Brain"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BOBS_BRAIN,
    "爆炸时额外产生一滩巨大的绿毒水迹",
    "接触敌人不会立即爆炸，而是将黏在敌人上一段时间后再爆炸", nil, "Bob's Brain", "zh_cn"
)

function BobsBrain:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()
    if familiar.FireCooldown > 30 and fData.Sewn_crown_hide == true then
        Sewn_API:HideCrown(familiar, false)
    end
    if familiar.State == 1 then -- It explode
        local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_GREEN, 0, familiar.Position, Globals.V0, familiar):ToEffect()
        creep.Size = 3
        creep.SpriteScale = Vector(3, 3)
        creep.Timeout = 50
        creep:SetColor(CColor(0, 0, 0, 1, 0, 0.25, 0), -1, 0, false, false)
        Sewn_API:HideCrown(familiar, true)
    end
end


local function GetBack(bobsBrain)
    local fData = bobsBrain:GetData()
    local sprite = bobsBrain:GetSprite()
    bobsBrain.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ENEMIES
    -- Remove Slowing effect
    fData.Sewn_bobsBrain_stickNpc:ClearEntityFlags(EntityFlag.FLAG_SLOW)
    fData.Sewn_bobsBrain_stickNpc = nil
    fData.Sewn_bobsBrain_stickDistance = nil
    fData.Sewn_bobsBrain_stickFrame = nil
    bobsBrain.FireCooldown = 0
    
    sprite:Play("Float")
    sprite.PlaybackSpeed = 1
end

function BobsBrain:OnFamiliarUpdate_Ultra(familiar)
    local fData = familiar:GetData()
    local sprite = familiar:GetSprite()
    
    --Remove bob's brain collision so it do no more hit enemies
    familiar.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE

    -- If the brain has been thrown (and it is not sticked to an enemy)
    if familiar.FireCooldown == -1 and fData.Sewn_bobsBrain_stickNpc == nil then
        local npcs = Isaac.FindInRadius(familiar.Position, familiar.Size - 5, EntityPartition.ENEMY)
        for _, npc in ipairs(npcs) do
            if npc:IsVulnerableEnemy() then
                fData.Sewn_bobsBrain_stickNpc = npc
                fData.Sewn_bobsBrain_stickDistance = familiar.Position - npc.Position
                fData.Sewn_bobsBrain_stickFrame = familiar.FrameCount
                sprite:Play("Stick")
                
                npc:AddEntityFlags(EntityFlag.FLAG_SLOW)
            end
        end
    end

    if fData.Sewn_bobsBrain_stickNpc ~= nil then
        familiar.Velocity = Globals.V0
        familiar.Position = fData.Sewn_bobsBrain_stickNpc.Position + fData.Sewn_bobsBrain_stickDistance
        if fData.Sewn_bobsBrain_stickFrame + 30 < familiar.FrameCount then
            sprite.PlaybackSpeed = 1.5
            if fData.Sewn_bobsBrain_stickFrame + 60 < familiar.FrameCount then
                sprite.PlaybackSpeed = 2
                if fData.Sewn_bobsBrain_stickFrame + 90 < familiar.FrameCount then
                    -- Add velocity, so it move against the enemy to explode
                    familiar:AddVelocity(-fData.Sewn_bobsBrain_stickDistance)
                    GetBack(familiar)
                end
            end
        end
        
        -- If the enemy where the brain sticks is dead before it explodes, or if the enemy jumps
        if fData.Sewn_bobsBrain_stickNpc ~= nil and (fData.Sewn_bobsBrain_stickNpc:IsDead() or not fData.Sewn_bobsBrain_stickNpc:Exists() or fData.Sewn_bobsBrain_stickNpc.EntityCollisionClass == EntityCollisionClass.ENTCOLL_NONE) then
            GetBack(familiar)
        end
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, BobsBrain.OnFamiliarUpdate, FamiliarVariant.BOBS_BRAIN)

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, BobsBrain.OnFamiliarUpdate_Ultra, FamiliarVariant.BOBS_BRAIN, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)