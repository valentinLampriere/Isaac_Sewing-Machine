sewingMachineMod.FamiliarsUpgradeDescriptions = {}

local function ConvertRGBToIsaac(color)
    return {color[1]/255, color[2]/255, color[3]/255}
end

function sewingMachineMod:GetInfoForFamiliar(familiarVariant)
    return sewingMachineMod.FamiliarsUpgradeDescriptions[familiarVariant] or false
end

function sewingMachineMod:AddDescriptionsForFamiliar(familiarVariant, firstUpgrade, secondUpgrade, color, optionalName)
    
    local name
    if optionalName ~= nil then
        name = optionalName
    else
        local collectible = Isaac.GetItemConfig():GetCollectible(sewingMachineMod.availableFamiliar[familiarVariant][1])
        if collectible ~= nil then
            name = collectible.Name
        end
    end
    
    if sewingMachineMod.Config.EID_textColored == false then
        color = {1, 1, 1}
    end
    
    sewingMachineMod.FamiliarsUpgradeDescriptions[familiarVariant] = {
        name = name,
        firstUpgrade = firstUpgrade,
        secondUpgrade = secondUpgrade,
        color = color or {1, 1, 1}
    }
end

function sewingMachineMod:InitFamiliarDescription()
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.BROTHER_BOBBY,
        "\1 Damage Up (x2)",
        "\1 Damage Up#\1 Tears Up",
        ConvertRGBToIsaac({139, 145, 181})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.SISTER_MAGGY,
        "\1 Tears Up",
        "\1 Tears Up#\1 Damage Up",
        ConvertRGBToIsaac({203, 0, 0})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.GHOST_BABY,
        "Gain piercing Pupula tears#\1 Slight Damage Up",
        "Tears are larger#\1 Damage Up",
        ConvertRGBToIsaac({255, 255, 255})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.ROBO_BABY,
        "\1 Tears Up",
        "\1 Tears Up",
        ConvertRGBToIsaac({219, 219, 239})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.LITTLE_GISH,
        "Tears create a puddle of creep on hit#\1 Slight Tears Up",
        "Larger creep#\1 Slight Tears Up",
        ConvertRGBToIsaac({67, 67, 67})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.SERAPHIM,
        "Have a chance to fire Holy Tears",
        "Higher chance to fire Holy Tears#\1 Slight Tears Up",
        ConvertRGBToIsaac({227, 198, 197})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.HARLEQUIN_BABY,
        "Fire an additional shot on each sides",
        "\1 Damage Up",
        ConvertRGBToIsaac({202, 158, 158})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.LIL_LOKI,
        "Fire in 8 directions",
        "\1 Damage Up",
        ConvertRGBToIsaac({203, 0, 0})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.BUDDY_IN_A_BOX,
        "Gain a random additional tear effect#Additional tear effect can't be Ipecac unless Ipecac is the base attack of the buddy#\1 Slight Tears Up",
        "Gain an other random additional tear effect#\1 Slight Tears Up"
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.RAINBOW_BABY,
        "\1 Tears Up",
        "\1 Tears Up",
        ConvertRGBToIsaac({244, 69, 173})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.LITTLE_STEVEN,
        "\1 Range Up#\2 Shot Speed Down#\1 Damage Up",
        "\1 Range Up#\2 Shot Speed Down#\1 Damage Up#\1 Tears Up",
        ConvertRGBToIsaac({8, 0, 0})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.HEADLESS_BABY,
        "Spawn large creep",
        "Fire burst of tears while isaac is firing",
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
        "\1 Tears Up#\1 Slight Damage Up",
        "Fire rate scale with player fire rate",
        ConvertRGBToIsaac({87, 135, 231})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.MONGO_BABY,
        "Copy Super upgrade",
        "Copy Ultra upgrade",
        ConvertRGBToIsaac({223, 182, 178})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.LIL_BRIMSTONE,
        "\1 Damage Up",
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
        "\1 Higher Range",
        ConvertRGBToIsaac({45, 45, 45})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.ABEL,
        "\1 Damage Up#Block projectiles",
        "Deal collision damage#Amount of damage scale with the distance with the player",
        ConvertRGBToIsaac({227, 198, 197})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.SACRIFICIAL_DAGGER,
        "Apply bleed effect",
        "\1  Damage Up",
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
        "Has a chance to spawn half a soul heart when blocking a projectile",
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
        "Spawn an additional locust#\3 Can be red locust",
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
        "Has 33% chance to spawn a full red heart",
        "Has 33% chance to spawn half a soul heart",
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
        "Can apply a dazed effect",
        "Slighly deflect tears from player",
        ConvertRGBToIsaac({204, 204, 204})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.PEEPER,
        "Fire 5 tears in differents directions every few seconds",
        "Spawn an additional Peeper Eye#New peeper eye spawn Ultra",
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
        "Contact damage up#Damage scale with player damage",
        "Contact damage up#Damage scale with player damage",
        ConvertRGBToIsaac({203, 0, 0})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.FOREVER_ALONE,
        "Contact damage up#Damage scale with player damage",
        "Contact damage up#Damage scale with player damage",
        ConvertRGBToIsaac({51, 95, 179})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.FRIEND_ZONE,
        "Contact damage up#Damage scale with player damage",
        "Contact damage up#Damage scale with player damage"
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.OBSESSED_FAN,
        "Contact damage up#Damage scale with player damage",
        "Contact damage up#Damage scale with player damage",
        ConvertRGBToIsaac({108, 53, 116})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.LOST_FLY,
        "Contact damage up#Damage scale with player damage",
        "Contact damage up#Damage scale with player damage",
        ConvertRGBToIsaac({194, 194, 194})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.SPIDER_MOD,
        "Spawn eggs which apply a random effect to enemies which walk over them",
        "Higher chance to spawn eggs#At the end of rooms, eggs spawn blue spiders",
        ConvertRGBToIsaac({194, 194, 194})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.ISAACS_HEART,
        "Gain a fly orbital which block projectiles",
        "Reduce hitbox (not the sprite scale)#Closer from the player like if it has \"Child Leash\"",
        ConvertRGBToIsaac({179, 0, 0})
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
        "Tears have a 50% chance to apply confusion#Tears take a Glaucoma aspect, but confusion isn't permanent unlike Glaucoma tears",
        "Fire 8 tears in all directions",
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
        "Fire three tears instead of one#Range Up#Higher chance to spawn a fly turret",
        ConvertRGBToIsaac({59, 107, 203})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.BLUEBABYS_ONLY_FRIEND,
        "Sometimes it will crush the ground dealing damage to close enemies",
        "When it hit the ground, it deals more damage and destroy rocks#Higher range",
        ConvertRGBToIsaac({0, 74, 128})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.BOMB_BAG,
        "No more spawn Troll Bombs#Higher chance for better bombs (double pack and golden bombs)",
        "Can spawn items from the Bomb Bum pool#Higher chance for better bombs",
        ConvertRGBToIsaac({155, 161, 185})
    )
    sewingMachineMod:AddDescriptionsForFamiliar(
        FamiliarVariant.SACK_OF_PENNIES,
        "Higher chance for better coins (dimes, nickels, lucky pennies or souble coins)#Can spawn a trinket",
        "Can spawn an item (including A Dollar, Pageant Boy, Eye Of Greed etc.)#Higher chance for better coins and trinkets",
        ConvertRGBToIsaac({156, 133, 150})
    )
end
sewingMachineMod:InitFamiliarDescription()


---------------------------
-- EID style description --
---------------------------

sewingMachineMod.descriptionValues = {
    TEXT_SCALE = 0.5, -- Size of the text. It looks best on 0.5 imp.
    TEXT_BOX_WIDTH = 25, -- The limit of characters allowed in each line. The code splits the description to multiple lines based on this.
    LINE_HEIGHT = 11, -- Don't touch this
    POSITION_OFFSET = Vector(-20, -30), -- Position offset from the screen position of the machine. I just eyeballed it until it looked good.
    TITLE_OFFSET_X = 5 -- Title (Name of the familiar) offset 
}

sewingMachineMod.descriptionValues.crown = Sprite()
sewingMachineMod.descriptionValues.crown:Load("gfx/sewn_familiar_crown.anm2", false)
sewingMachineMod.descriptionValues.crown.Scale = Vector(sewingMachineMod.descriptionValues.TEXT_SCALE, sewingMachineMod.descriptionValues.TEXT_SCALE)
sewingMachineMod.descriptionValues.crown:LoadGraphics()


-- To support the EID style of desriptions, Thanks Wofsauge :)
local function printBulletPointsForDesc(Description, padding, xposition, color, transparency, LongestLine)
    local spaceNeeded = 0
    local longestLine = LongestLine

    for line in string.gmatch(Description, '([^#]+)') do
        local array={}
        local text = ""
        for word in string.gmatch(line, '([^ ]+)') do
            if string.len(text)+string.len(word)<=sewingMachineMod.descriptionValues.TEXT_BOX_WIDTH then
                text = text.." "..word
            else
                table.insert(array, text)
                text = word
            end
        end
        table.insert(array, text)

        for i, v in ipairs(array) do
            if #v > #LongestLine then LongestLine = v end -- Find longest line in the description
        end

        spaceNeeded = (Isaac.GetTextWidth(LongestLine .. "  ")) * sewingMachineMod.descriptionValues.TEXT_SCALE -- Calc the amount of pixels the longest lines take
    end

    for line in string.gmatch(Description, '([^#]+)') do
        local array={}
        local text = ""
        for word in string.gmatch(line, '([^ ]+)') do
            if string.len(text)+string.len(word)<=sewingMachineMod.descriptionValues.TEXT_BOX_WIDTH then
                text = text.." "..word
            else
                table.insert(array, text)
                text = word
            end
        end
        table.insert(array, text)

        for i, v in ipairs(array) do
            if i== 1 then 
                if string.sub(v, 2, 2)=="\001" or string.sub(v, 2, 2)=="\002" or string.sub(v, 2, 2)=="\003" then 
                    Isaac.RenderScaledText(string.sub(v, 2, 2)..string.sub(v,3,string.len(v)), xposition - spaceNeeded, padding, sewingMachineMod.descriptionValues.TEXT_SCALE, sewingMachineMod.descriptionValues.TEXT_SCALE, color[1], color[2], color[3], transparency)
                else
                    Isaac.RenderScaledText("\007"..v, xposition - spaceNeeded, padding, sewingMachineMod.descriptionValues.TEXT_SCALE, sewingMachineMod.descriptionValues.TEXT_SCALE, color[1] , color[2], color[3], transparency)
                end
            else
                Isaac.RenderScaledText("  "..v, xposition - spaceNeeded, padding, sewingMachineMod.descriptionValues.TEXT_SCALE, sewingMachineMod.descriptionValues.TEXT_SCALE, color[1] , color[2], color[3], transparency)
            end

            padding = padding + sewingMachineMod.descriptionValues.LINE_HEIGHT * sewingMachineMod.descriptionValues.TEXT_SCALE
        end
    end
    return spaceNeeded
end

local function getPositionForInfo(machine)
    return Isaac.WorldToScreen(machine.Position + machine.PositionOffset) + sewingMachineMod.descriptionValues.POSITION_OFFSET
end

-- Helper to render upgrade info (name and desc)
local function renderUpgradeInfo(machine, familiarName, upgradeDescription, upgradeLevel, color, transparency)
    local longestLine = familiarName
    local position = getPositionForInfo(machine)

    -- Upgrade desciption
    local spaceNeeded = printBulletPointsForDesc(upgradeDescription, position.Y + sewingMachineMod.descriptionValues.LINE_HEIGHT * sewingMachineMod.descriptionValues.TEXT_SCALE, position.X, {1, 1, 1}, transparency, longestLine)

    -- Crown icon
    sewingMachineMod.descriptionValues.crown.Color=Color(1,1,1,transparency,0,0,0)
    sewingMachineMod.descriptionValues.crown:Play("Descr" .. upgradeLevel)
    sewingMachineMod.descriptionValues.crown:Render(Vector(position.X - spaceNeeded + sewingMachineMod.descriptionValues.TITLE_OFFSET_X - 15 * sewingMachineMod.descriptionValues.TEXT_SCALE, position.Y + sewingMachineMod.descriptionValues.LINE_HEIGHT * sewingMachineMod.descriptionValues.TEXT_SCALE / 2), Vector(0, 0), Vector(0, 0))
    
    Isaac.RenderScaledText(familiarName, position.X - spaceNeeded + sewingMachineMod.descriptionValues.TITLE_OFFSET_X, position.Y, sewingMachineMod.descriptionValues.TEXT_SCALE, sewingMachineMod.descriptionValues.TEXT_SCALE, color[1], color[2], color[3], transparency)
    
end

function sewingMachineMod:onRender()
    local curse = Game():GetLevel():GetCurses()
    
    -- Do not show EID when it's disable
    if sewingMachineMod.Config.EID_enable == sewingMachineMod.CONFIG_CONSTANT.EID.DISABLED then
        return
    end
    -- Do not show EID when it's auto and EID mod isn't enable
    if sewingMachineMod.Config.EID_enable == sewingMachineMod.CONFIG_CONSTANT.EID.AUTO and not EID then
        return
    end
    
    if curse == LevelCurse.CURSE_OF_BLIND and sewingMachineMod.Config.EID_hideCurseOfBlind == true then
        return
    end
        
    -- currentUpgradeInfo is updated when a familiar is put in or moved out of the machine. When it's not false it's the machine.
    if sewingMachineMod.currentUpgradeInfo ~= nil then
        local mData = sewingMachineMod.sewingMachinesData[sewingMachineMod.currentUpgradeInfo.InitSeed]
        if mData == nil or mData.Sewn_currentFamiliarVariant == nil then return end -- This should never happen but it's not bad to make sure

        -- Make sure the familiar has info
        local info = sewingMachineMod:GetInfoForFamiliar(mData.Sewn_currentFamiliarVariant)
        if info == false then return end -- This will happen if the familiars doesn't have descriptions

        -- Collect info
        local upgradeLevel = mData.Sewn_currentFamiliarState == 0 and "Super" or "Ultra"
        local upgradeDescription = mData.Sewn_currentFamiliarState == 0 and info.firstUpgrade or info.secondUpgrade

        renderUpgradeInfo(sewingMachineMod.currentUpgradeInfo, info.name, upgradeDescription, upgradeLevel, info.color, sewingMachineMod.Config.EID_textTransparency)
    end
    
    if sewingMachineMod.displayTrueCoopMessage == true and sewingMachineMod.Config.TrueCoop_displayText ~= false then
        Isaac.RenderText("Sewing Machines can't work with True-Coop", 115, 200, 1, 1, 1, 1)
    end
end

-- Render info
sewingMachineMod:AddCallback(ModCallbacks.MC_POST_RENDER, sewingMachineMod.onRender)

sewingMachineMod.errFamiliars.Error()