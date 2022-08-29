local Incubus = { }

Incubus.Stats = {
    DamageMultiplier = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 4 / 3,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 5 / 3,
    }
}

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.INCUBUS, CollectibleType.COLLECTIBLE_INCUBUS)

-- Sewn_API:AddFamiliarDescription(
--     FamiliarVariant.INCUBUS,
--     "{{ArrowUp}} Damage Up",
--     "{{ArrowUp}} Damage Up", nil, "Incubus"
-- )
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.INCUBUS,
    "{{ArrowUp}} 攻击提升 #[REP] : 现在造成与玩家相同的伤害",
    "{{ArrowUp}} 攻击大幅提升", nil, "淫魔","zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.INCUBUS,
    "{{ArrowUp}} Урон +",
    "{{ArrowUp}} Урон +", nil, "Инкуб", "ru"
)
-- Sewn_API:AddFamiliarDescription(
--     FamiliarVariant.INCUBUS,
--     "{{ArrowUp}} Dégâts",
--     "{{ArrowUp}} Dégâts", nil, "Incubus", "fr"
-- )
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.INCUBUS,
    "{{ArrowUp}} + Daño",
    "{{ArrowUp}} + Daño", nil, "Íncubo", "spa"
)

-- Sewn_API:AddEncyclopediaUpgrade(
--     FamiliarVariant.INCUBUS,
--     "Damage Up (x1.33)#[REP] : Now deal the same amount of damage as the player",
--     "Damage Up (x1.67)",
--     "Due to API limitation, the damage bonus do not works with every weapon type (Lasers, bombs)#Lilith's Incubus can't be upgraded in Sewing Machines because Lilith's without her Incubus can't fight. It can still be upgraded with Sewing Box"
-- )

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