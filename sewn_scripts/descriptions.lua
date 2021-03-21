sewingMachineMod.FamiliarsUpgradeDescriptions = {}
sewingMachineMod.IsEidDescriptionLoaded = false

local function ConvertRGBToIsaac(color)
    return {color[1]/255, color[2]/255, color[3]/255}
end

function sewingMachineMod:GetInfoForFamiliar(familiarVariant)
    return sewingMachineMod.FamiliarsUpgradeDescriptions[familiarVariant] or false
end

function sewingMachineMod:AddDescriptionsForFamiliar(familiarVariant, firstUpgrade, secondUpgrade, color, optionalName)
    local kColor
    local name
    if optionalName ~= nil then
        name = optionalName
    else
        local collectible = Isaac.GetItemConfig():GetCollectible(sewingMachineMod.availableFamiliar[familiarVariant][1])
        if collectible ~= nil then
            name = collectible.Name
        end
    end
    
    if color ~= nil then
        kColor = {color[1], color[2], color[3]}
    else
        kColor = {1, 1, 1}
    end
    if sewingMachineMod.Config.EID_textColored == false then
        kColor = {1, 1, 1}
    end

    if EID ~= nil then
        EID:addColor("SewnColor_".. name, KColor(kColor[1], kColor[2], kColor[3], 1))
    end

    sewingMachineMod.FamiliarsUpgradeDescriptions[familiarVariant] = {
        name = name,
        firstUpgrade = firstUpgrade,
        secondUpgrade = secondUpgrade,
        color = kColor
    }

    if Encyclopedia ~= nil then
        sewingMachineMod:SetEncyclopedia(sewingMachineMod.availableFamiliar[familiarVariant][1], familiarVariant)
    end
end

function sewingMachineMod:InitFamiliarDescription()
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.BROTHER_BOBBY,
        "{{ArrowUp}} Damage Up (x2)",
        "{{ArrowUp}} Damage Up#{{ArrowUp}} Tears Up",
        ConvertRGBToIsaac({139, 145, 181})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.SISTER_MAGGY,
        "{{ArrowUp}} Tears Up",
        "{{ArrowUp}} Tears Up#{{ArrowUp}} Damage Up",
        ConvertRGBToIsaac({203, 0, 0})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.GHOST_BABY,
        "Gain piercing Pupula tears#{{ArrowUp}} Slight Damage Up",
        "Tears are larger#{{ArrowUp}} Damage Up",
        ConvertRGBToIsaac({255, 255, 255})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.ROBO_BABY,
        "{{ArrowUp}} Tears Up",
        "{{ArrowUp}} Tears Up",
        ConvertRGBToIsaac({219, 219, 239})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.LITTLE_GISH,
        "Tears create a puddle of creep on hit#{{ArrowUp}} Slight Tears Up",
        "Larger creep#{{ArrowUp}} Tears Up",
        ConvertRGBToIsaac({67, 67, 67})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.SERAPHIM,
        "Have a chance to fire Holy Tears",
        "Higher chance to fire Holy Tears#{{ArrowUp}} Slight Tears Up",
        ConvertRGBToIsaac({227, 198, 197})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.HARLEQUIN_BABY,
        "Fire an additional shot on each sides",
        "{{ArrowUp}} Damage Up",
        ConvertRGBToIsaac({202, 158, 158})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.LIL_LOKI,
        "Fire in 8 directions",
        "{{ArrowUp}} Damage Up",
        ConvertRGBToIsaac({203, 0, 0})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.BUDDY_IN_A_BOX,
        "Gain a random additional tear effect#Additional tear effect can't be Ipecac unless Ipecac is the base attack of the buddy#{{ArrowUp}} Slight Tears Up",
        "Gain an other random additional tear effect#{{ArrowUp}} Slight Tears Up"
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.RAINBOW_BABY,
        "{{ArrowUp}} Tears Up",
        "{{ArrowUp}} Tears Up",
        ConvertRGBToIsaac({244, 69, 173})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.LITTLE_STEVEN,
        "{{ArrowUp}} Range Up#{{ArrowDown}} Shot Speed Down#{{ArrowUp}} Damage Up",
        "{{ArrowUp}} Range Up#{{ArrowDown}} Shot Speed Down#{{ArrowUp}} Damage Up#{{ArrowUp}} Tears Up",
        ConvertRGBToIsaac({8, 0, 0})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.HEADLESS_BABY,
        "Spawn large creep#{{ArrowUp}} Creep deal more damage",
        "Fire burst of tears while isaac is firing#{{ArrowUp}} Creep deal more damage",
        ConvertRGBToIsaac({205, 196, 209})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.ROBO_BABY_2,
        "Fire a short laser in front of him while moving",
        "Sometimes follows ennemies",
        ConvertRGBToIsaac({151, 151, 151})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.FATES_REWARD,
        "{{ArrowUp}} Tears Up#{{ArrowUp}} Slight Damage Up",
        "Fire rate scale with player fire rate",
        ConvertRGBToIsaac({87, 135, 231})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.MONGO_BABY,
        "{{SewnCrownSuper}} Copy Super upgrade",
        "{{SewnCrownUltra}} Copy Ultra upgrade",
        ConvertRGBToIsaac({223, 182, 178})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.LIL_BRIMSTONE,
        "{{ArrowUp}} Damage Up",
        "Laser last longer",
        ConvertRGBToIsaac({135, 135, 135})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.LIL_MONSTRO,
        "Have a chance to fire a tooth#Tooth deal 3.2 normal damage",
        "Fire way more tears",
        ConvertRGBToIsaac({224, 196, 196})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.DEMON_BABY,
        "Fire automatically through walls",
        "{{ArrowUp}} Higher Range",
        ConvertRGBToIsaac({45, 45, 45})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.ABEL,
        "{{ArrowUp}} Damage Up#Block projectiles",
        "Deal collision damage#Amount of damage scale with the distance with the player",
        ConvertRGBToIsaac({227, 198, 197})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.SACRIFICIAL_DAGGER,
        "Apply bleed effect",
        "{{ArrowUp}}  Damage Up",
        ConvertRGBToIsaac({193, 189, 207})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.GUARDIAN_ANGEL,
        "Can increase damage of tears which go through it#Each projectile he block increase how much he increase damage from tears",
        "Each time it block a projectile, it has a chance to reflect it back",
        ConvertRGBToIsaac({227, 198, 197})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.SWORN_PROTECTOR,
        "Has a chance to spawn half a soul heart {{HalfSoulHeart}} when blocking a projectile",
        "Every few projectile blocked, it fire 4 lasers in four directions",
        ConvertRGBToIsaac({227, 198, 197})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.BLOODSHOT_EYE,
        "Fire 3 tears#Each tears deal 5 damage",
        "Fire a blood laser instead of tears",
        ConvertRGBToIsaac({218, 103, 103})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.BOBS_BRAIN,
        "Spawn a large green creep when it explodes",
        "Sticks to enemies before exploding",
        ConvertRGBToIsaac({71, 135, 51})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.LIL_GURDY,
        "Fire 3 waves of tears in different directions after dashing",
        "When it dash, it leaves creep",
        ConvertRGBToIsaac({227, 198, 197})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.ROTTEN_BABY,
        "Spawn an additional spider",
        "Spawn an additional locust#{{Warning}} Can be red locust",
        ConvertRGBToIsaac({119, 179, 103})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.JUICY_SACK,
        "Large creep",
        "Fire some egg tears while isaac is firing#Egg tears spawn blue fly or blue spider on hit",
        ConvertRGBToIsaac({255, 255, 255})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.SISSY_LONGLEGS,
        "Spawn 2 spiders",
        "Spawn 3 spiders",
        ConvertRGBToIsaac({87, 135, 231})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.LITTLE_CHAD,
        "Has 33% chance to spawn a full red heart {{Heart}}",
        "Has 33% chance to spawn half a soul heart {{HalfSoulHeart}}",
        ConvertRGBToIsaac({254, 0, 0})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.FARTING_BABY,
        "Randomly farts",
        "Farts more often#Can fart \"Burning Fart\"",
        ConvertRGBToIsaac({180, 146, 104})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.CENSER,
        "Sometimes apply a dazed effect or freeze effect",
        "Slighly deflect tears from player similar to the Soul item {{Collectible".. CollectibleType.COLLECTIBLE_SOUL .."}}",
        ConvertRGBToIsaac({204, 204, 204})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.PEEPER,
        "Fire 5 tears in differents directions every few seconds",
        "Spawn an additional Peeper Eye {{Collectible".. CollectibleType.COLLECTIBLE_PEEPER .."}}#New peeper eye spawn Ultra {{SewnCrownUltra}}",
        ConvertRGBToIsaac({204, 204, 204})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.KING_BABY,
        "While charging, the player gain a copy of his followers#Damage from copy of familiars are reduced",
        "Copy of familiars fire with full damage",
        ConvertRGBToIsaac({58, 81, 134})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.DISTANT_ADMIRATION,
        "{{ArrowUp}} Contact damage up#Damage scale with player damage",
        "{{ArrowUp}} Contact damage up#Damage scale with player damage",
        ConvertRGBToIsaac({203, 0, 0})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.FOREVER_ALONE,
        "{{ArrowUp}} Contact damage up#Damage scale with player damage",
        "{{ArrowUp}} Contact damage up#Damage scale with player damage",
        ConvertRGBToIsaac({51, 95, 179})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.FRIEND_ZONE,
        "{{ArrowUp}} Contact damage up#Damage scale with player damage",
        "{{ArrowUp}} Contact damage up#Damage scale with player damage"
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.OBSESSED_FAN,
        "{{ArrowUp}} Contact damage up#Damage scale with player damage",
        "{{ArrowUp}} Contact damage up#Damage scale with player damage",
        ConvertRGBToIsaac({108, 53, 116})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.LOST_FLY,
        "{{ArrowUp}} Contact damage up#Damage scale with player damage",
        "{{ArrowUp}} Contact damage up#Damage scale with player damage",
        ConvertRGBToIsaac({194, 194, 194})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.SPIDER_MOD,
        "Spawn eggs which apply a random effect to enemies which walk over them#Eggs last 20 seconds",
        "Higher chance to spawn eggs#At the end of rooms, eggs spawn blue spiders",
        ConvertRGBToIsaac({194, 194, 194})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.LEECH,
        "Spawn creep when it collide with an enemy",
        "Enemies it killed explode into lot of tears",
        ConvertRGBToIsaac({99, 99, 99})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.BBF,
        "Will not explode if Isaac is close",
        "Leave powder on the ground#When it explode, powder turn to fire",
        ConvertRGBToIsaac({88, 88, 88})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.CAINS_OTHER_EYE,
        "Fire 2 tears instead of one#Tears gain a Rubber Cement effect {{Collectible".. CollectibleType.COLLECTIBLE_RUBBER_CEMENT .."}} ",
        "Fire 4 tears#Range up",
        ConvertRGBToIsaac({255, 233, 255})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.ANGELIC_PRISM,
        "Angelic Prism is closer to the player#Tears which go through it become spectral",
        "Tears which go through it earn a homing effect and a piercing effect",
        ConvertRGBToIsaac({111, 195, 239})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.PAPA_FLY,
        "Block projectiles#Has a chance to spawn a fly turret when blocking a projectile",
        "Fire three tears instead of one#{{ArrowUp}} Range Up#Higher chance to spawn a fly turret",
        ConvertRGBToIsaac({59, 107, 203})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.BLUEBABYS_ONLY_FRIEND,
        "Sometimes it will crush the ground dealing damage to close enemies",
        "When it hit the ground, it deals more damage and destroy rocks#Higher range",
        ConvertRGBToIsaac({0, 74, 128})
    )
    --[[sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.BOMB_BAG,
        "No more spawn Troll Bombs#Higher chance for better bombs (double pack and golden bombs)",
        "Can spawn items from the Bomb Bum pool#Higher chance for better bombs",
        ConvertRGBToIsaac({155, 161, 185})
    )--]]
    --[[sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.SACK_OF_PENNIES,
        "Higher chance for better coins (dimes, nickels, lucky pennies or double coins)#Can spawn a trinket (Bloody Penny, Flat Penny etc.)",
        "Can spawn an item (including A Dollar, Pageant Boy, Eye Of Greed etc.)#Higher chance for better coins and trinkets",
        ConvertRGBToIsaac({156, 133, 150})
    )--]]
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.PUNCHING_BAG,
        "Deal contact damage",
        "Turn to a random champion form#Green : Leave creep#Magenta : Fire a tear in a random direction#Violet : Pull enemies#Light Blue : Fire tears in 8 directions when player gets hit#Vivid Blue : Spawn 2-3 flies when player gets hit",
        ConvertRGBToIsaac({227, 198, 197})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.HUSHY,
        "Gain two attacks when he stop moving#Fire tears in circle directions#Fire couple of tears to the player",
        "Fire more tears during his attacks#Gain an additional attack which allow him to fire continuum {{Collectible".. CollectibleType.COLLECTIBLE_CONTINUUM .."}} tears in the direction the player is firing",
        ConvertRGBToIsaac({67, 86, 121})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.JAW_BONE,
        "Spawn bone orbitals when it hit an enemy",
        "{{ArrowUp}} Deal more than 3x Isaac's damage",
        ConvertRGBToIsaac({219, 219, 219})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.LIL_HARBINGERS,
        "Improve harbingers in different ways#WAR : War's red locusts can't hurt the player#FAMINE : Famine's locusts deal way more damage#DEATH : Deal more collision damage#PESTILENCE : Pestilence's creep deal more damage#CONQUEST : Locusts have 15% chance to spawn a \"Crack the Sky\" effect",
        "Double locust spawned by Harbingers",
        ConvertRGBToIsaac({225, 211, 211})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.RELIC,
        "Heal the player every 3 rooms",
        "Chance to spawn an additional soul heart {{SoulHeart}} or half soul heart {{HalfSoulHeart}}",
        ConvertRGBToIsaac({59, 107, 203})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.DEAD_CAT,
        "When player dies, it respawn with an additional soul heart",
        "When player dies, it respawn with an additional soul heart and an additional heart container",
        ConvertRGBToIsaac({67, 67, 67})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.LITTLE_CHUBBY,
        "Reduce cooldown, can be thrown quickly",
        "Stick to enemies for 0.5 seconds before continuing his path",
        ConvertRGBToIsaac({255, 239, 203})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.LIL_SPEWER,
        "When it shoots, it fires aditional tears which depends on it color#{{ArrowUp}} Increase a bit the size and the damage deal by the creep",
        "It has two colors as the same time#{{ArrowUp}} Increase again a bit the size and the damage deal by the creep",
        ConvertRGBToIsaac({235, 210, 210})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.HALLOWED_GROUND,
        "Add a permanent halo around it#If the player is in the halo his fire delay is reduced",
        "The halo is larger and decrease a bit more fire delay#Reduce also fire rate of familiars in the halo",
        ConvertRGBToIsaac({127, 242, 255})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.HOLY_WATER,
        "Can be used an unlimited times each rooms",
        "Give a holy Mantle {{Collectible".. CollectibleType.COLLECTIBLE_HOLY_MANTLE .."}} effect in some rooms#Spawn the Holy Water creep when losing the Holy Mantle effect#If the player is Seraphim {{Seraphim}}, increase chances to get Holy Mantle effect",
        ConvertRGBToIsaac({93, 134, 182})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.DRY_BABY,
        "{{ArrowUp}} Increase slighly chances to trigger Necronomicon effect#When it trigger the effect, destroy projectiles",
        "More Necronomicon effect !",
        ConvertRGBToIsaac({219, 219, 219})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.GUPPYS_HAIRBALL,
        "Grow to it second size#Have a chance to spawn flies when it kills an enemy",
        "Grow to it third size#Spawn more flies when it kills an enemy",
        ConvertRGBToIsaac({88, 76, 59})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.POINTY_RIB,
        "Has a chance to spawn a bone orbital when it kill an enemy#Has 1/3 chance to apply bleed effect to non- boss enemies",
        "{{ArrowUp}} Deal more damages#Has 2/3 chance to aplly bleed effect to non-boss enemies",
        ConvertRGBToIsaac({255, 255, 255})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.SLIPPED_RIB,
        "Deal damage eaquals to 0.75 x Isaac's damage (with a minimum of 3.5)",
        "When blocking a projectile it has a chance to spawn a bone orbital",
        ConvertRGBToIsaac({255, 255, 255})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.ISAACS_HEART,
        "Has 20% chance to prevent damage when it is hit by a projectile#Move closer to the player",
        "Has 20% chance to prevent damage from any sources#When player is hit, fire 8 tears in all directions",
        ConvertRGBToIsaac({179, 0, 0})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.MILK,
        "Milk! puddle deals damages",
        "Change Milk! flavours. On hit, apply different changement :#Milk : -3 Tear Delay#Chocolate Milk! : No Tears up, but Damage up (1 + Isaac damage * 0.5)#Soy Milk! : Reduce Damage and Fire Delay#Berry Milk! : Tears up, Damage up, Speed up",
        ConvertRGBToIsaac({255, 255, 255})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.DEPRESSION,
        "Every 2nd projectile this collides with, it blocks it and fires 4 creep-leaving tears",
        "Every projectile it collides with, it blocks it and fires 4 creep-leaving tear#Puddle is larger an deal more damage",
        ConvertRGBToIsaac({172, 162, 195})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.SAMSONS_CHAINS,
        "Deal damage depending on the velocity of the ball",
        "Can be thrown in front of the player to deal massive damage",
        ConvertRGBToIsaac({70, 70, 70})
    )
    if sewingMachineMod.moddedFamiliar.MARSHMALLOW > -1 then
        sewingMachineMod:AddDescriptionsForFamiliar(
            sewingMachineMod.moddedFamiliar.MARSHMALLOW,
            "Fire 3 tears instead of one",
            "Have a chance when clearing a room to upgrade itself",
            ConvertRGBToIsaac({255, 255, 255})
        )
    end
end


---------------------------
-- EID style description --
---------------------------

if EID ~= nil then
    -- Create the Sewing Machine icon, and link it to the transformation
    local sewingMachineIcon = Sprite()
    sewingMachineIcon:Load("gfx/mapicon.anm2", true)
    EID:addIcon("SewnSewingMachine", "Icon", 0, 15, 12, 0, 0, sewingMachineIcon)
end

--[[local function getPositionForInfo(machine)
    return Isaac.WorldToScreen(machine.Position + machine.PositionOffset) - Vector(EID.Config.TextboxWidth, 0) + sewingMachineMod.descriptionOffset
end--]]

-- Helper to render upgrade info (name and desc)
--[[local function renderUpgradeInfo(machine, familiarName, upgradeDescription, upgradeLevel, color, transparency)
    
    if EID == nil or sewingMachineMod.Config.EID_enable == false then return end

    local position = getPositionForInfo(machine)
    local kcolor = KColor(color[1], color[2], color[3], EID.Config.Transparency)
    
    local icon = "{{SewnCrown" .. upgradeLevel .. "}}"
    EID:renderString(icon .. " " .. familiarName, position - Vector(0, 12 * EID.Config.Scale), Vector(EID.Config.Scale, EID.Config.Scale), kcolor)
    EID:printBulletPoints(upgradeDescription, position)
end--]]

--[[function sewingMachineMod:renderEID()

    if EID == nil or sewingMachineMod.Config.EID_enable == false then return end
    
    -- currentUpgradeInfo is updated when a familiar is put in or moved out of the machine. When it's not false it's the machine.
    if sewingMachineMod.currentUpgradeInfo ~= nil then
        local mData = sewingMachineMod.sewingMachinesData[sewingMachineMod.currentUpgradeInfo.InitSeed]
        
        -- if the machine data is nil (should never happened) or there is no familiar on the machine
        if mData == nil or mData.Sewn_currentFamiliarVariant == nil then
            return
        end

        -- Make sure the familiar has info
        local info = sewingMachineMod:GetInfoForFamiliar(mData.Sewn_currentFamiliarVariant)
        if info == false then
            return -- This will happen if the familiars doesn't have descriptions
        end

        -- Collect info
        local upgradeLevel = mData.Sewn_currentFamiliarState == 0 and "Super" or "Ultra"
        local upgradeDescription = mData.Sewn_currentFamiliarState == 0 and info.firstUpgrade or info.secondUpgrade

        renderUpgradeInfo(sewingMachineMod.currentUpgradeInfo, info.name, upgradeDescription, upgradeLevel, info.color, sewingMachineMod.Config.EID_textTransparency)
    end
    
    if sewingMachineMod.displayTrueCoopMessage == true and sewingMachineMod.Config.TrueCoop_displayText ~= false then
        Isaac.RenderText("Sewing Machines can't work with True-Coop", 115, 200, 1, 1, 1, 1)
    end
end--]]

function sewingMachineMod:updateMachinesDescription()
    for _, machine in pairs(sewingMachineMod:getAllSewingMachines()) do
        sewingMachineMod:updateSewingMachineDescription(machine)
    end
end

local function loopThroughAvailableFamiliars(_function)
    for familiarID, data in pairs(sewingMachineMod.availableFamiliar) do
        _function(data[1])
    end
end


-- Link the familiar description to the machine
function sewingMachineMod:updateSewingMachineDescription(machine)

    if EID == nil then return end

    if sewingMachineMod.Config.EID_enable == false then
        machine:GetData()["EID_Description"] = nil
        sewingMachineMod.sewingMachinesData[machine.InitSeed]["EID_Description"] = nil
        return
    end

    local mData = sewingMachineMod.sewingMachinesData[machine.InitSeed]
    local info = sewingMachineMod:GetInfoForFamiliar(mData.Sewn_currentFamiliarVariant)
    if info == false then
        machine:GetData()["EID_Description"] = nil
        sewingMachineMod.sewingMachinesData[machine.InitSeed]["EID_Description"] = nil
        return
    end
    local upgradeDescription = mData.Sewn_currentFamiliarState == 0 and info.firstUpgrade or info.secondUpgrade
    local levelCrown = mData.Sewn_currentFamiliarState == 0 and "Super" or "Ultra"
    -- Get the color markup or an empty string
    local colorMarkup = ""
    if EID.InlineColors["SewnColor_"..info.name] then
        colorMarkup = "{{SewnColor_"..info.name .. "}}"
    end

    machine:GetData()["EID_Description"] = {
        ["Name"] = colorMarkup .. "{{SewnCrown" .. levelCrown .. "}}" .. info.name .." {{SewnSewingMachine}}",
        ["Description"] = upgradeDescription
    }
    sewingMachineMod.sewingMachinesData[machine.InitSeed]["EID_Description"] = machine:GetData()["EID_Description"]
end

-- Add an indicator into the EID of collectibles
function sewingMachineMod:addEIDDescriptionForCollectible()

    if EID == nil then return end

    loopThroughAvailableFamiliars(function(itemID)
        local additionalDescr = "#{{SewnCrownSuper}} Upgradable"
        -- Remove "Crown Transformation" from EID
        --if sewingMachineMod.Config.EID_indicateFamiliarUpgradable ~= sewingMachineMod.CONFIG_CONSTANT.EID_INDICATE_FAMILIAR_UPGRADABLE.TOP then
            EID:removeTransformation("collectible", itemID, "FamiliarUpgradable")
        --end
        -- Remove the new line which indicae "Upgradable"
        if __eidItemDescriptions ~= nil and __eidItemDescriptions[itemID] ~= nil then
            __eidItemDescriptions[itemID] = string.gsub(__eidItemDescriptions[itemID], additionalDescr, "")
        end
        for key, data in pairs(EID.descriptions) do
            if data.collectibles[itemID] ~= nil then -- Vanilla items
                data.collectibles[itemID][3] = string.gsub(data.collectibles[itemID][3], additionalDescr, "")
            elseif data.custom["5.100." .. itemID] ~= nil then -- Modded items
                data.custom["5.100." .. itemID][3] = string.gsub(data.custom["5.100." .. itemID][3], additionalDescr, "")
            end
        end
    end)

    if sewingMachineMod.Config.EID_indicateFamiliarUpgradable == sewingMachineMod.CONFIG_CONSTANT.EID_INDICATE_FAMILIAR_UPGRADABLE.NONE then
        return
    end
    

    local crownSprite = Sprite()
    crownSprite:Load("gfx/sewn_familiar_crown.anm2", false)
    crownSprite:LoadGraphics()

    EID:addIcon("FamiliarUpgradable", "DescrSuper", 0, 15, 12, 8, 6, crownSprite)
    EID:addIcon("SewnCrownSuper", "Super", 0, 12, 9, 1, 10, crownSprite)
    EID:addIcon("SewnCrownUltra", "Ultra", 0, 12, 9, 1, 10, crownSprite)

    if sewingMachineMod.Config.EID_indicateFamiliarUpgradable == sewingMachineMod.CONFIG_CONSTANT.EID_INDICATE_FAMILIAR_UPGRADABLE.TOP then
        if (EID.CustomTransformations["FamiliarUpgradable"] == nil) then
            EID:createTransformation("FamiliarUpgradable", "Upgradable")
        end

        loopThroughAvailableFamiliars(function(itemID)
            EID:assignTransformation("collectible", itemID, "FamiliarUpgradable")
        end)
    elseif sewingMachineMod.Config.EID_indicateFamiliarUpgradable == sewingMachineMod.CONFIG_CONSTANT.EID_INDICATE_FAMILIAR_UPGRADABLE.NEW_LINE then
        loopThroughAvailableFamiliars(function(itemID)
            local additionalDescr = "#{{SewnCrownSuper}} Upgradable"
            -- Modded items, with old EID support
            if __eidItemDescriptions ~= nil and __eidItemDescriptions[itemID] ~= nil then
                __eidItemDescriptions[itemID] = __eidItemDescriptions[itemID] .. additionalDescr
            else
                for key, data in pairs(EID.descriptions) do
                    if data.collectibles[itemID] ~= nil then -- Vanilla items
                        data.collectibles[itemID][3] = data.collectibles[itemID][3] .. additionalDescr
                    elseif data.custom["5.100." .. itemID] ~= nil then -- Modded items
                        data.custom["5.100." .. itemID][3] = data.custom["5.100." .. itemID] .. additionalDescr
                    end
                end
            end
        end)
    end
    sewingMachineMod.IsEidDescriptionLoaded = true
end

sewingMachineMod.errFamiliars.Error()