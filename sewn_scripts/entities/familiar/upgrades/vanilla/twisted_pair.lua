local TwistedPair = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.TWISTED_BABY, CollectibleType.COLLECTIBLE_TWISTED_PAIR)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.TWISTED_BABY,
    "{{ArrowUp}}+0.33 Flat Damage Up#They move closer to the player while they fire",
    "They align with the player's direction", nil, "Twisted Pair"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.TWISTED_BABY,
    "与角色之间的距离靠的更近 #+0.33攻击",
    "眼泪弹道将和玩家射击的方向一致", nil, "作孽双子","zh_cn"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.TWISTED_BABY,
    nil,
    "Align with the player's direction#Slight damage up. +0.33 when the damage is less than 2, +0.5 when the damage is higher than 2",
    "Due to API limitation, the damage bonus do not works with every weapon type (Lasers, bombs)"
)

TwistedPair.Stats = {
    PlayerMinDistance = 15,
    MoveToPlayerEveryXFrame = 12,
    DamageBonusHigh = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0.33,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 0.5
    },
    DamageBonusLow = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 0.33,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 0.33
    }
}

local function GetFindTwin(familiar)
    local fData = familiar:GetData()
    if fData.Sewn_twistedPair_twin ~= nil and fData.Sewn_twistedPair_twin:Exists() then
        return fData.Sewn_twistedPair_twin
    end
    local twistedPairs = Isaac.FindByType(familiar.Type, familiar.Variant, familiar.SubType == 0 and 1 or 0, false, false)
    for _, twistedPair in ipairs(twistedPairs) do
        if twistedPair.FrameCount == familiar.FrameCount then
            return twistedPair
        end
    end
end
function TwistedPair:OnInit(familiar)
    local fData = familiar:GetData()
    if familiar.SubType == 1 then
        fData.Sewn_noUpgrade = Sewn_API.Enums.NoUpgrade.ANY
    end
    fData.Sewn_twistedPair_playerFireCounter = 0
    fData.Sewn_twistedPair_twistedIndex = familiar.Player:GetCollectibleNum(CollectibleType.COLLECTIBLE_TWISTED_PAIR)
end

function TwistedPair:OnUpgraded_OnLoseUpgrade(familiar, losePermanentUpgrade)
    if familiar.SubType == 1 then return end
    local fData = familiar:GetData()
    local _fData = GetFindTwin(familiar):GetData()
    _fData.Sewn_upgradeLevel = fData.Sewn_upgradeLevel
    _fData.Sewn_upgradeLevel_temporary = fData.Sewn_upgradeLevel_temporary
end

function TwistedPair:OnAddToMachine(familiar, machine)
    if familiar.SubType == 1 then return end
    GetFindTwin(familiar):Remove()
end
function TwistedPair:OnGetFromMachine(familiar, player, machine, isUpgraded, newLevel)
    if familiar.SubType == 1 then return end
    local fData = familiar:GetData()
    fData.Sewn_twistedPair_twin = Isaac.Spawn(familiar.Type, familiar.Variant, 1, familiar.Position, familiar.Velocity, player):ToFamiliar()
    local _fData = fData.Sewn_twistedPair_twin:GetData()
    _fData.Sewn_upgradeLevel = newLevel
end

local function GetTwistedPairTargetPosition(familiar, flip)
    local fData = familiar:GetData()
    local defaultOffset = 26 - fData.Sewn_twistedPair_playerFireCounter
    if defaultOffset < TwistedPair.Stats.PlayerMinDistance then
        defaultOffset = TwistedPair.Stats.PlayerMinDistance
    end
    local offset = defaultOffset * fData.Sewn_twistedPair_twistedIndex

    local vectorInput = familiar.Player:GetShootingInput()
    local offsetVector = Vector(0, 0)
    if vectorInput.X > 0 then
        if flip then
            offsetVector.X = familiar.SubType == 0 and 1 or -1
        else
            offsetVector.Y = familiar.SubType == 0 and -1 or 1
        end
    elseif vectorInput.X < 0 then
        if flip then
            offsetVector.X = familiar.SubType == 0 and -1 or 1
        else
            offsetVector.Y = familiar.SubType == 0 and 1 or -1
        end
    end
    if vectorInput.Y > 0 then
        if flip then
            offsetVector.Y = familiar.SubType == 0 and 1 or -1
        else
            offsetVector.X = familiar.SubType == 0 and 1 or -1
        end
    elseif vectorInput.Y < 0 then
        if flip then
            offsetVector.Y = familiar.SubType == 0 and -1 or 1
        else
            offsetVector.X = familiar.SubType == 0 and -1 or 1
        end
    end
    return familiar.Player.Position + offsetVector:Normalized() * offset
end

function TwistedPair:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()
    if familiar.Player:GetShootingInput():LengthSquared() > 0 then
        familiar.Velocity = (GetTwistedPairTargetPosition(familiar, Sewn_API:IsUltra(fData)) - familiar.Position) * 0.5
        
        if familiar.FrameCount % TwistedPair.Stats.MoveToPlayerEveryXFrame == 0 then
            fData.Sewn_twistedPair_playerFireCounter = fData.Sewn_twistedPair_playerFireCounter + 1
        end
    else
        if fData.Sewn_twistedPair_playerFireCounter > 0 then
            fData.Sewn_twistedPair_playerFireCounter = 0
        end
    end
end

function TwistedPair:OnEntityTakeDamage(familiar, entity, amount, flags, source, countdown)
    if source == nil then return end
    if source.Entity == nil then return end
    if source.Entity.SpawnerEntity == nil then return end
    if flags & DamageFlag.DAMAGE_CLONES == DamageFlag.DAMAGE_CLONES then return end
    if GetPtrHash(familiar) == GetPtrHash(source.Entity.SpawnerEntity) then
        local level = Sewn_API:GetLevel(familiar:GetData())
        if amount > 2 then
            entity:TakeDamage(amount + TwistedPair.Stats.DamageBonusHigh[level], flags | DamageFlag.DAMAGE_CLONES, source, countdown)
        else
            entity:TakeDamage(amount + TwistedPair.Stats.DamageBonusLow[level], flags | DamageFlag.DAMAGE_CLONES, source, countdown)
        end
		return false
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_INIT, TwistedPair.OnInit, FamiliarVariant.TWISTED_BABY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ANY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.PRE_ADD_FAMILIAR_IN_SEWING_MACHINE, TwistedPair.OnAddToMachine, FamiliarVariant.TWISTED_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_GET_FAMILIAR_FROM_SEWING_MACHINE, TwistedPair.OnGetFromMachine, FamiliarVariant.TWISTED_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, TwistedPair.OnUpgraded_OnLoseUpgrade, FamiliarVariant.TWISTED_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_LOSE_UPGRADE, TwistedPair.OnUpgraded_OnLoseUpgrade, FamiliarVariant.TWISTED_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, TwistedPair.OnFamiliarUpdate, FamiliarVariant.TWISTED_BABY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ENTITY_TAKE_DAMAGE, TwistedPair.OnEntityTakeDamage, FamiliarVariant.TWISTED_BABY)