local LittleChubby = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.LITTLE_CHUBBY, CollectibleType.COLLECTIBLE_LITTLE_CHUBBY)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.LITTLE_CHUBBY,
    "{{ArrowUp}} Lower cooldown by 50%, can be thrown quickly",
    "Sticks to enemies for 0.5 seconds then continues in its initial direction", nil, "Little Chubby"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.LITTLE_CHUBBY,
    "冷却时间减少 50% ，可以被更快扔出",
    "接触到敌人时将会附着在敌人身上持续造成伤害0.5秒，然后继续向前行进", nil, "小胖蛆","zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.LITTLE_CHUBBY,
    "{{ArrowUp}} Задержка -2х, может быть брошен быстро",
    "Прилипает к врагам на 0.5 секунды, а потом продолжает лететь в первоначальном направлении", nil, "Маленький Чабби", "ru"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.LITTLE_CHUBBY,
    "{{ArrowUp}} Réduit le temps de recharge de 50% (Peut être lancé plus souvent)",
    "S'arrête pendant 1/2 seconde sur les ennemis qu'il croise", nil, "P'tit Dodu", "fr"
)

function LittleChubby:OnFamiliarUpdate(familiar)
    if familiar.FireCooldown < -1 then
        familiar.FireCooldown = 15
    end
end
function LittleChubby:OnFamiliarUpgraded_Ultra(familiar, isPermanentUpgrade)
    local fData = familiar:GetData()
    fData.Sewn_littleChubby_stickCooldown = 0
    fData.Sewn_littleChubby_lastStickCooldown = 0
end
function LittleChubby:OnFamiliarUpdate_Ultra(familiar)
    local fData = familiar:GetData()
    if familiar.FireCooldown == -1 and fData.Sewn_littleChubby_stickNpc == nil then
        local npcs = Isaac.FindInRadius(familiar.Position, familiar.Size - 2, EntityPartition.ENEMY)
        for _, npc in ipairs(npcs) do
            if npc:IsVulnerableEnemy() and fData.Sewn_littleChubby_lastStickCooldown == 0 then
                fData.Sewn_littleChubby_stickNpc = npc
                fData.Sewn_littleChubby_stickDistance = familiar.Position - npc.Position
                fData.Sewn_littleChubby_stickCooldown = 15
                fData.Sewn_littleChubby_initialVelocity = familiar.Velocity
            end
        end
    end
    -- if little chubby is stick to an enemy
    if fData.Sewn_littleChubby_stickNpc ~= nil then
        -- Really small velocity, so little chubby does not move, but keep his direction
        familiar.Velocity = fData.Sewn_littleChubby_initialVelocity * 0.01
        familiar.Position = fData.Sewn_littleChubby_stickNpc.Position + fData.Sewn_littleChubby_stickDistance
        
        -- Un-Stick the enemy after half a second, or if the enemy died
        if fData.Sewn_littleChubby_stickCooldown == 0 or
           fData.Sewn_littleChubby_stickNpc and (fData.Sewn_littleChubby_stickNpc:IsDead() or fData.Sewn_littleChubby_stickNpc.EntityCollisionClass == EntityCollisionClass.ENTCOLL_NONE) then
            fData.Sewn_littleChubby_stickNpc = nil
            
            -- Continue his path
            familiar.FireCooldown = -1
            familiar.Velocity = fData.Sewn_littleChubby_initialVelocity
            fData.Sewn_littleChubby_lastStickCooldown = 15
        end
    end
    if fData.Sewn_littleChubby_stickCooldown > 0 then
        fData.Sewn_littleChubby_stickCooldown = fData.Sewn_littleChubby_stickCooldown - 1
    end
    if fData.Sewn_littleChubby_lastStickCooldown > 0 then
        fData.Sewn_littleChubby_lastStickCooldown = fData.Sewn_littleChubby_lastStickCooldown - 1
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, LittleChubby.OnFamiliarUpdate, FamiliarVariant.LITTLE_CHUBBY)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ON_FAMILIAR_UPGRADED, LittleChubby.OnFamiliarUpgraded_Ultra, FamiliarVariant.LITTLE_CHUBBY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_UPDATE, LittleChubby.OnFamiliarUpdate_Ultra, FamiliarVariant.LITTLE_CHUBBY, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)