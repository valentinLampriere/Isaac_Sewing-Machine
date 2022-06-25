local Random = require("sewn_scripts.helpers.random")
local Delay = require("sewn_scripts.helpers.delay")
local FindCloserNpc = require("sewn_scripts.helpers.find_closer_npc")
local IsSpawnedBy = require("sewn_scripts.helpers.is_spawned_by")

local PapaFly = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.PAPA_FLY, CollectibleType.COLLECTIBLE_PAPA_FLY)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.PAPA_FLY,
    "Blocks projectiles#Has a chance to spawn a fly turret when blocking a projectile",
    "Fires 5 tears in a row#{{ArrowUp}} Range Up#Higher chance to spawn a fly turret", nil, "Papa Fly"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.PAPA_FLY,
    "可以阻挡弹幕 #阻挡弹幕时有几率生成一个 {{Collectible504}} 棕色粪块生成的棕色金块跟班（苍蝇炮塔）",
    "一次发射5颗眼泪 #{{ArrowUp}} 射程增加 #更高的概率生成一个 {{Collectible504}} 棕色粪块生成的棕色金块跟班（苍蝇炮塔）", nil, "狙击蝇老爹","zh_cn"
)

PapaFly.Stats = {
    ChanceBrownNugget = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 20,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 33
    },
    RangeBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = -0.1
    },
    ShotSpeed = 10,
    RangeDetection = 150,
    DelayBetweenTears = 2,
    AmountOfAdditionalTears = 5,
    MaxAmountOfNuggetPooter = 10,
}

local function TryToShootAdditionalTear(familiar, tear)
    local closerNpc = FindCloserNpc(familiar.Position, PapaFly.Stats.RangeDetection)

    if closerNpc ~= nil then
        local direction = ((closerNpc.Position + closerNpc.Velocity * 2) - familiar.Position):Normalized()
        local newTear = Isaac.Spawn(tear.Type, tear.Variant, tear.SubType, familiar.Position, direction * PapaFly.Stats.ShotSpeed, familiar):ToTear()
        newTear:GetData().Sewn_papaFly_isAdditionalTear = true
        newTear.CollisionDamage = tear.CollisionDamage
        newTear.Height = tear.Height
        newTear.FallingSpeed = tear.FallingSpeed
        newTear.FallingAcceleration = tear.FallingAcceleration
    end
end

function PapaFly:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()
    local level = Sewn_API:GetLevel(fData)
    for _, bullet in pairs(Isaac.FindInRadius(familiar.Position, familiar.Size, EntityPartition.BULLET)) do
        if Random:CheckRoll(PapaFly.Stats.ChanceBrownNugget[level]) then

            if #fData.Sewn_papaFly_nuggetPooterTracker >= PapaFly.Stats.MaxAmountOfNuggetPooter then
                fData.Sewn_papaFly_nuggetPooterTracker[1]:Remove()
                table.remove(fData.Sewn_papaFly_nuggetPooterTracker, 1)
            end

            -- Spawn a Nugget Pooter
            familiar.Player:UseActiveItem(CollectibleType.COLLECTIBLE_BROWN_NUGGET, false, false, false, false)
            
            -- Set the position to the Papa Fly position
            for _, nuggetPooter in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BROWN_NUGGET_POOTER, -1, false, false)) do
                if nuggetPooter.FrameCount == 0 then
                    nuggetPooter.Position = familiar.Position
                    table.insert(fData.Sewn_papaFly_nuggetPooterTracker, nuggetPooter)
                end
            end
        end
        
        bullet:Die()
    end
end
function PapaFly:OnNewRoom(familiar)
    local fData = familiar:GetData()
    fData.Sewn_papaFly_nuggetPooterTracker = { }
end
function PapaFly:OnPlayAnim(familiar, sprite)
    if sprite:GetFrame() > 5 then
        local fData = familiar:GetData()
        local level = Sewn_API:GetLevel(fData)
        for _, tear in pairs(Isaac.FindInRadius(familiar.Position, familiar.Size, EntityPartition.TEAR)) do
            local tData = tear:GetData()
            tear = tear:ToTear()
            tear.FallingAcceleration = PapaFly.Stats.RangeBonus[level]

            if tData.Sewn_papaFly_isAdditionalTear == nil and IsSpawnedBy(tear, familiar) then

                for i = 1, PapaFly.Stats.AmountOfAdditionalTears do
                    Delay:DelayFunction(TryToShootAdditionalTear, PapaFly.Stats.DelayBetweenTears * i, true, familiar, tear)
                end
            end
            tData.Sewn_papaFly_isAdditionalTear = true
        end
    end
end

function PapaFly:OnUpgraded(familiar, isPermanentUpgrade)
    local fData = familiar:GetData()
    fData.Sewn_papaFly_nuggetPooterTracker = { }
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, PapaFly.OnFamiliarUpdate, FamiliarVariant.PAPA_FLY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_PLAY_ANIM, PapaFly.OnPlayAnim, FamiliarVariant.PAPA_FLY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA, "Attack")
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_NEW_ROOM, PapaFly.OnNewRoom, FamiliarVariant.PAPA_FLY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, PapaFly.OnUpgraded, FamiliarVariant.PAPA_FLY)
