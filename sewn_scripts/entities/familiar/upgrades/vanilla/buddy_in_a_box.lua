local BuddyInABox = { }

Sewn_API:MakeFamiliarAvailable(FamiliarVariant.BUDDY_IN_A_BOX, CollectibleType.COLLECTIBLE_BUDDY_IN_A_BOX)

Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BUDDY_IN_A_BOX,
    "Gains a random additional tear effect#Additional tear effect can't be Ipecac unless Ipecac is the base attack of the buddy",
    "Gains another random additional tear effect", nil, "Buddy in a Box"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BUDDY_IN_A_BOX,
    "额外获得一个盲盒宝宝的眼泪效果 ",
    "额外再获得一个盲盒宝宝的眼泪效果", nil, "伙伴盲盒", "zh_cn"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BUDDY_IN_A_BOX,
    "Получает случайный дополнительный эффект слёз#Дополнительным эффектом не может быть Ипекак, если изначальный эффект слёз не Ипекак",
    "Получает ещё один случайный дополнительный эффект слёз", nil, "Друг в Коробке", "ru"
)
Sewn_API:AddFamiliarDescription(
    FamiliarVariant.BUDDY_IN_A_BOX,
    "Obtient un nouvel effet de larme aléatoire#L'effet de larme ne peut pas être Ipéca (sauf si Ipéca est l'effet de base du familier)",
    "Obtient de nouveau un effet de larme aléatoire", nil, "Pote en boîte", "fr"
)

local function AddAdditionalTearFlags(tear, amountTearFlags, rng)
    local maxFlag = REPENTANCE and 81 or 60

    for i = 1, amountTearFlags do
        local rollTearFlag
        repeat
            rollTearFlag = rng:RandomInt(maxFlag)
        until (1<<rollTearFlag & TearFlags.TEAR_EXPLOSIVE <= 0)
        tear.TearFlags = tear.TearFlags | 1<<rollTearFlag
    end
end

function BuddyInABox:OnFamiliarFireTear_Super(familiar, tear)
    AddAdditionalTearFlags(tear, 1, familiar:GetDropRNG())
end
function BuddyInABox:OnFamiliarFireTear_Ultra(familiar, tear)
    AddAdditionalTearFlags(tear, 2, familiar:GetDropRNG())
end

Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, BuddyInABox.OnFamiliarFireTear_Super, FamiliarVariant.BUDDY_IN_A_BOX, Sewn_API.Enums.FamiliarLevelFlag.FLAG_SUPER)
Sewn_API:AddCallback(Sewn_API.Enums.ModCallbacks.POST_FAMILIAR_FIRE_TEAR, BuddyInABox.OnFamiliarFireTear_Ultra, FamiliarVariant.BUDDY_IN_A_BOX, Sewn_API.Enums.FamiliarLevelFlag.FLAG_ULTRA)