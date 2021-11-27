local Incubus = { }

Incubus.Stats = {
    DamageMultiplier = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 4 / 3,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 5 / 3,
    }
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.INCUBUS, CollectibleType.COLLECTIBLE_INCUBUS)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.INCUBUS,
    "{{ArrowUp}} Damage Up",
    "{{ArrowUp}} Damage Up", nil, "Incubus"
)

function Incubus:OnEntityTakeDamage(familiar, entity, amount, flags, source, countdown)
    if source == nil then return end
    if source.Entity == nil then return end
    if source.Entity.SpawnerEntity == nil then return end
    if flags & DamageFlag.DAMAGE_CLONES == DamageFlag.DAMAGE_CLONES then return end
    if GetPtrHash(familiar) == GetPtrHash(source.Entity.SpawnerEntity) then
        local level = Sewn_API:GetLevel(familiar:GetData())
        entity:TakeDamage(amount * Incubus.Stats.DamageMultiplier[level], flags | DamageFlag.DAMAGE_CLONES, source, countdown)
		return false
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.ENTITY_TAKE_DAMAGE, Incubus.OnEntityTakeDamage, FamiliarVariant.INCUBUS)