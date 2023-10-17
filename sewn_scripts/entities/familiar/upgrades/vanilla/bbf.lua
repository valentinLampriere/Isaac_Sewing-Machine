local BBF = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.BBF, CollectibleType.COLLECTIBLE_BBF)

BBF.Stats = {
    ExplosionDamageBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 75,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 75,
    },
    UnsafeZoneRange = 55
}

function BBF:OnFamiliarUpdate(familiar)
    local fData = familiar:GetData()

    if fData.Sewn_bff_isVisible == true and familiar.Visible == false then
        Sewn_API:HideCrown(familiar, true)
    elseif fData.Sewn_bff_isVisible == false and familiar.Visible == true then
        Sewn_API:HideCrown(familiar, false)
    end
end

function BBF:OnFamiliarHitNpc(familiar, npc, amount, flags, source, countdown)
    local fData = familiar:GetData()

    if flags & DamageFlag.DAMAGE_EXPLOSION == DamageFlag.DAMAGE_EXPLOSION then
        if fData.Sewn_bff_preventNextExplosion ~= nil then
            return
        end

        local level = Sewn_API:GetLevel(fData)
        local additionalDamage = BBF.Stats.ExplosionDamageBonus[level]

        fData.Sewn_bff_preventNextExplosion = true
        Isaac.Explode(familiar.Position, familiar, amount + additionalDamage)
        fData.Sewn_bff_preventNextExplosion = nil
        return false
    end
end

function BBF:OnPlayerTakesDamage(familiar, player, damageFlag, entityRef)
    if entityRef ~= nil and GetPtrHash(entityRef.Entity) == GetPtrHash(familiar) then
        if (player.Position - familiar.Position):LengthSquared() >= BBF.Stats.UnsafeZoneRange ^ 2 then
            return false
        end
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, BBF.OnFamiliarUpdate, FamiliarVariant.BBF)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_HIT_NPC, BBF.OnFamiliarHitNpc, FamiliarVariant.BBF)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_PLAYER_TAKE_DAMAGE, BBF.OnPlayerTakesDamage, FamiliarVariant.BBF, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)