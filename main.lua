-------------------------------
-------- DOCUMENTATION --------
-------------------------------


-- *** Here are some functions you can use to upgrade your custom familiars *** --


-----------------------
-- GENERAL FUNCTIONS --
-----------------------


-- MAKE FAMILIAR AVAILABLE --
-- Description :
--   This function allow a familiar to be upgrade in the Sewing Machine. If this function is not called, your custom familiars couldn't be upgrade
--   The third parameter is a function, I recommend you to use it so the function will be called when the familiar is upgrade. In this function you can use custom callbacks (see below), or do what you want
-- Parameters :
--   familiarVariant (number)   : The variant of the familiar you want to upgrade
--   collectibleID   (number)   : ID of the collectible which will appear on the Sewing Machine
--   _function       (function) : The function which will be called when the familiar is upgrade (optional)
--
-- sewingMachineMod:makeFamiliarAvailable(familiarVariant, collectibleID, _function)


-- IS AVAILABLE --
-- Description :
--   This check if a familiar can be upgraded in the Sewing Machine
-- Parameters :
--   familiarVariant (number) : The variant of the familiar you want to upgrade
-- Returns :
--   A boolean, true if the familiar can be upgraded
--
-- sewingMachineMod:isAvailable(familiarVariant)


-- IS SUPER --
-- Description :
--   This check if a familiar is upgraded as SUPER (gold crown)
-- Parameters :
--   fData (userdata) : Userdata of the familiar you want to check (familiar:GetData())
-- Returns :
--   A boolean, true if the familiar is SUPER
--
-- sewingMachineMod:isSuper(fData)


-- IS ULTRA --
-- Description :
--   This check if a familiar is upgraded as ULTRA (diamond crown)
-- Parameters :
--   fData (userdata) : Userdata of the familiar you want to check (familiar:GetData())
-- Returns :
--   A boolean, true if the familiar is ULTRA
--
-- sewingMachineMod:isUltra(fData)


-- ADD DESCRIPTION FOR FAMILIARS (EID)
-- Description :
--   This function allow you to add a description for your familiars upgrade
-- Parameters :
--   familiarVariant  (number) : The Variant of the familiar
--   firstUpgrade     (string) : The text which will be display when upgrading the first level
--   secondUpgrade    (string) : The text for second level. Use "#" to go to the next line
--   color            (table)  : OPTIONNAL A color stored has a table with 3 values {1, 1, 1}
--   optionalName     (string) : OPTIONNAL The name of the familiar which will be displayed above the description. By default, the collectible name is choosen
--
-- sewingMachineMod:AddDescriptionsForFamiliar(familiarVariant, firstUpgrade, secondUpgrade, color, optionalName)

-- HIDE CROWN --
-- Description :
-- Hide or unhide the crown of a familiar
-- Parameters :
--   familiar  (EntityFamiliar) : The familiar
--   hideCrown (boolean) : OPTIONNAL true or missing hide the crown ; false unhide the crown
--
-- sewingMachineMod:hideCrown(familiar, hideCrown)

-- ADD CROWN OFFSET --
-- Description :
-- Add an offset to the crown for a specific familiar, like so it's possible to choose where the crown will be displayed
-- Parameters :
--   familiar (EntityFamiliar) : The familiar
--   offset   (Vector) : The offset position of the crown
--
-- sewingMachineMod:addCrownOffset(familiar, offset)

-------------------------
-- FAMILIARS FUNCTIONS --
-------------------------
-- Those function are usefull (but not necessary) to prepare familiar stats upgrade, or custom behaviour

-- Set the fire rate bonus of the familiar
-- sewingMachineMod.sewnFamiliars:setTearRateBonus(familiar, bonus)

-- Set the bonus damage of a tear (or laser). The bonus is a multiplier, it will be applied on default tear damage
-- sewingMachineMod.sewnFamiliars:setDamageTearMultiplier(familiar, bonus)

-- Set the bonus range of a tear. This bonus is a multiplier
-- sewingMachineMod.sewnFamiliars:setRangeBonusMultiplier(familiar, bonus)

-- Set the shot speed bonus of a tear. This bonus is a multiplier
-- sewingMachineMod.sewnFamiliars:setShotSpeedBonusMultiplier(familiar, multiplier)

-- Set the tear size of a tear. This is a multiplier
-- sewingMachineMod.sewnFamiliars:setTearSizeMultiplier(familiar, multiplier)

-- Add tearFlags to any tears fired from the familiar. "chance" is optionnal
-- sewingMachineMod.sewnFamiliars:addTearFlag(familiar, newTearFlag, chance)

-- Change TearVariant of any tears fired from the familiar
-- sewingMachineMod.sewnFamiliars:changeTearVariant(familiar, tearVariant)

-- Change the Size of the familiar. This is a multiplier
-- sewingMachineMod.sewnFamiliars:spriteScaleMultiplier(familiar, multiplier)

--------------------------------------------------------------------------
-- Function below allow you to call custom function depending on events --
-- Those functions have to be called ONCE when the familiar is upgraded --
-- After they are called, the function in parameter will be called      --
-- every time a callback is called.                                     --
--------------------------------------------------------------------------
-- Exemple :
-- sewingMachineMod.sewnFamiliars:customCollision(bobby, mod.bobbyCollide)
-- Here, "mod.bobbyCollide" will be called every time bobby collide with something, on "MC_PRE_FAMILIAR_COLLISION"

-- Called when the familiar fire a tear (or a laser)
-- sewingMachineMod.sewnFamiliars:customFireInit(familiar, functionName)
-- The function will have 2 parameters : The familiar and the tear which is fired

-- Called when a familiar's tear hit something
-- sewingMachineMod.sewnFamiliars:sewnFamiliars:customTearCollision(familiar, functionName)
-- The function will have 3 parameters : The familiar, the tear which is colliding and the collider

-- Called when the familiar is playing a special animation. "animation_s" is the name of a animation (string), or a table which contains several animation names.
-- sewingMachineMod.sewnFamiliars:sewnFamiliars:customAnimation(familiar, functionName, animation_s)
-- The function will have 2 parameters : The familiar and the tear which is falling

-- Called when the familiar is updated, called every frame
-- sewingMachineMod.sewnFamiliars:sewnFamiliars:customUpdate(familiar, functionName)
-- The function will have 1 parameters : The familiar

-- Called when the familiar is rendered
-- sewingMachineMod.sewnFamiliars:sewnFamiliars:customRender(familiar, functionName)
-- The function will have 1 parameters : The familiar

-- Called when the familiar is colliding with something
-- sewingMachineMod.sewnFamiliars:sewnFamiliars:customCollision(familiar, functionName)
-- The function will have 2 parameters : The familiar and the collider

-- Called when entering a new room
-- sewingMachineMod.sewnFamiliars:sewnFamiliars:customNewRoom(familiar, functionName)
-- The function will have 1 parameters : The familiar

-- Called when the familiar's player evaluate his cache
-- sewingMachineMod.sewnFamiliars:sewnFamiliars:customCache(familiar, functionName)
-- The function will have 2 parameters : The familiar, and the evaluated CacheFlag

-- Called when the familiar kill an enemy
-- sewingMachineMod.sewnFamiliars:sewnFamiliars:customKillEnemy(familiar, functionName)
-- The function will have 2 parameters : The familiar, and the killed enemy



-- Usefull data attribute :

-- To prevent a familiar to be upgradable (for exemple for copy familiar of King Baby)
-- familiar:GetData().Sewn_noUpgrade = true


-- You can have a look on how I upgrade vanilla familiars in familiars.lua


-- *** Special thanks to Foks, SupremeElf, PixelPlz, Cadence and Sentinel for their support and their help *** --


sewingMachineMod = RegisterMod("Sewing machine", 1)

sewingMachineMod.SewingMachine = Isaac.GetEntityVariantByName("Sewing machine")
------------------
-- ENUMERATIONS --
------------------
-- Trinkets --
TrinketType.TRINKET_THIMBLE = Isaac.GetTrinketIdByName("Thimble")
TrinketType.TRINKET_CRACKED_THIMBLE = Isaac.GetTrinketIdByName("Cracked Thimble")
TrinketType.TRINKET_LOST_BUTTON = Isaac.GetTrinketIdByName("Lost Button")
TrinketType.TRINKET_CONTRASTED_BUTTON = Isaac.GetTrinketIdByName("Contrasted Button")
TrinketType.TRINKET_PIN_CUSHION = Isaac.GetTrinketIdByName("Pin Cushion")
-- Collectibles --
CollectibleType.COLLECTIBLE_SEWING_BOX = Isaac.GetItemIdByName("Sewing Box")
CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD = Isaac.GetItemIdByName("Doll's Tainted Head")
CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY = Isaac.GetItemIdByName("Doll's Pure Body")
-- Cards --
Card.CARD_WARRANTY = Isaac.GetCardIdByName("warrantyCard")
Card.CARD_STITCHING = Isaac.GetCardIdByName("stitchingCard")
-- Familiars --
FamiliarVariant.DOLL_S_TAINTED_HEAD = Isaac.GetEntityVariantByName("Doll's Tainted Head")
FamiliarVariant.DOLL_S_PURE_BODY = Isaac.GetEntityVariantByName("Doll's Pure Body")
FamiliarVariant.SEWN_DOLL = Isaac.GetEntityVariantByName("Sewn Doll")
-- Effects
EffectVariant.PULLING_EFFECT_2 = Isaac.GetEntityVariantByName("Pulling Effect 02")
EffectVariant.SPIDER_MOD_EGG = Isaac.GetEntityVariantByName("Spider Mod Egg")
EffectVariant.HALLOWED_GROUND_PERMANENT_AURA = Isaac.GetEntityVariantByName("Hallowed Ground Permanent Aura")

sewingMachineMod.sewingMachinesData = {}

sewingMachineMod.SewingMachineSubType = {
    BEDROOM = 0,
    SHOP = 1,
    ANGELIC = 2,
    EVIL = 3
}
sewingMachineMod.SewingMachineCost = {
    BEDROOM = 2,
    SHOP = 10,
    SHOP_SALE = 5,
    ANGELIC = 0,
    EVIL = 2
}
sewingMachineMod.UpgradeState = {
    NORMAL = 0,
    SUPER  = 1,
    ULTRA  = 2
}

sewingMachineMod.delayedFunctions = {}
sewingMachineMod.currentUpgradeInfo = nil
sewingMachineMod.currentCurse = 0
sewingMachineMod.rng = RNG()

local json = require("json")
local v0 = Vector(0, 0)

--local sewingMachineMod.rng = RNG()
local game = Game()
local sewingMachine_shouldAppear_shop = false
local temporaryFamiliars = {}
local trinketSewingMachine = {
    TrinketType.TRINKET_THIMBLE,
    TrinketType.TRINKET_LOST_BUTTON,
    TrinketType.TRINKET_PIN_CUSHION,
    TrinketType.TRINKET_CRACKED_THIMBLE,
    TrinketType.TRINKET_CONTRASTED_BUTTON
}


sewingMachineMod.displayTrueCoopMessage = false
sewingMachineMod.currentRoom = nil
sewingMachineMod.currentLevel = nil
sewingMachineMod.moddedFamiliar = {
    MARSHMALLOW = Isaac.GetEntityVariantByName("Marshmallow")
}

-- Import files
local function __require(file)
    local _, err = pcall(require, file)
    if string.match(tostring(err), "attempt to index a nil value %(field 'errFamiliars'%)") then --supposed to error this way at end of file for luamod command workaround
    else
      Isaac.DebugString("Failed to load module: " .. tostring(err))
      Isaac.ConsoleOutput("Failed to load module: " .. tostring(err) .. "\n")
    end
end
__require("sewn_scripts.config")
__require("sewn_scripts.familiars")

-------------------------
-- AVAILABLE FAMILIARS --
-------------------------
sewingMachineMod.availableFamiliar = {
    [FamiliarVariant.BROTHER_BOBBY] = {8, sewingMachineMod.sewnFamiliars.upBrotherBobby},
    [FamiliarVariant.DISTANT_ADMIRATION] = {57, sewingMachineMod.sewnFamiliars.upFlies},
    [FamiliarVariant.SISTER_MAGGY] = {67, sewingMachineMod.sewnFamiliars.upSisterMaggy},
    [FamiliarVariant.DEAD_CAT] = {81, sewingMachineMod.sewnFamiliars.upDeadCat},
    [FamiliarVariant.LITTLE_CHUBBY] = {88, sewingMachineMod.sewnFamiliars.upLittleChubby},
    [FamiliarVariant.SACK_OF_PENNIES] = {94, sewingMachineMod.sewnFamiliars.upSackOfPennies},
    [FamiliarVariant.ROBO_BABY] = {95, sewingMachineMod.sewnFamiliars.upRoboBaby},
    [FamiliarVariant.LITTLE_CHAD] = {96, sewingMachineMod.sewnFamiliars.upLittleChad},
    [FamiliarVariant.RELIC] = {98, sewingMachineMod.sewnFamiliars.upTheRelic},
    [FamiliarVariant.LITTLE_GISH] = {99, sewingMachineMod.sewnFamiliars.upLittleGish},
    [FamiliarVariant.LITTLE_STEVEN] = {100, sewingMachineMod.sewnFamiliars.upLittleSteven},
    [FamiliarVariant.GUARDIAN_ANGEL] = {112, sewingMachineMod.sewnFamiliars.upGuardianAngel},
    [FamiliarVariant.DEMON_BABY] = {113, sewingMachineMod.sewnFamiliars.upDemonBaby},
    [FamiliarVariant.FOREVER_ALONE] = {128, sewingMachineMod.sewnFamiliars.upFlies},
    [FamiliarVariant.BOMB_BAG] = {131, sewingMachineMod.sewnFamiliars.upBombBag},
    [FamiliarVariant.PEEPER] = {155, sewingMachineMod.sewnFamiliars.upPeeper},
    [FamiliarVariant.GHOST_BABY] = {163, sewingMachineMod.sewnFamiliars.upGhostBaby},
    [FamiliarVariant.HARLEQUIN_BABY] = {167, sewingMachineMod.sewnFamiliars.upHarlequinBaby},
    [FamiliarVariant.SACRIFICIAL_DAGGER] = {172, sewingMachineMod.sewnFamiliars.upSacrificialDagger},
    [FamiliarVariant.RAINBOW_BABY] = {174, sewingMachineMod.sewnFamiliars.upRainbowBaby},
    [FamiliarVariant.HOLY_WATER] = {178, sewingMachineMod.sewnFamiliars.upHolyWater},
    [FamiliarVariant.GUPPYS_HAIRBALL] = {187, sewingMachineMod.sewnFamiliars.upGuppysHairball},
    [FamiliarVariant.ABEL] = {188, sewingMachineMod.sewnFamiliars.upAbel},
    [FamiliarVariant.DRY_BABY] = {265, sewingMachineMod.sewnFamiliars.upDryBaby},
    [FamiliarVariant.JUICY_SACK] = {266, sewingMachineMod.sewnFamiliars.upJuicySack},
    [FamiliarVariant.ROBO_BABY_2] = {267, sewingMachineMod.sewnFamiliars.upRoboBaby2},
    [FamiliarVariant.ROTTEN_BABY] = {268, sewingMachineMod.sewnFamiliars.upRottenBaby},
    [FamiliarVariant.HEADLESS_BABY] = {269, sewingMachineMod.sewnFamiliars.upHeadlessBaby},
    [FamiliarVariant.LEECH] = {270, sewingMachineMod.sewnFamiliars.upLeech},
    [FamiliarVariant.BBF] = {272, sewingMachineMod.sewnFamiliars.upBbf},
    [FamiliarVariant.BOBS_BRAIN] = {273, sewingMachineMod.sewnFamiliars.upBobsBrain},
    [FamiliarVariant.LIL_BRIMSTONE] = {275, sewingMachineMod.sewnFamiliars.upLilBrimstone},
    [FamiliarVariant.ISAACS_HEART] = {276, sewingMachineMod.sewnFamiliars.upIsaacsHeart},
    [FamiliarVariant.SISSY_LONGLEGS] = {280, sewingMachineMod.sewnFamiliars.upSissyLonglegs},
    [FamiliarVariant.PUNCHING_BAG] = {281, sewingMachineMod.sewnFamiliars.upPunchingBag},
    [FamiliarVariant.CAINS_OTHER_EYE] = {319, sewingMachineMod.sewnFamiliars.upCainsOtherEye},
    [FamiliarVariant.BLUEBABYS_ONLY_FRIEND] = {320, sewingMachineMod.sewnFamiliars.upBlueBabysOnlyFriend},
    [FamiliarVariant.SAMSONS_CHAINS] = {321, sewingMachineMod.sewnFamiliars.upSamsonsChains},
    [FamiliarVariant.MONGO_BABY] = {322, sewingMachineMod.sewnFamiliars.upMongoBaby},
    [FamiliarVariant.FATES_REWARD] = {361, sewingMachineMod.sewnFamiliars.upFatesReward},
    [FamiliarVariant.SWORN_PROTECTOR] = {363, sewingMachineMod.sewnFamiliars.upSwornProtector},
    [FamiliarVariant.FRIEND_ZONE] = {364, sewingMachineMod.sewnFamiliars.upFlies},
    [FamiliarVariant.LOST_FLY] = {365, sewingMachineMod.sewnFamiliars.upFlies},
    [FamiliarVariant.LIL_GURDY] = {384, sewingMachineMod.sewnFamiliars.upLilGurdy},
    [FamiliarVariant.CENSER] = {387, sewingMachineMod.sewnFamiliars.upCenser},
    [FamiliarVariant.SERAPHIM] = {390, sewingMachineMod.sewnFamiliars.upSeraphim},
    [FamiliarVariant.SPIDER_MOD] = {403, sewingMachineMod.sewnFamiliars.upSpiderMod},
    [FamiliarVariant.FARTING_BABY] = {404, sewingMachineMod.sewnFamiliars.upFartingBaby},
    [FamiliarVariant.OBSESSED_FAN] = {426, sewingMachineMod.sewnFamiliars.upFlies},
    [FamiliarVariant.PAPA_FLY] = {430, sewingMachineMod.sewnFamiliars.upPapaFly},
    [FamiliarVariant.LIL_LOKI] = {435, sewingMachineMod.sewnFamiliars.upLilLoki},
    [FamiliarVariant.MILK] = {436, sewingMachineMod.sewnFamiliars.upMilk},
    [FamiliarVariant.DEPRESSION] = {469, sewingMachineMod.sewnFamiliars.upDepression},
    [FamiliarVariant.HUSHY] = {470, sewingMachineMod.sewnFamiliars.upHushy},
    [FamiliarVariant.LIL_MONSTRO] = {471, sewingMachineMod.sewnFamiliars.upLilMonstro},
    [FamiliarVariant.KING_BABY] = {472, sewingMachineMod.sewnFamiliars.upKingBaby},
    [FamiliarVariant.BLOODSHOT_EYE] = {509, sewingMachineMod.sewnFamiliars.upBloodshotEye},
    [FamiliarVariant.BUDDY_IN_A_BOX] = {518, sewingMachineMod.sewnFamiliars.upBuddyInABox},
    [FamiliarVariant.LIL_HARBINGERS] = {526, sewingMachineMod.sewnFamiliars.upLilHarbingers},
    [FamiliarVariant.ANGELIC_PRISM] = {528, sewingMachineMod.sewnFamiliars.upAngelicPrism},
    [FamiliarVariant.LIL_SPEWER] = {537, sewingMachineMod.sewnFamiliars.upLilSpewer},
    [FamiliarVariant.SLIPPED_RIB] = {542, sewingMachineMod.sewnFamiliars.upSlippedRib},
    [FamiliarVariant.HALLOWED_GROUND] = {543, sewingMachineMod.sewnFamiliars.upHallowedGround},
    [FamiliarVariant.POINTY_RIB] = {544, sewingMachineMod.sewnFamiliars.upPointyRib},
    [FamiliarVariant.JAW_BONE] = {548, sewingMachineMod.sewnFamiliars.upJawBone}
}

__require("sewn_scripts.descriptions")

---------------
-- Syringes! --
---------------

if M_SYR ~= nil then
    __require("sewn_scripts.syringe")
end

------------------
-- Encyclopedia --
------------------

if Encyclopedia ~= nil then
    __require("sewn_scripts.encyclopedia")
end

-------------------------------
-- External Item Description --
-------------------------------

if EID then
    -- EID Collectibles
    EID:addCollectible(CollectibleType.COLLECTIBLE_SEWING_BOX, "Upgrade every familiars from normal to super, or super to ultra form#Using it twice in a room will upgrade familiars twice#Ultra familiars can't be upgraded")
    EID:addCollectible(CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD, "Every familiars will be SUPER#With Doll's Pure Body every familiars will be ULTRA#Has a chance to spawn a Sewing machine in Devil rooms {{DevilRoom}}")
    EID:addCollectible(CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY, "Every familiars will be SUPER#With Doll's Tainted Head every familiars will be ULTRA#Has a chance to spawn a Sewing machine in Angel rooms {{AngelRoom}}")

    -- EID Trinkets
    EID:addTrinket(TrinketType.TRINKET_THIMBLE, "Have a 50% chance to upgrade a familiar for free")
    EID:addTrinket(TrinketType.TRINKET_CRACKED_THIMBLE, "Reroll familiars crowns when getting hit")
    EID:addTrinket(TrinketType.TRINKET_LOST_BUTTON, "100% chance to spawn sewing machine in Shops for next floors")
    EID:addTrinket(TrinketType.TRINKET_CONTRASTED_BUTTON, "50% chance to find a sewing machine in angel rooms {{AngelRoom}} or devil rooms {{DevilRoom}}")
    EID:addTrinket(TrinketType.TRINKET_PIN_CUSHION, "Interacting with the machine gives the familiar back#It allow the player to choose the familiar he want to upgrade#Can be easily dropped by pressing the drop button")

    -- EID Cards
    EID:addCard(Card.CARD_WARRANTY, "Spawn a sewing machine#The Sewing machine change depending on the room type")
    EID:addCard(Card.CARD_STITCHING, "Reroll familiar crowns")
end


function sewingMachineMod:isAvailable(familiarVariant)
    return sewingMachineMod.availableFamiliar[familiarVariant] ~= nil
end
function sewingMachineMod:makeFamiliarAvailable(familiarVariant, collectibleID, _function)
    if familiarVariant ~= nil then
        sewingMachineMod.availableFamiliar[familiarVariant] = {}
        if collectibleID ~= nil then
            sewingMachineMod.availableFamiliar[familiarVariant][1] = collectibleID
        else
            sewingMachineMod.availableFamiliar[familiarVariant][1] = -1
        end
        sewingMachineMod.availableFamiliar[familiarVariant][2] = _function
    end
end
function sewingMachineMod:getFamiliarUpgradeFunction(familiarVariant)
    if familiarVariant ~= nil then
        if sewingMachineMod.availableFamiliar[familiarVariant] ~= nil then
            return sewingMachineMod.availableFamiliar[familiarVariant][2]
        end
    end
end
function sewingMachineMod:callFamiliarUpgrade(familiar)
    if sewingMachineMod:getFamiliarUpgradeFunction(familiar.Variant) ~= nil then
        local f = {}
        f._function = sewingMachineMod:getFamiliarUpgradeFunction(familiar.Variant)
        f:_function(familiar)
        familiar:GetData().Sewn_crown = nil
    end
end
function sewingMachineMod:getFamiliarItemGfx(familiarVariant)
    local curse = sewingMachineMod.currentLevel:GetCurses()
    if curse == LevelCurse.CURSE_OF_BLIND then
        familiarVariant = nil
    end
    -- Shuffle sprite - not used now
    --if curse == LevelCurse.CURSE_OF_THE_UNKNOWN then
    --    local keyset = {}
    --    for k in pairs(sewingMachineMod.availableFamiliar) do
    --        table.insert(keyset, k)
    --    end
    --    familiarVariant = keyset[sewingMachineMod.rng:RandomInt(#keyset) + 1]
    --end
    if familiarVariant ~= nil and sewingMachineMod.availableFamiliar[familiarVariant] ~= nil then
        local collectible = Isaac.GetItemConfig():GetCollectible(sewingMachineMod.availableFamiliar[familiarVariant][1])
        if collectible ~= nil then
            return collectible.GfxFileName
        end
    end
    return "gfx/items/collectibles/questionmark.png"
end

function sewingMachineMod:rerollFamilarsCrowns(player)
    local pData = player:GetData()

    local allowedFamiliars = {}
    local countCrowns = 0

    for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
        local fData = familiar:GetData()
        familiar = familiar:ToFamiliar()

        if fData.Sewn_upgradeState == nil then
            fData.Sewn_upgradeState = 0
        end

        if GetPtrHash(familiar.Player) == GetPtrHash(player) and sewingMachineMod:isAvailable(familiar.Variant) then
            table.insert(allowedFamiliars, familiar)
            countCrowns = countCrowns + fData.Sewn_upgradeState
            fData.Sewn_upgradeState = sewingMachineMod.UpgradeState.NORMAL

            --table.insert(pData.Sewn_familiars, familiars[familiar_index])

            sewingMachineMod:resetFamiliarData(familiar)
        end
    end
    while #allowedFamiliars > 0 and countCrowns > 0 do
        local familiar_index = math.random(#allowedFamiliars) -- sewingMachineMod.rng:RandomInt(#familiars) + 1
        local fData = allowedFamiliars[familiar_index]:GetData()
        if not sewingMachineMod:isUltra(fData) then
            fData.Sewn_upgradeState = fData.Sewn_upgradeState + 1
            countCrowns = countCrowns -1

            sewingMachineMod:callFamiliarUpgrade(allowedFamiliars[familiar_index])
        end
        if sewingMachineMod:isUltra(fData) then
            table.remove(allowedFamiliars, familiar_index)
            --table.remove(player:GetData().Sewn_familiars, familiars[familiar_index])
        end
    end
end

function sewingMachineMod:temporaryUpgradeFamiliar(familiar)
    local fData = familiar:GetData()
    if sewingMachineMod:isAvailable(familiar.Variant) and not sewingMachineMod:isUltra(fData) then
        sewingMachineMod:resetFamiliarData(familiar, {"Sewn_upgradeState_temporary"})
        if fData.Sewn_upgradeState_temporary == nil then
            if fData.Sewn_upgradeState == nil then
                fData.Sewn_upgradeState = 0
            end
            fData.Sewn_upgradeState_temporary = fData.Sewn_upgradeState + 1
        else
            fData.Sewn_upgradeState_temporary = fData.Sewn_upgradeState_temporary + 1
        end
        sewingMachineMod:callFamiliarUpgrade(familiar)
    end
end

-- Code given by Xalum
function GetPlayerUsingItem()
    local player = Isaac.GetPlayer(0)
    for i = 1, Game():GetNumPlayers() do
        local p = Isaac.GetPlayer(i - 1)
         if Input.IsActionTriggered(ButtonAction.ACTION_ITEM, p.ControllerIndex) or Input.IsActionTriggered(ButtonAction.ACTION_PILLCARD, p.ControllerIndex) then
            player = p
            break
        end
    end
    return player
end




function sewingMachineMod:delayFunction(functionToDelay, delay, param)
    if functionToDelay ~= nil and delay ~= nil then
        local data = {FUNCTION = functionToDelay, DELAY = delay, FRAME = game:GetFrameCount(), PARAM = param}
        table.insert(sewingMachineMod.delayedFunctions, data)
    end
end

-- Remove every Sewing Machines and spawn an new one
function sewingMachineMod:spawnMachine(position, playAppearAnim, machineSubType)
    local room = sewingMachineMod.currentRoom
    local subType

    if InfinityTrueCoopInterface ~= nil and sewingMachineMod.Config.TrueCoop_removeMachine then
        return
    end

    if StageAPI and StageAPI.InExtraRoom then
        return
    end

    if position == nil then
        position = room:FindFreePickupSpawnPosition(room:GetGridPosition(27), 0, true)
    end

    if machineSubType == nil then
        if room:GetType() == RoomType.ROOM_ISAACS or room:GetType() == RoomType.ROOM_BARREN then
            subType = sewingMachineMod.SewingMachineSubType.BEDROOM
        elseif room:GetType() == RoomType.ROOM_SHOP then
            subType = sewingMachineMod.SewingMachineSubType.SHOP
        elseif room:GetType() == RoomType.ROOM_ANGEL then
            subType = sewingMachineMod.SewingMachineSubType.ANGELIC
        elseif room:GetType() == RoomType.ROOM_DEVIL then
            subType = sewingMachineMod.SewingMachineSubType.EVIL
        else
            if sewingMachineMod.rng:RandomInt(2) == 0 then
                subType = sewingMachineMod.SewingMachineSubType.BEDROOM
            else
                subType = sewingMachineMod.SewingMachineSubType.SHOP
            end
        end
    else
        subType = machineSubType
    end

    local machine = Isaac.Spawn(EntityType.ENTITY_SLOT, sewingMachineMod.SewingMachine, subType, position, v0, nil)
    if playAppearAnim == true then
        machine:GetSprite():Play("Appear", true)
    end

    return machine
end

-- return a table with all the Sewing machines (normally the max amount of machine is one per rooms)
function sewingMachineMod:getAllSewingMachines()
    local allSewingMachine = {}
    for _, machine in pairs(Isaac.FindByType(EntityType.ENTITY_SLOT, sewingMachineMod.SewingMachine, -1, false, true)) do
        if sewingMachineMod.sewingMachinesData[machine.InitSeed] == nil then
            sewingMachineMod.sewingMachinesData[machine.InitSeed] = {}
        end
        table.insert(allSewingMachine, machine)
    end
    return allSewingMachine
    --return Isaac.FindByType(EntityType.ENTITY_SLOT, sewingMachineMod.SewingMachine, -1, false, true)
end

-- Return true if the given familiar is SUPER, false otherwise
function sewingMachineMod:isSuper(fData)
    if fData.Sewn_upgradeState_temporary ~= nil then
        return fData.Sewn_upgradeState_temporary == sewingMachineMod.UpgradeState.SUPER
    end
    return fData.Sewn_upgradeState == sewingMachineMod.UpgradeState.SUPER
end
-- Return true if the given familiar is ULTRA, false otherwise
function sewingMachineMod:isUltra(fData)
    if fData.Sewn_upgradeState_temporary ~= nil then
        return fData.Sewn_upgradeState_temporary == sewingMachineMod.UpgradeState.ULTRA
    end
    return fData.Sewn_upgradeState == sewingMachineMod.UpgradeState.ULTRA
end

-- Called after getting a familiar back, increase the machine counter and break machine depending on a roll
function sewingMachineMod:breakMachine(machine, isUpgrade)
    local roll = sewingMachineMod.rng:RandomInt(101)
    local mData = sewingMachineMod.sewingMachinesData[machine.InitSeed]
    local additionalBreackChance = 0

    if mData.Sewn_machineUsed_counter == nil then
        mData.Sewn_machineUsed_counter = 0
    end

    if isUpgrade then
        mData.Sewn_machineUsed_counter = mData.Sewn_machineUsed_counter + 1
        if machine.SubType == sewingMachineMod.SewingMachineSubType.ANGELIC then
            mData.Sewn_machineUsed_counter = mData.Sewn_machineUsed_counter + 1
            additionalBreackChance = 25
        end
    end

    -- Chance to break
    if roll < mData.Sewn_machineUsed_counter * 5 + additionalBreackChance then
        local rollTrinket = sewingMachineMod.rng:RandomInt(101)

        if machine.SubType == sewingMachineMod.SewingMachineSubType.ANGELIC or machine.SubType == sewingMachineMod.SewingMachineSubType.EVIL then
            mData.Sewn_isMachineBroken = true
            machine:GetSprite():Play("Disappear")
        else
            Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BOMB_EXPLOSION, 0, machine.Position, v0, nil)
            mData.Sewn_isMachineBroken = true
            if rollTrinket < 5 then
                local rollTrinket = sewingMachineMod.rng:RandomInt(#trinketSewingMachine) + 1
                local trinket = trinketSewingMachine[rollTrinket]
                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, trinket, machine.Position + Vector(0,15), Vector(0,2):Rotated(math.random(-45,45)), machine)
            end
            machine:TakeDamage(100, DamageFlag.DAMAGE_EXPLOSION, EntityRef(machine), 1)
            mData.Sewn_isMachineBroken = true
            --sewingMachineMod.sewingMachinesData[machine.InitSeed] = nil
        end
    end
end

-- Called when a player interact a second time with a Sewing Machine, or when a sewing machine is bombed
function sewingMachineMod:getFamiliarBack(machine, isUpgrade)
    local mData = sewingMachineMod.sewingMachinesData[machine.InitSeed]
    local sewnFamiliar
    local hasPinCushion = mData.Sewn_player:HasTrinket(TrinketType.TRINKET_PIN_CUSHION) and true

    mData.Sewn_player:GetData().Sewn_familiarsInMachine[machine.InitSeed] = nil

    -- Evaluate the cache to properly respawn familiars
    mData.Sewn_player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
    mData.Sewn_player:EvaluateItems()

    for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, mData.Sewn_currentFamiliarVariant, -1, false, false)) do
        if familiar.FrameCount == 0 then
            sewnFamiliar = familiar:ToFamiliar()
            sewnFamiliar:GetData().Sewn_upgradeState = mData.Sewn_currentFamiliarState
            if sewnFamiliar:GetData().Sewn_player == nil then
                sewnFamiliar.Player = mData.Sewn_player
            end
        end
    end

    if sewnFamiliar == nil then
        return
    end

    -- Play the normal animation (without the floating familiar)
    machine:GetSprite():Play("Idle")

    sewnFamiliar:GetData().Sewn_collisionDamage = mData.Sewn_currentFamiliarCollisionDamage
    sewnFamiliar:GetData().Sewn_familiarReady = true

    -- Upgrade the familiar
    if isUpgrade then
        local fData = sewnFamiliar:GetData()
        sewingMachineMod:payCost(machine, mData.Sewn_player)
        sewnFamiliar:GetData().Sewn_upgradeState = sewnFamiliar:GetData().Sewn_upgradeState + 1
        if machine.SubType == sewingMachineMod.SewingMachineSubType.EVIL and not sewingMachineMod:isUltra(fData) then
            fData.Sewn_upgradeState = fData.Sewn_upgradeState + 1
        end
        -- Change familiar's data to prepare stats upgrade
        sewingMachineMod:callFamiliarUpgrade(sewnFamiliar)
    end


    -- Reset the machine data to nil
    mData.Sewn_currentFamiliarState = nil
    mData.Sewn_currentFamiliarVariant = nil
    mData.Sewn_player:GetData().Sewn_machine_upgradeFree = nil
    mData.Sewn_player = nil

    -- Remove description
    sewingMachineMod.currentUpgradeInfo = nil

    if not sewingMachineMod:isUltra(sewnFamiliar:GetData()) then
        table.insert(sewnFamiliar.Player:GetData().Sewn_familiars, sewnFamiliar)
    end
    -- Do not break the machine with Pin Cushion
    if not hasPinCushion then
        sewingMachineMod:breakMachine(machine, isUpgrade)
    end
    sewingMachineMod:updateSewingMachineDescription(machine)
end

-- Called when a player touch a Sewing Machine (and there is no familiar in it)
function sewingMachineMod:addFamiliarInMachine(machine, player)
    local mData = sewingMachineMod.sewingMachinesData[machine.InitSeed]
    local pData = player:GetData()
    local roll = sewingMachineMod.rng:RandomInt(#player:GetData().Sewn_familiars) + 1

    -- Select a random familiar which can be upgradable
    mData.Sewn_currentFamiliarVariant = player:GetData().Sewn_familiars[roll].Variant
    -- Tell the machine the upgrade state of the familiar
    mData.Sewn_currentFamiliarState = player:GetData().Sewn_familiars[roll]:GetData().Sewn_upgradeState or 0
    -- Tell the machine who is the player who add the familiar in the machine
    mData.Sewn_player = player
    -- Store collision damage of the familiar
    mData.Sewn_currentFamiliarCollisionDamage = player:GetData().Sewn_familiars[roll]:GetData().Sewn_collisionDamage


    -- Replace the sprite with the familiar (the sprite is the image of the collectible, not the familiar itself)
    sewingMachineMod:setFloatingAnim(machine)

    -- Remove the familiar from Isaac
    if pData.Sewn_familiarsInMachine == nil then
        pData.Sewn_familiarsInMachine = {}
    end

    pData.Sewn_familiarsInMachine[machine.InitSeed] = pData.Sewn_familiars[roll].Variant

    sewingMachineMod:updateSewingMachineDescription(machine)
    pData.Sewn_familiars[roll]:Remove()

    -- Update description
    sewingMachineMod.currentUpgradeInfo = machine

    table.remove(player:GetData().Sewn_familiars, roll)
end

-- Link the familiar description to the machine
function sewingMachineMod:updateSewingMachineDescription(machine)

    if EID == nil then return end

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
    local color = EID.InlineColors["SewnColor_"..info.name] ~= nil and "{{SewnColor_"..info.name .. "}}" or ""
    
    machine:GetData()["EID_Description"] = {
        --["Name"] = "{{SewnCrown" .. levelCrown .. "}}{{SewnColor_"..info.name .. "}} " .. info.name .." {{SewnSewingMachine}}",
        ["Name"] = color .. "{{SewnCrown" .. levelCrown .. "}}" .. info.name .." {{SewnSewingMachine}}",
        ["Description"] = upgradeDescription
    }
    sewingMachineMod.sewingMachinesData[machine.InitSeed]["EID_Description"] = machine:GetData()["EID_Description"]
end

function sewingMachineMod:setFloatingAnim(machine)
    local mData = sewingMachineMod.sewingMachinesData[machine.InitSeed]
    machine:GetSprite():ReplaceSpritesheet(1, sewingMachineMod:getFamiliarItemGfx(mData.Sewn_currentFamiliarVariant))
    machine:GetSprite():Play("IdleFloating")
    machine:GetSprite():LoadGraphics()
end

-- Return boolean : true if the player has enough money/hearts to pay
function sewingMachineMod:canPayCost(machine, player)
    if player:GetData().Sewn_machine_upgradeFree == true then
        return true
    end
    if machine.SubType == sewingMachineMod.SewingMachineSubType.BEDROOM then
        return player:GetSoulHearts() >= sewingMachineMod.SewingMachineCost.BEDROOM
    elseif machine.SubType == sewingMachineMod.SewingMachineSubType.SHOP then
        local cost = sewingMachineMod.SewingMachineCost.SHOP
        if player:HasCollectible(CollectibleType.COLLECTIBLE_STEAM_SALE) then
            cost = sewingMachineMod.SewingMachineCost.SHOP_SALE
        end
        return player:GetNumCoins() >= cost
    elseif machine.SubType == sewingMachineMod.SewingMachineSubType.ANGELIC then
        return true
    elseif machine.SubType == sewingMachineMod.SewingMachineSubType.EVIL then
        return player:GetMaxHearts() >= sewingMachineMod.SewingMachineCost.EVIL
    end
end

function sewingMachineMod:payCost(machine, player)
    if player:GetData().Sewn_machine_upgradeFree == true then
        return
    end
    if machine.SubType == sewingMachineMod.SewingMachineSubType.BEDROOM then
        player:AddSoulHearts(-sewingMachineMod.SewingMachineCost.BEDROOM)
    elseif machine.SubType == sewingMachineMod.SewingMachineSubType.SHOP then
        local cost = sewingMachineMod.SewingMachineCost.SHOP
        if player:HasCollectible(CollectibleType.COLLECTIBLE_STEAM_SALE) then
            cost = sewingMachineMod.SewingMachineCost.SHOP_SALE
        end
        player:AddCoins(-cost)
    elseif machine.SubType == sewingMachineMod.SewingMachineSubType.ANGELIC then

    elseif machine.SubType == sewingMachineMod.SewingMachineSubType.EVIL then
        player:AddMaxHearts(-sewingMachineMod.SewingMachineCost.EVIL, false)
    end

    if player:GetHearts() + player:GetSoulHearts() == 0 then
        if player:GetPlayerType() ~= PlayerType.PLAYER_THESOUL then
            player:Kill()
        end
    end
end

function sewingMachineMod:hideCrown(familiar, hideCrown)
    local fData = familiar:GetData()
    if hideCrown == nil then
        hideCrown = true
    end
    fData.Sewn_crown_hide = hideCrown
end

function sewingMachineMod:addCrownOffset(familiar, offset)
    local fData = familiar:GetData()
    -- If offset isn't a Vector -> return
    if offset == nil or offset.X == nil or offset.Y == nil then return end
    fData.Sewn_crownPositionOffset = offset
end

function sewingMachineMod:removeDollsTaintedHead()
    for _, dollsHead in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.DOLL_S_TAINTED_HEAD, -1, false, false)) do
        dollsHead:Remove()
    end
end

function sewingMachineMod:removeDollsPureBody()
    for _, dollsBody in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.DOLL_S_PURE_BODY, -1, false, false)) do
        dollsBody:Remove()
    end
end


----------------------------
-- MC_POST_PEFFECT_UPDATE --
----------------------------
function sewingMachineMod:onPlayerUpdate(player)
    local pData = player:GetData()

    -- Prepare proper sewingMachineMod.rng
    sewingMachineMod.rng:SetSeed(game:GetSeeds():GetStartSeed() + game:GetFrameCount(), 1)

    if pData.Sewn_familiars == nil then
        pData.Sewn_familiars = {}
    end

    sewingMachineMod.currentUpgradeInfo = nil

    -- Loop through all Sewing machines to detect interactions
    for _, machine in pairs(sewingMachineMod:getAllSewingMachines()) do

        if InfinityTrueCoopInterface ~= nil then
            sewingMachineMod.displayTrueCoopMessage = true
            return
        end

        local mData = sewingMachineMod.sewingMachinesData[machine.InitSeed]

        if mData == nil then
            sewingMachineMod.sewingMachinesData[machine.InitSeed] = {}
            mData = sewingMachineMod.sewingMachinesData[machine.InitSeed]
        end

        -- If the machine isn't broken
        if mData.Sewn_isMachineBroken ~= true then
            -- When player touch a Sewing machine
            if (machine.Position - player.Position):Length() < machine.Size + player.Size and (mData.Sewn_lastTouched == nil or mData.Sewn_lastTouched < game:GetFrameCount() - 15) then
                -- If the player who put the familiar in the machine is the same as the one who try to get the familiar back
                if mData.Sewn_player == nil or GetPtrHash(mData.Sewn_player) == GetPtrHash(player) then

                    -- Prevent the player to touch the machine twice in a short laps of time
                    mData.Sewn_lastTouched = game:GetFrameCount()

                    if pData.Sewn_machine_upgradeFree == nil then
                        pData.Sewn_machine_upgradeFree = false
                        if player:HasTrinket(TrinketType.TRINKET_THIMBLE) and sewingMachineMod.rng:RandomInt(101) < 50 then
                            pData.Sewn_machine_upgradeFree = true
                        end
                    end

                    --if mData.Sewn_currentFamiliarVariant ~= nil and player:HasTrinket(TrinketType.TRINKET_PIN_CUSHION) then
                    if mData.Sewn_currentFamiliarVariant ~= nil and (player:GetTrinket(0) == TrinketType.TRINKET_PIN_CUSHION or player:GetTrinket(1) == TrinketType.TRINKET_PIN_CUSHION) then
                        -- If the player has the Pin Cushion trinket : Get back for free the familiar
                        sewingMachineMod:getFamiliarBack(machine, false)
                    elseif mData.Sewn_currentFamiliarVariant ~= nil and sewingMachineMod:canPayCost(machine, player) then
                        -- If there is a familiar in the machine and the player can pay for it
                        sewingMachineMod:getFamiliarBack(machine, true)
                    elseif mData.Sewn_currentFamiliarVariant == nil and #player:GetData().Sewn_familiars > 0 then
                        -- If there is no familiar in the machine and player has available familiars to put in
                        sewingMachineMod:addFamiliarInMachine(machine, player)
                    end
                end
            end

            if (machine.Position - player.Position):LengthSquared() < 100 ^ 2 then
                if sewingMachineMod.currentUpgradeInfo == nil then
                    sewingMachineMod.currentUpgradeInfo = machine
                end
            end

            if player:HasCollectible(CollectibleType.COLLECTIBLE_STEAM_SALE) then
                if machine.SubType == sewingMachineMod.SewingMachineSubType.SHOP and machine:GetData().Sewn_underSale ~= true then
                    machine:GetSprite():ReplaceSpritesheet(0, "gfx/items/slots/slot_sewingmachine_sales.png")
                    machine:GetSprite():LoadGraphics()
                    machine:GetData().Sewn_underSale = true
                end
            end
        end
    end
    -- Spawn the pin cushion trinket when pressing the drop button
    if player:HasTrinket(TrinketType.TRINKET_PIN_CUSHION) and Input.IsActionPressed(ButtonAction.ACTION_DROP, player.ControllerIndex) then
        player:DropTrinket(player.Position, false);
    end

    if player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) and not pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_BFFS] then
        for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
            local fData = familiar:GetData()
            fData.Sewn_collisionDamage = fData.Sewn_collisionDamage * 2
        end
        pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_BFFS] = true
    end
    if not player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) and pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_BFFS] then
        for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
            local fData = familiar:GetData()
            fData.Sewn_collisionDamage = fData.Sewn_collisionDamage / 2
        end
        pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_BFFS] = nil
    end

end
---------------------------------------
-- MC_ENTITY_TAKE_DMG - EntityPlayer --
---------------------------------------
function sewingMachineMod:playerTakeDamage(player, damageAmount, damageFlags, damageSource, damageCountdownFrames)
    local countCrowns = 0
    local allowedFamiliars = {}
    player = player:ToPlayer()
    if player:HasTrinket(TrinketType.TRINKET_CRACKED_THIMBLE) then
        sewingMachineMod:rerollFamilarsCrowns(player)
    end
    for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
        local fData = familiar:GetData()
        familiar = familiar:ToFamiliar()
        if fData.Sewn_custom_playerTakeDamage ~= nil then
            local d = {}
            for i, f in ipairs(fData.Sewn_custom_playerTakeDamage) do
                return f(_, familiar, damageSource, damageAmount, damageFlags)
            end
        end
    end
end
-----------------------
-- MC_EVALUATE_CACHE --
-----------------------
function sewingMachineMod:onCacheFamiliars(player, cacheFlag)
    local pData = player:GetData()

    if pData.Sewn_hasItem == nil then
        pData.Sewn_hasItem = {}
    end

    if cacheFlag == CacheFlag.CACHE_FAMILIARS then
        -- Remove familiars which are supposed to be in the machine
        if pData.Sewn_familiarsInMachine ~= nil then
            for machineIndex, sewnFamiliarVariant in pairs(pData.Sewn_familiarsInMachine) do
                local fams = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, sewnFamiliarVariant, -1, false, false)


                fams[#fams]:Remove()
            end
        end

        -- Player get "Doll's Tainted Head"
        if player:HasCollectible(CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD) and not pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD] then
            if not pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY] then
                local dollsHead = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.DOLL_S_TAINTED_HEAD, 0, player.Position, v0, player):ToFamiliar()
                dollsHead:AddToFollowers()
            end
            -- Upgrade familiars
            for _, fam in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
                local fData = fam:GetData()
                if fData.Sewn_upgradeState == 0 and not player:HasCollectible(CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY) then
                    fData.Sewn_upgradeState = 1
                    sewingMachineMod:callFamiliarUpgrade(fam)
                elseif player:HasCollectible(CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY) and not sewingMachineMod:isUltra(fData) then
                    fData.Sewn_upgradeState = 2
                    sewingMachineMod:callFamiliarUpgrade(fam)
                end
            end
            pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD] = true
        end
        -- Player lose "Doll's Tainted Head"
        if not player:HasCollectible(CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD) and pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD] then
            sewingMachineMod:removeDollsTaintedHead()
            pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD] = false
        end


        -- Player get "Doll's Pure Body"
        if player:HasCollectible(CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY) and not pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY] then
            if not pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD] then
                local dollsBody = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.DOLL_S_PURE_BODY, 0, player.Position, v0, player):ToFamiliar()
                dollsBody:AddToFollowers()
            end
            -- Upgrade familiars
            for _, fam in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
                local fData = fam:GetData()
                if fData.Sewn_upgradeState == 0 and not player:HasCollectible(CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD) then
                    fData.Sewn_upgradeState = 1
                    sewingMachineMod:callFamiliarUpgrade(fam)
                elseif player:HasCollectible(CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD) and not sewingMachineMod:isUltra(fData) then
                    fData.Sewn_upgradeState = 2
                    sewingMachineMod:callFamiliarUpgrade(fam)
                end
            end
            pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY] = true
        end
        -- Player lose "Doll's Pure Body"
        if not player:HasCollectible(CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY) and pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY] then
            sewingMachineMod:removeDollsPureBody()
            pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY] = false
        end

        if player:HasCollectible(CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY) and player:HasCollectible(CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD) and not pData.Sewn_hasSewnDoll then
            local sewnDoll = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.SEWN_DOLL, 0, player.Position, v0, player):ToFamiliar()
            sewnDoll:AddToFollowers()
            sewingMachineMod:removeDollsTaintedHead()
            sewingMachineMod:removeDollsPureBody()
            pData.Sewn_hasSewnDoll = true
        end
    end

    for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
        familiar = familiar:ToFamiliar()
        if familiar.Player and GetPtrHash(familiar.Player) == GetPtrHash(player) then
            local fData = familiar:GetData()
            if fData.Sewn_custom_cache ~= nil then
                local d = {}
                for i, f in ipairs(fData.Sewn_custom_cache) do
                    f(_, familiar, cacheFlag)
                end
            end
        end
    end
end


-------------------------
-- MC_PRE_ENTITY_SPAWN --
-------------------------
function sewingMachineMod:entitySpawn(type, variant, subtype, pos, vel, spawner, seed)

    if sewingMachineMod.currentLevel == nil then 
        sewingMachineMod.currentLevel = game:GetLevel()
    end

    -- If a collectible spawn in the chest or in dark room
    if type == EntityType.ENTITY_PICKUP and variant == PickupVariant.PICKUP_COLLECTIBLE and sewingMachineMod.currentLevel:GetStage() == LevelStage.STAGE6 then
        for _, machine in pairs(sewingMachineMod:getAllSewingMachines()) do
            local mData = sewingMachineMod.sewingMachinesData[machine.InitSeed]
            if pos:DistanceSquared(machine.Position) == 0 and mData.Sewn_isMachineBroken ~= true then
                sewingMachineMod:ManageMachineDestuction(machine)
                return {1000, EffectVariant.EFFECT_NULL, 0}
            end
        end
    end

    -- Burning Farts effect
    if type == EntityType.ENTITY_EFFECT and variant == EffectVariant.FART and subtype == 75 then
        for _, npc in pairs(Isaac.FindInRadius(pos, 100, EntityPartition.ENEMY)) do
            if npc:IsVulnerableEnemy() then
                npc:TakeDamage(5, DamageFlag.DAMAGE_POISON_BURN, EntityRef(spawner), 5)
                npc:AddBurn(EntityRef(spawner), sewingMachineMod.rng:RandomInt(180) + 60, 3.5)
            end
        end
    end
end

---------------------------
-- MC_POST_EFFECT_UPDATE --
---------------------------
function sewingMachineMod:effectUpdate(effect)
    if effect.Variant == EffectVariant.SPIDER_MOD_EGG then
        local eData = effect:GetData()

        if effect.FrameCount >= 30 * 20 then -- Remove after 20 seconds
            effect:Remove()
            Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.TOOTH_PARTICLE, 0, effect.Position, v0, nil)
        end

        for _, npc in pairs(Isaac.FindInRadius(effect.Position, effect.Size, EntityPartition.ENEMY)) do
            if npc:IsVulnerableEnemy() then
                if eData.Sewn_spidermod_eggColliderCooldown[GetPtrHash(npc)] == nil or eData.Sewn_spidermod_eggColliderCooldown[GetPtrHash(npc)] + 90 < game:GetFrameCount() then
                    local roll = sewingMachineMod.rng:RandomInt(8)
                    local rollDuration = sewingMachineMod.rng:RandomInt(60) + 30
                    if roll == 0 then
                        npc:AddPoison(EntityRef(egg), rollDuration, 3.5)
                    elseif roll == 1 then
                        npc:AddFreeze(EntityRef(egg), rollDuration)
                    elseif roll == 2 then
                        npc:AddSlowing(EntityRef(egg), rollDuration, 1, Color(1,1,1,1,0,0,0))
                    elseif roll == 3 then
                        npc:AddCharmed(rollDuration)
                    elseif roll == 4 then
                        npc:AddConfusion(EntityRef(egg), rollDuration, false)
                    elseif roll == 5 then
                        npc:AddFear(EntityRef(egg), rollDuration)
                    elseif roll == 6 then
                        npc:AddBurn(EntityRef(egg), rollDuration, 3.5)
                    elseif roll == 7 then
                        npc:AddShrink(EntityRef(egg), rollDuration)
                    end
                    eData.Sewn_spidermod_eggColliderCooldown[GetPtrHash(npc)] = game:GetFrameCount()
                end
            end
        end
    end
end

------------------------
-- MC_ENTITY_TAKE_DMG --
------------------------
function sewingMachineMod:entityTakeDamage(entity, amount, flags, source, countdown)
    if source.Entity ~= nil and source.Type == EntityType.ENTITY_FAMILIAR and entity:IsVulnerableEnemy() then
        for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
            local fData = familiar:GetData()
            familiar = familiar:ToFamiliar()
            if source.Entity ~= nil and GetPtrHash(source.Entity) == GetPtrHash(familiar) then
                local d = {}
                if fData.Sewn_custom_hitEnemy ~= nil then
                    for i, f in ipairs(fData.Sewn_custom_hitEnemy) do
                        local getDamage = f(_, familiar, entity)
                        if getDamage == false then return
                            false
                        end
                    end
                end
                if fData.Sewn_custom_killEnemy ~= nil and entity.HitPoints - amount <= 0 then
                    for i, f in ipairs(fData.Sewn_custom_killEnemy) do
                        f(_, familiar, entity)
                    end
                end
            end
        end
    end
end


function sewingMachineMod:hideCrown(familiar, hideCrown)
    local fData = familiar:GetData()
    if hideCrown == nil then
        hideCrown = true
    end
    fData.Sewn_crown_hide = hideCrown
end
function sewingMachineMod:addCrownOffset(familiar, offset)
    local fData = familiar:GetData()
    -- If offset isn't a Vector -> return
    if offset == nil or offset.X == nil or offset.Y == nil then return end
    fData.Sewn_crownPositionOffset = offset
end



------------------------
-- MC_FAMILIAR_UPDATE --
------------------------
function sewingMachineMod:updateFamiliar(familiar)
    local fData = familiar:GetData()

    -- We do nothing with blue flies and blue spiders
    if familiar.Variant == FamiliarVariant.BLUE_FLY or familiar.Variant == FamiliarVariant.BLUE_SPIDER then
        return
    end

    -- INIT
    -- I use MC_FAMILIAR_UPDATE because MC_FAMILIAR_INIT is broken, and doesn't work well with most of familiars
    if not familiar:GetData().Sewn_Init and familiar.FrameCount > 0 then
        local player = familiar.Player

        if sewingMachineMod:isAvailable(familiar.Variant) then
            if not sewingMachineMod:isUltra(fData) or fData.Sewn_upgradeState == nil then
                -- Set the familiar as an available familiar (available for the Sewing machine)
                if familiar:GetData().Sewn_noUpgrade ~= true then
                    
                    -- Add the familiar to the "Temporary Familiars" table
                    temporaryFamiliars[GetPtrHash(familiar)] = familiar
                end
            end
        end
        if fData.Sewn_upgradeState == nil then
            local hasDollsHead = player:HasCollectible(CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD)
            local hasDollsBody = player:HasCollectible(CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY)
            if hasDollsHead and not hasDollsBody or not hasDollsHead and hasDollsBody then
                fData.Sewn_upgradeState = sewingMachineMod.UpgradeState.SUPER
                sewingMachineMod:callFamiliarUpgrade(familiar)
            elseif hasDollsHead and hasDollsBody then
                fData.Sewn_upgradeState = sewingMachineMod.UpgradeState.ULTRA
                sewingMachineMod:callFamiliarUpgrade(familiar)
            else
                fData.Sewn_upgradeState = sewingMachineMod.UpgradeState.NORMAL
            end
        end

        if player ~= nil and player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
            fData.Sewn_collisionDamage = familiar.CollisionDamage / 2 or 0
        else
            fData.Sewn_collisionDamage = familiar.CollisionDamage or 0
        end
        fData.Sewn_Init = true
    end

    -- If a player is close from the machine
    if sewingMachineMod.currentUpgradeInfo ~= nil then
        local fColor = familiar:GetColor()
        
        -- Available familiars
        if sewingMachineMod:isAvailable(familiar.Variant) and not sewingMachineMod:isUltra(fData) then
            if sewingMachineMod.Config.familiarAllowedEffect == sewingMachineMod.CONFIG_CONSTANT.ALLOWED_FAMILIARS_EFFECT.BLINK then
                local c = 255-math.floor(255*((familiar.FrameCount%40)/40))
                familiar:SetColor(Color(fColor.R,fColor.G,fColor.B,fColor.A,c,c,c),5,1,false,false)
            end

            -- Familiar which aren't ready
            if not fData.Sewn_familiarReady and fData.Sewn_noUpgrade ~= true then
                if familiar.FrameCount < 30 * 10 + 1 and not fData.Sewn_notReady_clock then
                    fData.Sewn_notReady_clock = Sprite()
                    fData.Sewn_notReady_clock:Load("gfx/familiarNotReady.anm2", false)
                    fData.Sewn_notReady_clock:Play("Clock")
                    fData.Sewn_notReady_clock:LoadGraphics()
                elseif familiar.FrameCount > 30 * 10 + 1 and fData.Sewn_notReady_clock then
                    fData.Sewn_notReady_clock = nil
                end
                if not fData.Sewn_newRoomVisited and not fData.Sewn_notReady_door then
                    fData.Sewn_notReady_door = Sprite()
                    fData.Sewn_notReady_door:Load("gfx/familiarNotReady.anm2", false)
                    fData.Sewn_notReady_door:Play("Door")
                    fData.Sewn_notReady_door:LoadGraphics()
                elseif fData.Sewn_newRoomVisited and fData.Sewn_notReady_clock then
                    fData.Sewn_notReady_door = nil
                end
            end
        end
        -- Not available familiars
        if not sewingMachineMod:isAvailable(familiar.Variant) or sewingMachineMod:isUltra(fData) then
            if sewingMachineMod.Config.familiarNotAllowedEffect == sewingMachineMod.CONFIG_CONSTANT.NOT_ALLOWED_FAMILIARS_EFFECT.TRANSPARENT then
                familiar:SetColor(Color(fColor.R,fColor.G,fColor.B,0.5,fColor.RO,fColor.GO,fColor.BO),5,1,false,false)
            end
        end
    else
        fData.Sewn_notReady_clock = nil
        fData.Sewn_notReady_door = nil
    end

    if familiar.Variant == FamiliarVariant.DOLL_S_TAINTED_HEAD or familiar.Variant == FamiliarVariant.DOLL_S_PURE_BODY or familiar.Variant == FamiliarVariant.SEWN_DOLL then
        familiar:FollowParent()
    end

    if fData.Sewn_newRoomVisited and not fData.Sewn_familiarReady and familiar.FrameCount > 30 * 10 + 1 then
        if temporaryFamiliars[GetPtrHash(familiar)] ~= nil then
            temporaryFamiliars[GetPtrHash(familiar)] = nil
            table.insert(familiar.Player:GetData().Sewn_familiars, familiar)
        end
        fData.Sewn_familiarReady = true
    end

    --Sewn_spriteScale_multiplier
    if fData.Sewn_spriteScale_multiplier ~= nil then
        familiar.SpriteScale = Vector(1 * fData.Sewn_spriteScale_multiplier, 1 * fData.Sewn_spriteScale_multiplier)
    end
    -- Custom update function
    if fData.Sewn_custom_update ~= nil then
        for i, f in ipairs(fData.Sewn_custom_update) do
            f(_, familiar)
        end
    end

    -- Custom animation
    if fData.Sewn_custom_animation ~= nil then
        for animationName, _function in pairs(fData.Sewn_custom_animation) do
            -- If familiar plays an animation
            if familiar:GetSprite():IsPlaying(animationName) or familiar:GetSprite():IsFinished(animationName) then
                _function(_, familiar, effect)
            end
        end
    end
end
-----------------------------
-- MC_POST_FAMILIAR_RENDER --
-----------------------------
function sewingMachineMod:renderFamiliar(familiar, offset)
    local fData = familiar:GetData()
    if fData == nil or type(fData) ~= "table" then return end
    local pos = Isaac.WorldToScreen(familiar.Position)
    if sewingMachineMod.Config.familiarCrownPosition == sewingMachineMod.CONFIG_CONSTANT.FAMILIAR_CROWN_POSITION.CENTER then
        pos = Vector(pos.X-1, pos.Y - familiar.Size * 2)
    elseif sewingMachineMod.Config.familiarCrownPosition == sewingMachineMod.CONFIG_CONSTANT.FAMILIAR_CROWN_POSITION.RIGHT then
        pos = Vector(pos.X + familiar.Size, pos.Y - familiar.Size * 2)
    end

    if fData.Sewn_crown == nil then
        if fData.Sewn_crownPositionOffset ~= nil then
            pos = pos - fData.Sewn_crownPositionOffset
        end
        fData.Sewn_crown = Sprite()
        fData.Sewn_crown:Load("gfx/sewn_familiar_crown.anm2", false)
        if sewingMachineMod:isSuper(fData) then
            fData.Sewn_crown:Play("Super")
        elseif sewingMachineMod:isUltra(fData) then
            fData.Sewn_crown:Play("Ultra")
        end
        fData.Sewn_crown:LoadGraphics()
    end

    if fData.Sewn_crown_hide ~= true then
        -- if familiar is super -> has a golden crown
        if sewingMachineMod:isSuper(fData) then
            fData.Sewn_crown:Render(pos, v0, v0)
            pos = pos + Vector(0, 15)
        end
        -- if familiar is ultra-> has a diamond crown
        if sewingMachineMod:isUltra(fData) then
            fData.Sewn_crown:Render(pos, v0, v0)
            pos = pos + Vector(0, 15)
        end
    end

    if sewingMachineMod.Config.familiarNonReadyIndicator ~= sewingMachineMod.CONFIG_CONSTANT.FAMILIAR_NON_READY_INDICATOR.NONE then
        if fData.Sewn_notReady_clock then
            fData.Sewn_notReady_clock:Render(pos + Vector(13, 0), v0, v0)
            if sewingMachineMod.Config.familiarNonReadyIndicator == sewingMachineMod.CONFIG_CONSTANT.FAMILIAR_NON_READY_INDICATOR.ANIMATED then
                fData.Sewn_notReady_clock.PlaybackSpeed = 0.3
                fData.Sewn_notReady_clock:Update()
            end
            pos = pos + Vector(13, 0)
        end
        if fData.Sewn_notReady_door then
            fData.Sewn_notReady_door:Render(pos + Vector(13, 0), v0, v0)
            if sewingMachineMod.Config.familiarNonReadyIndicator == sewingMachineMod.CONFIG_CONSTANT.FAMILIAR_NON_READY_INDICATOR.ANIMATED then
                fData.Sewn_notReady_door.PlaybackSpeed = 0.4
                fData.Sewn_notReady_door:Update()
            end
        end
    end
end
-------------------------------
-- MC_PRE_FAMILIAR_COLLISION --
-------------------------------
function sewingMachineMod:familiarCollision(familiar, collider, low)
    local fData = familiar:GetData()

    -- Custom collision
    if fData.Sewn_custom_collision ~= nil then
        for i, f in ipairs(fData.Sewn_custom_collision) do
            f(_, familiar, collider)
        end
    end
end
----------------------
-- MC_POST_NEW_ROOM --
----------------------
function sewingMachineMod:newRoom()
    sewingMachineMod.currentRoom = game:GetRoom()

    sewingMachineMod.displayTrueCoopMessage = false

    for i, familiar in pairs(temporaryFamiliars) do
        local fData = familiar:GetData()
        -- if familiars spawn earlier are still there on new rooms -> Add them to available familiars
        if familiar:Exists() then
            --table.insert(familiar.Player:GetData().Sewn_familiars, familiar)
            --temporaryFamiliars[i] = nil
            fData.Sewn_newRoomVisited = true
        end
    end

    -- Remove temporary upgardes (for Sewing Box only)
    for i = 1, game:GetNumPlayers() do
        local player = Isaac.GetPlayer(i - 1)

        if player:GetData().Sewn_hasTemporaryUpgradedFamiliars == true then
            for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
                familiar = familiar:ToFamiliar()

                sewingMachineMod:resetFamiliarData(familiar)
                sewingMachineMod:callFamiliarUpgrade(familiar)
            end
            player:GetData().Sewn_hasTemporaryUpgradedFamiliars = nil
        end
    end

    if sewingMachineMod.currentRoom:IsFirstVisit() == true then
        if sewingMachineMod.currentRoom:GetType() == RoomType.ROOM_ARCADE then
            --sewingMachineMod:delayFunction(sewingMachineMod.spawnSewingMachineInArcade, 2)
            for _, slot in pairs(Isaac.FindByType(EntityType.ENTITY_SLOT, -1, -1, false, false)) do
                if not slot:IsDead() and slot.Variant < 13 then -- If it's a vanilla slot machine (include beggars)
                    local rollChanceSpawn = sewingMachineMod.rng:RandomInt(10)
                    if rollChanceSpawn == 1 then
                        local pos = Vector(slot.Position.X, slot.Position.Y)
                        slot:Remove()
                        sewingMachineMod:spawnMachine(pos)
                    end
                end
            end
        elseif sewingMachineMod.currentRoom:GetType() == RoomType.ROOM_ISAACS or sewingMachineMod.currentRoom:GetType() == RoomType.ROOM_BARREN then
            sewingMachineMod:spawnMachine()
        elseif sewingMachineMod.currentRoom:GetType() == RoomType.ROOM_SHOP and sewingMachine_shouldAppear_shop then
            if sewingMachineMod.currentRoom:IsClear() then
                sewingMachineMod:spawnMachine()
            end
        elseif sewingMachineMod.currentRoom:GetType() == RoomType.ROOM_ANGEL or sewingMachineMod.currentRoom:GetType() == RoomType.ROOM_DEVIL then
            for i = 1, game:GetNumPlayers() do
                local player = Isaac.GetPlayer(i - 1)
                local rollContrastedButton = sewingMachineMod.rng:RandomInt(100)
                local rollDoll = sewingMachineMod.rng:RandomInt(100)
                if player:HasTrinket(TrinketType.TRINKET_CONTRASTED_BUTTON) and rollContrastedButton < 50 then
                    sewingMachineMod:spawnMachine(nil, true)
                end
                if sewingMachineMod.currentRoom:GetType() == RoomType.ROOM_ANGEL and player:HasCollectible(CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY) and rollDoll < 20 then
                    sewingMachineMod:spawnMachine(nil, true)
                end
                if sewingMachineMod.currentRoom:GetType() == RoomType.ROOM_DEVIL and player:HasCollectible(CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD) and rollDoll < 20 then
                    sewingMachineMod:spawnMachine(nil, true)
                end
            end
        end
    end

    for _, machine in pairs(sewingMachineMod:getAllSewingMachines()) do
        if sewingMachineMod.sewingMachinesData[machine.InitSeed] and sewingMachineMod.sewingMachinesData[machine.InitSeed].Sewn_currentFamiliarVariant ~= nil then
            local mData = sewingMachineMod.sewingMachinesData[machine.InitSeed]
            machine:GetData()["EID_Description"] = mData["EID_Description"]
            sewingMachineMod:setFloatingAnim(machine)
        end
    end

    for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
        local fData = familiar:GetData()
        familiar = familiar:ToFamiliar()
        if fData.Sewn_custom_newRoom ~= nil then
            for i, f in ipairs(fData.Sewn_custom_newRoom) do
                f(_, familiar, sewingMachineMod.currentRoom)
            end
        end
    end
end


------------------------------
-- MC_PRE_SPAWN_CLEAN_AWARD --
------------------------------
function sewingMachineMod:finishRoom(rng, spawnPosition)
    if sewingMachineMod.currentRoom:GetType() == RoomType.ROOM_SHOP and sewingMachine_shouldAppear_shop then
        -- Spawn machine when the shop is cleared
        sewingMachineMod:spawnMachine(nil, true)
    end

    for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
        local fData = familiar:GetData()
        familiar = familiar:ToFamiliar()
        if fData.Sewn_custom_cleanAward ~= nil then
            for i, f in ipairs(fData.Sewn_custom_cleanAward) do
                f(_, familiar)
            end
        end
    end
end

-----------------------
-- MC_POST_NEW_LEVEL --
-----------------------
function sewingMachineMod:onNewFloor()
    sewingMachineMod.currentLevel = game:GetLevel()
    sewingMachineMod.currentCurse = sewingMachineMod.currentLevel:GetCurses()
    sewingMachine_shouldAppear_shop = false
    
    sewingMachineMod.sewingMachinesData = {}

    if sewingMachineMod.currentLevel:GetStage() == LevelStage.STAGE4_3 then
        sewingMachine_shouldAppear_shop = true
    end

    local roll = sewingMachineMod.rng:RandomInt(101)
    if roll < 20 then
        sewingMachine_shouldAppear_shop = true
    end
end


--------------------------
-- MC_POST_TEAR_UPDATE --
--------------------------
function sewingMachineMod:tearUpdate(tear)
    local tData = tear:GetData()
    local familiar = tear.Parent
    local fData

    -- If tear hasn't been fired from a familiar
    if tear.SpawnerType ~= EntityType.ENTITY_FAMILIAR or familiar == nil then
        return
    end

    familiar = familiar:ToFamiliar()
    fData = familiar:GetData()

    -- TEAR INIT
    if not tData.Sewn_Init then

        -- Give a damage upgrade (from tears)
        if fData.Sewn_damageTear_multiplier ~= nil then
            tear.CollisionDamage = tear.CollisionDamage * fData.Sewn_damageTear_multiplier
        end

        -- Range up
        if fData.Sewn_range_multiplier ~= nil then
            tear.FallingAcceleration = 0.02 + -0.02 * fData.Sewn_range_multiplier
        end

        -- Shot speed up
        if fData.Sewn_shotSpeed_multiplier ~= nil then
            tear.Velocity = tear.Velocity:__mul(fData.Sewn_shotSpeed_multiplier)
        end

        -- Make tears bigger
        if fData.Sewn_tearSize_multiplier ~= nil then
            tear.Scale = tear.Scale * fData.Sewn_tearSize_multiplier
        end

        -- Reduce fire rate
        if fData.Sewn_tearRate_bonus ~= nil then
            familiar.FireCooldown = familiar.FireCooldown - fData.Sewn_tearRate_bonus
        end
        if fData.Sewn_tearRate_set ~= nil then
            familiar.FireCooldown = fData.Sewn_tearRate_set
        end

        -- Change tear flags
        if fData.Sewn_tearFlags ~= nil then
            if fData.Sewn_tearFlags_chance == nil then
                tear.TearFlags = fData.Sewn_tearFlags
            else
                local roll = sewingMachineMod.rng:RandomInt(101)
                if fData.Sewn_tearFlags_chance >= roll then
                    tear.TearFlags = fData.Sewn_tearFlags
                end
            end
        end

        -- Change tear Variant
        if fData.Sewn_tearVariant ~= nil then
            tear:ChangeVariant(fData.Sewn_tearVariant)
        end

        -- Custom tear init function
        if fData.Sewn_custom_fireInit ~= nil then
            for i, f in ipairs(fData.Sewn_custom_fireInit) do
                f(_, familiar, tear)
            end
        end

        tData.Sewn_Init = true
    end -- End Init tear

    -- If the tear hit the ground
    if fData.Sewn_custom_tearFall ~= nil then
        if tear.Height > -5 and tData.Sewn_isTearFall == nil then
            for i, f in ipairs(fData.Sewn_custom_tearFall) do
                f(_, familiar, tear)
            end
            tData.Sewn_isTearFall = true
        end
    end
end
---------------------------
-- MC_PRE_TEAR_COLLISION --
---------------------------
function sewingMachineMod:tearCollision(tear, collider, low)
    local familiar = tear.Parent
    local fData

    -- If tear hasn't been fired from a familiar
    if tear.SpawnerType ~= EntityType.ENTITY_FAMILIAR or familiar == nil then
        return
    end

    familiar = familiar:ToFamiliar()
    fData = familiar:GetData()

    if fData.Sewn_custom_tearCollision ~= nil then
        for i, f in ipairs(fData.Sewn_custom_tearCollision) do
            f(_, familiar, tear, collider)
        end
    end
end
--------------------------
-- MC_POST_LASER_UPDATE --
--------------------------
function sewingMachineMod:laserUpdate(laser)
    -- If laser has been fired from a familiar
    if laser.SpawnerType == EntityType.ENTITY_FAMILIAR then
        -- INIT
        if laser.FrameCount > 0 and not laser:GetData().Sewn_Init then
            local familiar = laser.Parent
            local fData

            if familiar == nil then
                -- Prevent from errors
                return
            end

            familiar = familiar:ToFamiliar()
            fData = familiar:GetData()

            -- Give a damage upgrade, same damage multiplier as tears
            if fData.Sewn_damageTear_multiplier ~= nil then
                laser.CollisionDamage = laser.CollisionDamage * fData.Sewn_damageTear_multiplier
            end

            -- Reduce fire rate
            if fData.Sewn_tearRate_bonus ~= nil then
                familiar.FireCooldown = familiar.FireCooldown - fData.Sewn_tearRate_bonus
            end

            -- Custom laser init function
            if fData.Sewn_custom_fireInit ~= nil then
                for i, f in ipairs(fData.Sewn_custom_fireInit) do
                    f(_, familiar, laser)
                end
            end

            laser:GetData().Sewn_Init = true
        end
    end
end



------------------------------------------
-- MC_USE_ITEM - COLLECTIBLE_SEWING_BOX --
------------------------------------------
function sewingMachineMod:useSewingBox(collectibleType, rng)
    
    local player = GetPlayerUsingItem()
    
    for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
        local fData = familiar:GetData()
        familiar = familiar:ToFamiliar()
        if familiar.Player and GetPtrHash(familiar.Player) == GetPtrHash(player) then
            sewingMachineMod:temporaryUpgradeFamiliar(familiar)
        end
    end
    player:GetData().Sewn_hasTemporaryUpgradedFamiliars = true
    return true
end

-------------------------------------------------
-- MC_USE_ITEM - COLLECTIBLE_GLOWING_HOURGLASS --
-------------------------------------------------
function sewingMachineMod:useGlowingHourglass(collectibleType, rng)
    local familiarStates = {}
    for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
        familiar = familiar:ToFamiliar()
        local fData = familiar:GetData()
        if fData.Sewn_upgradeState > 0 then
            if familiarStates[familiar.Variant] == nil then
                familiarStates[familiar.Variant] = {}
            end
            table.insert(familiarStates[familiar.Variant], fData.Sewn_upgradeState)
        end
    end
    sewingMachineMod:delayFunction(sewingMachineMod.glowingHourglassResetFamiliars, -game:GetRoom():GetFrameCount(), familiarStates)
end
function sewingMachineMod:glowingHourglassResetFamiliars(familiarStates)
    for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
        familiar = familiar:ToFamiliar()
        local fData = familiar:GetData()

        if familiarStates[familiar.Variant] ~= nil then
            fData.Sewn_upgradeState = familiarStates[familiar.Variant][#familiarStates[familiar.Variant]]
            table.remove(familiarStates[familiar.Variant], #familiarStates[familiar.Variant])
            
            sewingMachineMod:resetFamiliarData(familiar)
            sewingMachineMod:callFamiliarUpgrade(familiar)
        end
    end
end
-----------------
-- MC_GET_CARD --
-----------------
function sewingMachineMod:getCard(rng, card, includePlayingCard, includeRunes, onlyRunes)
    if not includeRunes then
        local roll = rng:RandomInt(1000)
        if roll < 10 then
            return Card.CARD_WARRANTY
        elseif roll < 20 then
            return Card.CARD_STITCHING
        end
    end
end
--------------------------------------
-- MC_USE_CARD - Card.CARD_WARRANTY --
--------------------------------------
function sewingMachineMod:useWarrantyCard(card)
    local player = GetPlayerUsingItem()
    sewingMachineMod:spawnMachine(sewingMachineMod.currentRoom:FindFreePickupSpawnPosition(player.Position, 0, true), true)
end
---------------------------------------
-- MC_USE_CARD - Card.CARD_STITCHING --
---------------------------------------
function sewingMachineMod:useStitchingCard(card)
    sewingMachineMod:rerollFamilarsCrowns(GetPlayerUsingItem())
end
---------------------------
-- MC_POST_PICKUP_UPDATE --
---------------------------
function sewingMachineMod:updateCard(card)
    if card.SubType == Card.CARD_WARRANTY or card.SubType == Card.CARD_STITCHING then
        local cData = card:GetData()
        if cData.Sewn_isInit == nil then
            local sprite = card:GetSprite()
            sprite:Load("gfx/005_sewing_card.anm2", true)

            if card.FrameCount == 0 then
                sprite:Play("Idle")
            end
            if card.FrameCount == 1 then
                sprite:Play("Appear")
            end
            cData.Sewn_isInit = true
        end
    end
end


--------------------
-- MC_POST_UPDATE --
--------------------
function sewingMachineMod:onUpdate()
    -- Call delayed functions
    for i, data in pairs(sewingMachineMod.delayedFunctions) do
        if data.FRAME + data.DELAY < game:GetFrameCount() then
            data.FUNCTION(_, data.PARAM)
            table.remove(sewingMachineMod.delayedFunctions, i)
        end
    end
    for _, machine in pairs(sewingMachineMod:getAllSewingMachines()) do
        local machineSprite = machine:GetSprite()
        local mData = sewingMachineMod.sewingMachinesData[machine.InitSeed]
        
        -- To stuff when machine animation are finished
        if machineSprite:IsFinished("Appear") then
            machineSprite:Play("Idle")
        elseif machineSprite:IsFinished("Disappear") then
            machine:Remove()
        end
        
        
        sewingMachineMod:StopExplosionHack(machine)
    end
end
function sewingMachineMod:ManageMachineDestuction(machine)
    local mData = sewingMachineMod.sewingMachinesData[machine.InitSeed]
    local pos = sewingMachineMod.currentRoom:GetGridPosition(sewingMachineMod.currentRoom:GetGridIndex(machine.Position))
    local machineSubType = machine.SubType
    
    if mData.Sewn_currentFamiliarVariant ~= nil then
        sewingMachineMod:getFamiliarBack(machine, false)
    end

    if mData.Sewn_isMachineBroken == true then
        machine:GetSprite():Play("Broken", true)
        return
    end
    
    local newMachine = sewingMachineMod:spawnMachine(pos, false, machineSubType)
    
    sewingMachineMod.sewingMachinesData[newMachine.InitSeed] = mData
    for i = 1, game:GetNumPlayers() do
        local player = Isaac.GetPlayer(i - 1)
        if player:GetData().Sewn_familiarsInMachine  ~= nil then
            player:GetData().Sewn_familiarsInMachine[newMachine.InitSeed] = player:GetData().Sewn_familiarsInMachine[machine.InitSeed]
            player:GetData().Sewn_familiarsInMachine[machine.InitSeed] = nil
        end
    end
    sewingMachineMod.sewingMachinesData[machine.InitSeed] = nil
    
    machine:Remove()
end

-- Function given by @Sentinel
function sewingMachineMod:StopExplosionHack(machine)
    -- Check if the machine can be moved or not
    local asploded = machine.GridCollisionClass == EntityGridCollisionClass.GRIDCOLL_GROUND
    if not asploded then return end

    -- Remove reward spawned from the machine
    sewingMachineMod:RemoveRecentRewards(machine.Position)

    sewingMachineMod:ManageMachineDestuction(machine)
end
function sewingMachineMod:RemoveRecentRewards(pos)
    for _, pickup in ipairs(Isaac.FindByType(5, -1, -1)) do
        if pickup.FrameCount <= 1 and pickup.SpawnerType == 0
        and pickup.Position:DistanceSquared(pos) <= 400 then
            pickup:Remove()
        end
    end

    for _, trollbomb in ipairs(Isaac.FindByType(4, -1, -1)) do
        if (trollbomb.Variant == 3 or trollbomb.Variant == 4)
        and trollbomb.FrameCount <= 1 and trollbomb.SpawnerType == 0
        and trollbomb.Position:DistanceSquared(pos) <= 400 then
            trollbomb:Remove()
        end
    end
end
--------------------
-- MC_EXECUTE_CMD --
--------------------
function sewingMachineMod:executeCommand(cmd, params)
    params = split(params)

    if cmd == "sewn" then
        if params[1] == "up" then
            for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
                familiar = familiar:ToFamiliar()
                local fData = familiar:GetData()
                
                -- The variable may be nil if the command is executed on the same frame as the familiar appears
                if fData.Sewn_upgradeState == nil then
                    fData.Sewn_upgradeState = sewingMachineMod.UpgradeState.NORMAL
                end
                
                if params[2] == "ultra" then
                    if fData.Sewn_upgradeState < 2 then
                        fData.Sewn_upgradeState = sewingMachineMod.UpgradeState.ULTRA
                        sewingMachineMod:resetFamiliarData(familiar)
                        sewingMachineMod:callFamiliarUpgrade(familiar)
                    end
                elseif params[2] == "super" then
                    if fData.Sewn_upgradeState == 0 then
                        fData.Sewn_upgradeState = sewingMachineMod.UpgradeState.SUPER
                        sewingMachineMod:resetFamiliarData(familiar)
                        sewingMachineMod:callFamiliarUpgrade(familiar)
                    end
                elseif fData.Sewn_upgradeState < 2 then
                    fData.Sewn_upgradeState = fData.Sewn_upgradeState or 0
                    fData.Sewn_upgradeState = fData.Sewn_upgradeState + 1
                    sewingMachineMod:resetFamiliarData(familiar)
                    sewingMachineMod:callFamiliarUpgrade(familiar)
                end
            end
        end
    end
end
function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    if string.match(inputstr, sep) then
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
        end
    else
        table.insert(t, inputstr)
    end
    return t
end

----------------------
-- MC_PRE_GAME_EXIT --
----------------------
function sewingMachineMod:saveGame()
    local saveData = {}
    saveData.config = {}
    saveData.player = {}
    saveData.machines = {}
    saveData.familiars = {}


    -- Save config data
    for i, v in pairs(sewingMachineMod.Config) do
        saveData.config[i] = v
    end

    -- Save player data
    for i = 1, game:GetNumPlayers() do
        local player = Isaac.GetPlayer(i - 1)
        if player:GetData().Sewn_familiarsInMachine ~= nil then
            saveData.player.Sewn_familiarsInMachine = {}
            for machineId, familiarVariant in pairs(player:GetData().Sewn_familiarsInMachine) do
                saveData.player.Sewn_familiarsInMachine[tostring(machineId)] = familiarVariant
            end
        end
    end

    -- Save machine data
    for machineId, machineValues in pairs(sewingMachineMod.sewingMachinesData) do
        saveData.machines[tostring(machineId)] = {}
        for key, value in pairs(machineValues) do
            if key == "Sewn_player" then
                saveData.machines[tostring(machineId)][key] = value:GetName()
            else
                saveData.machines[tostring(machineId)][key] = value
            end
        end
    end

    -- Save familiars data
    for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
        if sewingMachineMod:isAvailable(familiar.Variant) then
            local fData = familiar:GetData()
            local variantIndex = tostring(familiar.Variant)
            if saveData.familiars[variantIndex] == nil then
                saveData.familiars[variantIndex] = {}
            end
            table.insert(saveData.familiars[variantIndex], {})


            saveData.familiars[variantIndex][#saveData.familiars[variantIndex] ].Sewn_upgradeState = familiar:GetData().Sewn_upgradeState
        end
    end

    sewingMachineMod:SaveData(json.encode(saveData))
end
--------------------------
-- MC_POST_GAME_STARTED --
--------------------------
function sewingMachineMod:loadSave(isExistingRun)
    -- If Marshmallow exists
    if sewingMachineMod.moddedFamiliar.MARSHMALLOW > -1 then
        sewingMachineMod:makeFamiliarAvailable(sewingMachineMod.moddedFamiliar.MARSHMALLOW, Isaac.GetItemIdByName("Marshmallow"), sewingMachineMod.sewnFamiliars.upMarshmallow)
    end

    if MinimapAPI ~= nil then
        local icon = Sprite()
        icon:Load("gfx/mapicon.anm2", true)
        MinimapAPI:AddIcon("SewingMachine", icon, "Icon", 0)
        MinimapAPI:AddPickup("SewingMachine", "SewingMachine", EntityType.ENTITY_SLOT, sewingMachineMod.SewingMachine, -1, MinimapAPI.PickupSlotMachineNotBroken, "slots")
    end

    if isExistingRun == true then
        if sewingMachineMod:HasData() then
            local saveData = json.decode(Isaac.LoadModData(sewingMachineMod))

            if saveData == nil or saveData.player == nil or saveData.machines == nil or saveData.familiars == nil then
                return
            end

            -- Loading player data
            for i = 1, game:GetNumPlayers() do
                local player = Isaac.GetPlayer(i - 1)
                player:GetData().Sewn_familiarsInMachine = {}
                if saveData.player.Sewn_familiarsInMachine ~= nil then
                    for key, value in pairs(saveData.player.Sewn_familiarsInMachine) do
                        player:GetData().Sewn_familiarsInMachine[tonumber(key)] = value
                    end
                end
                player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
                player:EvaluateItems()
            end

            -- Loading machine data
            sewingMachineMod.sewingMachinesData = {}
            for machineId, machineValues in pairs(saveData.machines) do
                sewingMachineMod.sewingMachinesData[tonumber(machineId)] = {}
                for key, value in pairs(machineValues) do
                    if key == "Sewn_player" then
                        for i = 1, game:GetNumPlayers() do
                            local player = Isaac.GetPlayer(i - 1)
                            if player:GetName() == value then
                                sewingMachineMod.sewingMachinesData[tonumber(machineId)][key] = player
                            end
                        end
                    else
                        sewingMachineMod.sewingMachinesData[tonumber(machineId)][key] = value
                    end
                end
            end


            -- Loading familiar data
            for variant, saveDataFamiliar in pairs(saveData.familiars) do
                -- Loop through variants of familiars
                for i, saveDataFamiliarVariant in pairs(saveDataFamiliar) do
                    local fam = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, variant, -1, false, false)[i]:ToFamiliar()

                    fam:GetData().Sewn_upgradeState = saveDataFamiliarVariant["Sewn_upgradeState"]
                    sewingMachineMod:callFamiliarUpgrade(fam)
                end
            end
        end
    end

    -- Restore config data
    if sewingMachineMod:HasData() then
        local saveData = json.decode(Isaac.LoadModData(sewingMachineMod))
        for i, v in pairs(saveData.config) do
            sewingMachineMod.Config[i] = v
        end
    end

    -- Set the floating animation
    for _, machine in pairs(sewingMachineMod:getAllSewingMachines()) do
        local mData = sewingMachineMod.sewingMachinesData[machine.InitSeed]
        if mData.Sewn_currentFamiliarVariant ~= nil then
            sewingMachineMod:setFloatingAnim(machine)
        end
    end



    sewingMachineMod.delayedFunctions = {}
    sewingMachineMod.currentUpgradeInfo = nil

    if sewingMachineMod.IsEidDescriptionLoaded == false then
        -- Set familiar description
        sewingMachineMod:InitFamiliarDescription()
        -- Add an indication in the EID Description of familiar collectible
        sewingMachineMod:addEIDDescriptionForCollectible()
    end
     
end

---------------
-- CALLBACKS --
---------------

-- Player related callbacks
sewingMachineMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, sewingMachineMod.onPlayerUpdate)
sewingMachineMod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, sewingMachineMod.playerTakeDamage, EntityType.ENTITY_PLAYER)
sewingMachineMod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, sewingMachineMod.onCacheFamiliars)

-- Familiar related callbacks
sewingMachineMod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, sewingMachineMod.updateFamiliar)
sewingMachineMod:AddCallback(ModCallbacks.MC_POST_FAMILIAR_RENDER, sewingMachineMod.renderFamiliar)
sewingMachineMod:AddCallback(ModCallbacks.MC_PRE_FAMILIAR_COLLISION, sewingMachineMod.familiarCollision)


-- Tears related callbacks
sewingMachineMod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, sewingMachineMod.tearUpdate)
sewingMachineMod:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, sewingMachineMod.tearCollision)
sewingMachineMod:AddCallback(ModCallbacks.MC_POST_LASER_UPDATE, sewingMachineMod.laserUpdate)


-- Pickups related callbacks
sewingMachineMod:AddCallback(ModCallbacks.MC_USE_ITEM, sewingMachineMod.useSewingBox, CollectibleType.COLLECTIBLE_SEWING_BOX)
sewingMachineMod:AddCallback(ModCallbacks.MC_USE_ITEM, sewingMachineMod.useGlowingHourglass, CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS)
sewingMachineMod:AddCallback(ModCallbacks.MC_GET_CARD, sewingMachineMod.getCard)
sewingMachineMod:AddCallback(ModCallbacks.MC_USE_CARD, sewingMachineMod.useWarrantyCard, Card.CARD_WARRANTY)
sewingMachineMod:AddCallback(ModCallbacks.MC_USE_CARD, sewingMachineMod.useStitchingCard, Card.CARD_STITCHING)
sewingMachineMod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, sewingMachineMod.updateCard, PickupVariant.PICKUP_TAROTCARD)

-- Rooms related callbacks
sewingMachineMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, sewingMachineMod.newRoom)
sewingMachineMod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, sewingMachineMod.onNewFloor)
sewingMachineMod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, sewingMachineMod.finishRoom)

-- Entities related callbacks
sewingMachineMod:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, sewingMachineMod.entitySpawn)
sewingMachineMod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, sewingMachineMod.effectUpdate)
sewingMachineMod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, sewingMachineMod.entityTakeDamage)

-- Game related callbacks
sewingMachineMod:AddCallback(ModCallbacks.MC_POST_UPDATE, sewingMachineMod.onUpdate)
sewingMachineMod:AddCallback(ModCallbacks.MC_EXECUTE_CMD, sewingMachineMod.executeCommand)

-- Saving/Loading related callbacks
sewingMachineMod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, sewingMachineMod.saveGame)
sewingMachineMod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, sewingMachineMod.loadSave)
