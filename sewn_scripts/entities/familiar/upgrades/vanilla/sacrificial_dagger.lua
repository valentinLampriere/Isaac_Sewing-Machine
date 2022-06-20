local SacrificialDagger = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.SACRIFICIAL_DAGGER, CollectibleType.COLLECTIBLE_SACRIFICIAL_DAGGER)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.SACRIFICIAL_DAGGER,
    "Applies a bleed effect#{{ArrowUp}} Small Damage Up",
    "{{ArrowUp}} Damage Up", nil, "Sacrificial Dagger"
)

Sewn_API:AddEncyclopediaUpgrade(
    FamiliarVariant.SACRIFICIAL_DAGGER,
    "Applies a bleed effect#Small damage Up (+1 dmg)",
    "Damage up (+4 dmg)"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.SACRIFICIAL_DAGGER,
    "额外造成流血效果 #{{ArrowUp}} 攻击小幅提升",
    "{{ArrowUp}} 攻击提升", nil, "Sacrificial Dagger","zh_cn"
)

SacrificialDagger.Stats = {
    DamageBonus = {
        [Sewn_API.Enums.FamiliarLevel.SUPER] = 1,
        [Sewn_API.Enums.FamiliarLevel.ULTRA] = 4
    }
}

function SacrificialDagger:OnFamiliarHitNpc(familiar, npc, amount, flags, source, countdown)
    if npc:IsVulnerableEnemy() then
        if not npc:IsBoss() then
            npc:AddEntityFlags(EntityFlag.FLAG_BLEED_OUT)
        end
        npc:TakeDamage(SacrificialDagger.Stats.DamageBonus[Sewn_API:GetLevel(familiar:GetData())], DamageFlag.DAMAGE_CLONES, EntityRef(familiar), countdown)
    end
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.FAMILIAR_HIT_NPC, SacrificialDagger.OnFamiliarHitNpc, FamiliarVariant.SACRIFICIAL_DAGGER)