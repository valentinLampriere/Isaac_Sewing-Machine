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
-- sewingMachineMod.sewnFamiliars:sewnFamiliars:customEntityKill(familiar, functionName)
-- The function will have 2 parameters : The familiar, and the killed enemy



-- Usefull data attribute :

-- To prevent a familiar to be upgradable (for exemple for copy familiar of King Baby)
-- familiar:GetData().Sewn_noUpgrade = true


-- You can have a look on how I upgrade vanilla familiars in familiars.lua


-- *** Special thanks to Foks, SupremeElf, PixelPlz and Sentinel for their support and their help *** --


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
CollectibleType.COLLECTIBLE_ANN_S_TAINTED_HEAD = Isaac.GetItemIdByName("Ann's Tainted Head")
CollectibleType.COLLECTIBLE_ANN_S_PURE_BODY = Isaac.GetItemIdByName("Ann's Pure Body")
-- Cards --
Card.RUNE_WUNJO = Isaac.GetCardIdByName("Wunjo")
Card.RUNE_NAUDIZ = Isaac.GetCardIdByName("Naudiz")
-- Familiars --
FamiliarVariant.ANN_S_TAINTED_HEAD = Isaac.GetEntityVariantByName("Ann's Tainted Head")
FamiliarVariant.ANN_S_PURE_BODY = Isaac.GetEntityVariantByName("Ann's Pure Body")
FamiliarVariant.ANN = Isaac.GetEntityVariantByName("Ann")
FamiliarVariant.SPIDER_MOD_EGG = Isaac.GetEntityVariantByName("Spider Mod Egg")
-- Effects
EffectVariant.PULLING_EFFECT_2 = Isaac.GetEntityVariantByName("Pulling Effect 02")
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
sewingMachineMod.rng = RNG()

local json = require("json")

--local sewingMachineMod.rng = RNG()
local game = Game()
local sewingMachine_shouldAppear_shop = false
local spawnMachineAfterGreed
local temporaryFamiliars = {}
local trinketSewingMachine = {
    TrinketType.TRINKET_THIMBLE,
    TrinketType.TRINKET_LOST_BUTTON,
    TrinketType.TRINKET_PIN_CUSHION
}
local GiantBook = Sprite()
GiantBook:Load("gfx/ui/giantbook/giantbook.anm2", false)


sewingMachineMod.displayTrueCoopMessage = false

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
__require("config")
__require("familiars")

-------------------------
-- AVAILABLE FAMILIARS --
-------------------------
sewingMachineMod.availableFamiliar = {
    [FamiliarVariant.BROTHER_BOBBY] = {8, sewingMachineMod.sewnFamiliars.upBrotherBobby},
    [FamiliarVariant.DISTANT_ADMIRATION] = {57, sewingMachineMod.sewnFamiliars.upFlies},
    [FamiliarVariant.SISTER_MAGGY] = {67, sewingMachineMod.sewnFamiliars.upSisterMaggy},
    [FamiliarVariant.SACK_OF_PENNIES] = {94, sewingMachineMod.sewnFamiliars.upSackOfPennies},
    [FamiliarVariant.ROBO_BABY] = {95, sewingMachineMod.sewnFamiliars.upRoboBaby},
    [FamiliarVariant.LITTLE_CHAD] = {96, sewingMachineMod.sewnFamiliars.upLittleChad},
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
    [FamiliarVariant.ABEL] = {188, sewingMachineMod.sewnFamiliars.upAbel},
    [FamiliarVariant.JUICY_SACK] = {266, sewingMachineMod.sewnFamiliars.upJuicySack},
    [FamiliarVariant.ROBO_BABY_2] = {267, sewingMachineMod.sewnFamiliars.upRoboBaby2},
    [FamiliarVariant.ROTTEN_BABY] = {268, sewingMachineMod.sewnFamiliars.upRottenBaby},
    [FamiliarVariant.HEADLESS_BABY] = {269, sewingMachineMod.sewnFamiliars.upHeadlessBaby},
    [FamiliarVariant.LEECH] = {270, sewingMachineMod.sewnFamiliars.upLeech},
    [FamiliarVariant.BBF] = {272, sewingMachineMod.sewnFamiliars.upBbf},
    [FamiliarVariant.BOBS_BRAIN] = {273, sewingMachineMod.sewnFamiliars.upBobsBrain},
    [FamiliarVariant.LIL_BRIMSTONE] = {275, sewingMachineMod.sewnFamiliars.upLilBrimstone},
    [FamiliarVariant.SISSY_LONGLEGS] = {280, sewingMachineMod.sewnFamiliars.upSissyLonglegs},
    [FamiliarVariant.PUNCHING_BAG] = {281, sewingMachineMod.sewnFamiliars.upPunchingBag},
    [FamiliarVariant.CAINS_OTHER_EYE] = {319, sewingMachineMod.sewnFamiliars.upCainsOtherEye},
    [FamiliarVariant.BLUEBABYS_ONLY_FRIEND] = {320, sewingMachineMod.sewnFamiliars.upBlueBabysOnlyFriend},
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
    [FamiliarVariant.HUSHY] = {470, sewingMachineMod.sewnFamiliars.upHushy},
    [FamiliarVariant.LIL_MONSTRO] = {471, sewingMachineMod.sewnFamiliars.upLilMonstro},
    [FamiliarVariant.KING_BABY] = {472, sewingMachineMod.sewnFamiliars.upKingBaby},
    [FamiliarVariant.BLOODSHOT_EYE] = {509, sewingMachineMod.sewnFamiliars.upBloodshotEye},
    [FamiliarVariant.BUDDY_IN_A_BOX] = {518, sewingMachineMod.sewnFamiliars.upBuddyInABox},
    [FamiliarVariant.ANGELIC_PRISM] = {528, sewingMachineMod.sewnFamiliars.upAngelicPrism},
    [FamiliarVariant.JAW_BONE] = {548, sewingMachineMod.sewnFamiliars.upJawBone}
}

__require("descriptions")

-------------------------------
-- External Item Description --
-------------------------------
if not __eidTrinketDescriptions then
	__eidTrinketDescriptions = {};
end
if not __eidItemDescriptions then
	__eidItemDescriptions = {};
end
if not __eidCardDescriptions then
  __eidCardDescriptions = {};
end
-- EID Trinkets
__eidTrinketDescriptions[TrinketType.TRINKET_THIMBLE] = "Have a 50% chance to upgrade a familiar for free"
__eidTrinketDescriptions[TrinketType.TRINKET_CRACKED_THIMBLE] = "Reroll familiars crowns when getting hit"
__eidTrinketDescriptions[TrinketType.TRINKET_LOST_BUTTON] = "100% chance to spawn sewing machine in Shops for next floors"
__eidTrinketDescriptions[TrinketType.TRINKET_CONTRASTED_BUTTON] = "50% chance to find a sewing machine in angel rooms or devil rooms"
__eidTrinketDescriptions[TrinketType.TRINKET_PIN_CUSHION] = "Interacting with the machine gives the familiar back#It allow the player to choose the familiar he want to upgrade#Can be easily dropped by pressing the drop button"
-- EID Collectibles
__eidItemDescriptions[CollectibleType.COLLECTIBLE_SEWING_BOX] = "Upgrade every familiars from normal to super, or super to ultra form#Using it twice in a room will upgrade familiars twice#Ultra familiars can't be upgraded"
__eidItemDescriptions[CollectibleType.COLLECTIBLE_ANN_S_TAINTED_HEAD] = "Every familiars will be SUPER#With Ann's Pure Body every familiars will be ULTRA"
__eidItemDescriptions[CollectibleType.COLLECTIBLE_ANN_S_PURE_BODY] = "Every familiars will be SUPER#With Ann's Tainted Head every familiars will be ULTRA"
-- EID Cards
__eidCardDescriptions[Card.RUNE_WUNJO] = "Upgrade every familiars for 30 seconds"
__eidCardDescriptions[Card.RUNE_NAUDIZ] = "Spawn a sewing machine"

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
    local curse = game:GetLevel():GetCurses()
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
    if familiarVariant ~= nil then
        local collectible = Isaac.GetItemConfig():GetCollectible(sewingMachineMod.availableFamiliar[familiarVariant][1])
        if collectible ~= nil then
            return collectible.GfxFileName
        end
    end
    return "gfx/items/collectibles/questionmark.png"
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


function sewingMachineMod:temporaryUpgradeFamiliar(familiar, delay)
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

        if delay ~= nil then
            fData.Sewn_upgradeState_temporary_delay = game:GetFrameCount() + delay
        end

        sewingMachineMod:callFamiliarUpgrade(familiar)
    end
end
function sewingMachineMod:removeTemporaryUpgrade(familiar)
    local fData = familiar:ToFamiliar()
    sewingMachineMod:resetFamiliarData(familiar)

    sewingMachineMod:callFamiliarUpgrade(familiar)
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

-----------------------------------
-- MC_USE_CARD - CARD_RUNE_WUNJO --
-----------------------------------
function sewingMachineMod:useWunjo(card)
    local player = GetPlayerUsingItem()
    player:AnimateCard(Card.RUNE_BERKANO, "UseItem")
    GiantBook:ReplaceSpritesheet(0, "gfx/ui/giantbook/rune_wunjo.png")
    GiantBook:LoadGraphics()
    GiantBook:Play("Appear", true)
    for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
        familiar = familiar:ToFamiliar()
        if familiar.Player and GetPtrHash(familiar.Player) == GetPtrHash(player) then
            sewingMachineMod:temporaryUpgradeFamiliar(familiar, 30 * 30)
        end
    end
end

------------------------------------
-- MC_USE_CARD - CARD_RUNE_NAUDIZ --
------------------------------------
function sewingMachineMod:useNaudiz(card)
    local player = GetPlayerUsingItem()
    local room = game:GetLevel():GetCurrentRoom()
    player:AnimateCard(Card.RUNE_BERKANO, "UseItem")
    GiantBook:ReplaceSpritesheet(0, "gfx/ui/giantbook/rune_naudiz.png")
    GiantBook:LoadGraphics()
    GiantBook:Play("Appear", true)


    sewingMachineMod:spawnMachine(room:FindFreePickupSpawnPosition(player.Position, 0, true), true)
end

-------------------------
-- MC_POST_PICKUP_INIT --
-------------------------
function sewingMachineMod:initPickup(pickup)
    if pickup.Type == EntityType.ENTITY_PICKUP and pickup.Variant == PickupVariant.PICKUP_TAROTCARD then
        if pickup.SubType == Card.RUNE_WUNJO then
            local sprite = pickup:GetSprite()
            sprite:Load("gfx/005.303_rune1.anm2", true)
            sprite:Play("Appear")
        elseif pickup.SubType == Card.RUNE_NAUDIZ then
            local sprite = pickup:GetSprite()
            sprite:Load("gfx/005.304_rune2.anm2", true)
            sprite:Play("Appear")
        end
    end
end

-----------------
-- MC_GET_CARD --
-----------------
function sewingMachineMod:getCard(rng, card, includePlayingCard, includeRunes, onlyRunes)
    if includeRunes then
        local roll = rng:RandomInt(100) + 1
        if roll < 8 then
            local rollRune = rng:RandomInt(2)
            if rollRune == 0 then
                return Card.RUNE_WUNJO
            elseif rollRune == 1 then
                return Card.RUNE_NAUDIZ
            end
        end
    end
end

function sewingMachineMod:delayFunction(functionToDelay, delay, param)
    if functionToDelay ~= nil and delay ~= nil then
        local data = {FUNCTION = functionToDelay, DELAY = delay, FRAME = game:GetFrameCount(), PARAM = param}
        table.insert(sewingMachineMod.delayedFunctions, data)
    end
end

-- Remove every Sewing Machines and spawn an new one
function sewingMachineMod:spawnMachine(position, playAppearAnim, machineSubType)
    local room = game:GetLevel():GetCurrentRoom()
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

    local machine = Isaac.Spawn(EntityType.ENTITY_SLOT, sewingMachineMod.SewingMachine, subType, position, Vector(0, 0), nil)
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
        Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BOMB_EXPLOSION, 0, machine.Position, Vector(0, 0), nil)


        mData.Sewn_isMachineBroken = true
        if rollTrinket < 5 then
            local rollTrinket = sewingMachineMod.rng:RandomInt(#trinketSewingMachine) + 1
            local trinket = trinketSewingMachine[rollTrinket]
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, trinket, machine.Position + Vector(0,15), Vector(0,2):Rotated(math.random(-45,45)), machine)
        end

        machine:TakeDamage(100, DamageFlag.DAMAGE_EXPLOSION, EntityRef(machine), 1)
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

    pData.Sewn_familiars[roll]:Remove()

    -- Update description
    sewingMachineMod.currentUpgradeInfo = machine

    table.remove(player:GetData().Sewn_familiars, roll)
end

function sewingMachineMod:setFloatingAnim(machine)
    local mData = sewingMachineMod.sewingMachinesData[machine.InitSeed]
    machine:GetSprite():ReplaceSpritesheet(1, sewingMachineMod:getFamiliarItemGfx(mData.Sewn_currentFamiliarVariant))
    machine:GetSprite():Play("IdleFloating")
    machine:GetSprite():LoadGraphics()
end

-- Return boolean : true if the player has enough money to pay
function sewingMachineMod:canPayCost(machine, player)
    if player:GetData().Sewn_machine_upgradeFree == true then
        return true
    end
    if machine.SubType == sewingMachineMod.SewingMachineSubType.BEDROOM then
        return player:GetSoulHearts() >= sewingMachineMod.SewingMachineCost.BEDROOM
    elseif machine.SubType == sewingMachineMod.SewingMachineSubType.SHOP then
        local cost = sewingMachineMod.SewingMachineCost.SHOP
        if player:HasCollectible(CollectibleType.COLLECTIBLE_STEAM_SALE) then
            cost = math.ceil(cost / 2)
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
            cost = math.ceil(cost / 2)
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

----------------------------
-- MC_POST_PEFFECT_UPDATE --
----------------------------
function sewingMachineMod:onPlayerUpdate(player)
    local pData = player:GetData()

    GiantBook:Update()

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

            if mData.Sewn_machineBombed == true then
                local newMachine = sewingMachineMod:spawnMachine(machine.Position, nil, machine.SubType)
                mData.Sewn_machineBombed = false
                machine:Remove()
                sewingMachineMod.sewingMachinesData[newMachine.InitSeed] = mData
                for i = 1, game:GetNumPlayers() do
                    local player = Isaac.GetPlayer(i - 1)
                    if player:GetData().Sewn_familiarsInMachine  ~= nil then
                        player:GetData().Sewn_familiarsInMachine[newMachine.InitSeed] = player:GetData().Sewn_familiarsInMachine[machine.InitSeed]
                        player:GetData().Sewn_familiarsInMachine[machine.InitSeed] = nil
                    end
                end
                sewingMachineMod.sewingMachinesData[machine.InitSeed] = nil
            end

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

                    if mData.Sewn_currentFamiliarVariant ~= nil and player:HasTrinket(TrinketType.TRINKET_PIN_CUSHION) then
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
                    table.insert(temporaryFamiliars, familiar)
                    --table.insert(player:GetData().Sewn_familiars, familiar)
                end
            end
        end
        if fData.Sewn_upgradeState == nil then
            local hasAnnsHead = player:HasCollectible(CollectibleType.COLLECTIBLE_ANN_S_TAINTED_HEAD)
            local hasAnnsBody = player:HasCollectible(CollectibleType.COLLECTIBLE_ANN_S_PURE_BODY)
            if hasAnnsHead and not hasAnnsBody or not hasAnnsHead and hasAnnsBody then
                fData.Sewn_upgradeState = sewingMachineMod.UpgradeState.SUPER
                sewingMachineMod:callFamiliarUpgrade(familiar)
            elseif hasAnnsHead and hasAnnsBody then
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

    if fData.Sewn_upgradeState_temporary_delay ~= nil and fData.Sewn_upgradeState_temporary_delay <= game:GetFrameCount() then
        sewingMachineMod:removeTemporaryUpgrade(familiar)
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
        end
        -- Not available familiars
        if not sewingMachineMod:isAvailable(familiar.Variant) or sewingMachineMod:isUltra(fData) then
            if sewingMachineMod.Config.familiarNotAllowedEffect == sewingMachineMod.CONFIG_CONSTANT.NOT_ALLOWED_FAMILIARS_EFFECT.TRANSPARENT then
                familiar:SetColor(Color(fColor.R,fColor.G,fColor.B,0.5,fColor.RO,fColor.GO,fColor.BO),5,1,false,false)
            end
        end
    end

    if familiar.Variant == FamiliarVariant.ANN_S_TAINTED_HEAD or familiar.Variant == FamiliarVariant.ANN_S_PURE_BODY or familiar.Variant == FamiliarVariant.ANN then
        familiar:FollowParent()
    end
    
    --Sewn_spriteScale_multiplier
    if fData.Sewn_spriteScale_multiplier ~= nil then
        familiar.SpriteScale = Vector(1 * fData.Sewn_spriteScale_multiplier, 1 * fData.Sewn_spriteScale_multiplier)
    end
    -- Custom update function
    if fData.Sewn_custom_update ~= nil then
        local d = {}
        for i, f in ipairs(fData.Sewn_custom_update) do
            d.customFunction = f
            d:customFunction(familiar)
        end
    end
    
    -- Custom animation
    if fData.Sewn_custom_animation ~= nil then
        for animationName, _function in pairs(fData.Sewn_custom_animation) do
            -- If familiar plays an animation
            if familiar:GetSprite():IsPlaying(animationName) or familiar:GetSprite():IsFinished(animationName) then
                local d = {}
                d.customFunction = _function
                d:customFunction(familiar, effect)
            end
        end
    end
end

-------------------------
-- MC_PRE_ENTITY_SPAWN --
-------------------------
function sewingMachineMod:entitySpawn(type, variant, subtype, pos, vel, spawner, seed)


    -- If a pickup spawn from a sewing machine, it means the machine as been bombed
    -- So we remove those pickups and spawn a new sewing machine so it's like the machine hasn't been damaged
    if type == EntityType.ENTITY_PICKUP then
        local room = game:GetLevel():GetCurrentRoom()
        for _, machine in pairs(sewingMachineMod:getAllSewingMachines()) do
            local mData = sewingMachineMod.sewingMachinesData[machine.InitSeed]

            if machine.Position:Distance(pos, machine.Position) < 5 then

                if mData.Sewn_currentFamiliarVariant ~= nil then
                    sewingMachineMod:getFamiliarBack(machine, false)
                end

                mData.Sewn_machineBombed = true

                if mData.Sewn_isMachineBroken == true then
                    machine:GetSprite():Play("Broken", true)
                end

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

function sewingMachineMod:hideCrown(familiar, hideCrown)
    local fData = familiar:GetData()
    if hideCrown == nil then
        hideCrown = true
    end
    fData.Sewn_crown_hide = hideCrown
end

-----------------------------
-- MC_POST_FAMILIAR_RENDER --
-----------------------------
function sewingMachineMod:renderFamiliar(familiar, offset)
    local fData = familiar:GetData()
    local pos = Isaac.WorldToScreen(familiar.Position)
    if sewingMachineMod.Config.familiarCrownPosition == sewingMachineMod.CONFIG_CONSTANT.FAMILIAR_CROWN_POSITION.CENTER then
        pos = Vector(pos.X-1, pos.Y - familiar.Size * 2)
    elseif sewingMachineMod.Config.familiarCrownPosition == sewingMachineMod.CONFIG_CONSTANT.FAMILIAR_CROWN_POSITION.RIGHT then
        pos = Vector(pos.X + familiar.Size, pos.Y - familiar.Size * 2)
    end

    if fData.Sewn_crown == nil then
        fData.Sewn_crown = Sprite()
        fData.Sewn_crown:Load("gfx/sewn_familiar_crown.anm2", false)
        if sewingMachineMod:isSuper(fData) then
            fData.Sewn_crown:Play("Super")
        elseif sewingMachineMod:isUltra(fData) then
            fData.Sewn_crown:Play("Ultra")
        end
        fData.Sewn_crown:LoadGraphics()
    end
    --if fData.Sewn_crown_hide == nil or fData.Sewn_crown_hide == false then
    if fData.Sewn_crown_hide ~= true then
        -- if familiar is super -> has a golden crown
        if sewingMachineMod:isSuper(fData) then
            fData.Sewn_crown:Render(pos, Vector(0,0), Vector(0,0))
        end
        -- if familiar is ultra-> has a diamond crown
        if sewingMachineMod:isUltra(fData) then
            fData.Sewn_crown:Render(pos, Vector(0,0), Vector(0,0))
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
        local d = {}
        for i, f in ipairs(fData.Sewn_custom_collision) do
            d.customFunction = f
            d:customFunction(familiar, collider)
        end
    end
end
----------------------
-- MC_POST_NEW_ROOM --
----------------------
function sewingMachineMod:newRoom()
    local room = game:GetLevel():GetCurrentRoom()

    sewingMachineMod.displayTrueCoopMessage = false

    for i, familiar in ipairs(temporaryFamiliars) do
        -- if familiars spawn earlier are still there on new rooms -> Add them to available familiars
        if familiar:Exists() then
            table.insert(familiar.Player:GetData().Sewn_familiars, familiar)
            temporaryFamiliars[i] = nil
        end
    end

    -- Remove temporary upgardes (for Sewing Box only)
    for i = 1, game:GetNumPlayers() do
        local player = Isaac.GetPlayer(i - 1)
        local sprite = player:GetSprite()

        if player:GetData().Sewn_hasTemporaryUpgradedFamiliars == true then
            for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
                local fData = familiar:GetData()
                familiar = familiar:ToFamiliar()

                if fData.Sewn_upgradeState_temporary_delay == nil then
                    sewingMachineMod:removeTemporaryUpgrade(familiar)
                end
            end
            player:GetData().Sewn_hasTemporaryUpgradedFamiliars = nil
        end
    end

    if room:IsFirstVisit() == true then
        if room:GetType() == RoomType.ROOM_ARCADE then
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
        elseif room:GetType() == RoomType.ROOM_ISAACS or room:GetType() == RoomType.ROOM_BARREN then
            sewingMachineMod:spawnMachine()
        elseif room:GetType() == RoomType.ROOM_SHOP and sewingMachine_shouldAppear_shop then
            if room:IsClear() then
                sewingMachineMod:spawnMachine()
            end
        elseif room:GetType() == RoomType.ROOM_ANGEL or room:GetType() == RoomType.ROOM_DEVIL then
            for i = 1, game:GetNumPlayers() do
                local player = Isaac.GetPlayer(i - 1)
                local roll = sewingMachineMod.rng:RandomInt(100) + 1
                if player:HasTrinket(TrinketType.TRINKET_CONTRASTED_BUTTON) and roll < 50 then
                    sewingMachineMod:spawnMachine(nil, true)
                end
            end
        end
    end

    for _, machine in pairs(sewingMachineMod:getAllSewingMachines()) do
        if sewingMachineMod.sewingMachinesData[machine.InitSeed].Sewn_currentFamiliarVariant ~= nil then
            sewingMachineMod:setFloatingAnim(machine)
        end
    end
    
    for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
        local fData = familiar:GetData()
        familiar = familiar:ToFamiliar()
        if fData.Sewn_custom_newRoom ~= nil then
            local d = {}
            for i, f in ipairs(fData.Sewn_custom_newRoom) do
                d.customFunction = f
                d:customFunction(familiar, room)
            end
        end
    end
end


------------------------------
-- MC_PRE_SPAWN_CLEAN_AWARD --
------------------------------
function sewingMachineMod:finishRoom(rng, spawnPosition)
    local room = game:GetLevel():GetCurrentRoom()
    if room:GetType() == RoomType.ROOM_SHOP and sewingMachine_shouldAppear_shop then
        -- Spawn machine when the shop is cleared
        sewingMachineMod:spawnMachine(nil, true)
    end
    
    -- It's supposed to be in the "familiars.lua" but it seems having several "MC_PRE_SPAWN_CLEAN_AWARD" cause error
    for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
        local fData = familiar:GetData()
        familiar = familiar:ToFamiliar()
        if fData.Sewn_custom_cleanAward ~= nil then
            local d = {}
            for i, f in ipairs(fData.Sewn_custom_cleanAward) do
                d.customFunction = f
                d:customFunction(familiar)
            end
        end
    end
end

-----------------------
-- MC_POST_NEW_LEVEL --
-----------------------
function sewingMachineMod:onNewFloor()
    sewingMachine_shouldAppear_shop = false
    local level = game:GetLevel()
    sewingMachineMod.sewingMachinesData = {}

    local roll = sewingMachineMod.rng:RandomInt(101)
    if roll < 20 then
        sewingMachine_shouldAppear_shop = true
    end

    -- BLUE WOMB
    if level:GetStage() == LevelStage.STAGE4_3 then
        sewingMachine_shouldAppear_shop = true
    end

    for i = 1, game:GetNumPlayers() do
        local player = Isaac.GetPlayer(i - 1)
        if player:GetData().Sewn_familiarsInMachine ~= nil then
            player:GetData().Sewn_familiarsInMachine = nil
            player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
            player:EvaluateItems()
        end
        if player:HasTrinket(TrinketType.TRINKET_LOST_BUTTON) then
            sewingMachine_shouldAppear_shop = true
        end
    end
end

--------------------------
-- MC_POST_TEAR_UPDATE --
--------------------------
function sewingMachineMod:tearUpdate(tear)
    local familiar = tear.Parent
    local fData
    
    -- If tear hasn't been fired from a familiar
    if tear.SpawnerType ~= EntityType.ENTITY_FAMILIAR or familiar == nil then
        return
    end

    familiar = familiar:ToFamiliar()
    fData = familiar:GetData()
    
    player = familiar.Player:ToPlayer()
    
    -- TEAR INIT 
    if not tear:GetData().Sewn_Init then
        
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
            local d = {}
            for i, f in ipairs(fData.Sewn_custom_fireInit) do
                d.customFunction = f
                d:customFunction(familiar, tear)
            end
        end
        
        tear:GetData().Sewn_Init = true
    end -- End Init tear

    -- If the tear hit the ground
    if fData.Sewn_custom_tearFall ~= nil then
        if tear.Height > -5 then
            local d = {}
            for i, f in ipairs(fData.Sewn_custom_tearFall) do
                d.customFunction = f
                d:customFunction(familiar, tear)
            end
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
        local d = {}
        for i, f in ipairs(fData.Sewn_custom_tearCollision) do
            d.customFunction = f
            d:customFunction(familiar, tear, collider)
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
                local d = {}
                for i, f in ipairs(fData.Sewn_custom_fireInit) do
                    d.customFunction = f
                    d:customFunction(familiar, laser)
                end
            end
            
            laser:GetData().Sewn_Init = true
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

        -- Player get "Ann's Tainted Head"
        if player:HasCollectible(CollectibleType.COLLECTIBLE_ANN_S_TAINTED_HEAD) and not pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_ANN_S_TAINTED_HEAD] then
            if not pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_ANN_S_PURE_BODY] then
                local annsHead = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ANN_S_TAINTED_HEAD, 0, player.Position, Vector(0,0), player):ToFamiliar()
                annsHead:AddToFollowers()
            end
            -- Upgrade familiars
            for _, fam in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
                local fData = fam:GetData()
                if fData.Sewn_upgradeState == 0 and not player:HasCollectible(CollectibleType.COLLECTIBLE_ANN_S_PURE_BODY) then
                    fData.Sewn_upgradeState = 1
                    sewingMachineMod:callFamiliarUpgrade(fam)
                elseif player:HasCollectible(CollectibleType.COLLECTIBLE_ANN_S_PURE_BODY) and not sewingMachineMod:isUltra(fData) then
                    fData.Sewn_upgradeState = 2
                    sewingMachineMod:callFamiliarUpgrade(fam)
                end
            end
            pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_ANN_S_TAINTED_HEAD] = true
        end
        -- Player lose "Ann's Tainted Head"
        if not player:HasCollectible(CollectibleType.COLLECTIBLE_ANN_S_TAINTED_HEAD) and pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_ANN_S_TAINTED_HEAD] then
            sewingMachineMod:removeAnnsTaintedHead()
            pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_ANN_S_TAINTED_HEAD] = false
        end


        -- Player get "Ann's Pure Body"
        if player:HasCollectible(CollectibleType.COLLECTIBLE_ANN_S_PURE_BODY) and not pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_ANN_S_PURE_BODY] then
            if not pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_ANN_S_TAINTED_HEAD] then
                local annsBody = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ANN_S_PURE_BODY, 0, player.Position, Vector(0,0), player):ToFamiliar()
                annsBody:AddToFollowers()
            end
            -- Upgrade familiars
            for _, fam in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
                local fData = fam:GetData()
                if fData.Sewn_upgradeState == 0 and not player:HasCollectible(CollectibleType.COLLECTIBLE_ANN_S_TAINTED_HEAD) then
                    fData.Sewn_upgradeState = 1
                    sewingMachineMod:callFamiliarUpgrade(fam)
                elseif player:HasCollectible(CollectibleType.COLLECTIBLE_ANN_S_TAINTED_HEAD) and not sewingMachineMod:isUltra(fData) then
                    fData.Sewn_upgradeState = 2
                    sewingMachineMod:callFamiliarUpgrade(fam)
                end
            end
            pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_ANN_S_PURE_BODY] = true
        end
        -- Player lose "Ann's Pure Body"
        if not player:HasCollectible(CollectibleType.COLLECTIBLE_ANN_S_PURE_BODY) and pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_ANN_S_PURE_BODY] then
            sewingMachineMod:removeAnnsPureBody()
            pData.Sewn_hasItem[CollectibleType.COLLECTIBLE_ANN_S_PURE_BODY] = false
        end

        if player:HasCollectible(CollectibleType.COLLECTIBLE_ANN_S_PURE_BODY) and player:HasCollectible(CollectibleType.COLLECTIBLE_ANN_S_TAINTED_HEAD) and not pData.Sewn_hasFullAnn then
            local ann = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ANN, 0, player.Position, Vector(0,0), player):ToFamiliar()
            ann:AddToFollowers()
            sewingMachineMod:removeAnnsTaintedHead()
            sewingMachineMod:removeAnnsPureBody()
            pData.Sewn_hasFullAnn = true
        end
    end
    
    for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
        familiar = familiar:ToFamiliar()
        if familiar.Player and GetPtrHash(familiar.Player) == GetPtrHash(player) then
            local fData = familiar:GetData()
            if fData.Sewn_custom_cache ~= nil then
                local d = {}
                for i, f in ipairs(fData.Sewn_custom_cache) do
                    d.customFunction = f
                    d:customFunction(familiar, cacheFlag)
                end
            end
        end
    end
end

function sewingMachineMod:removeAnnsTaintedHead()
    for _, annsHead in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ANN_S_TAINTED_HEAD, -1, false, false)) do
        annsHead:Remove()
    end
end

function sewingMachineMod:removeAnnsPureBody()
    for _, annsBody in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ANN_S_PURE_BODY, -1, false, false)) do
        annsBody:Remove()
    end
end


--------------------
-- MC_POST_UPDATE --
--------------------
function sewingMachineMod:onUpdate()
    -- Call delayed functions
    for i, data in pairs(sewingMachineMod.delayedFunctions) do
        if data.FRAME + data.DELAY < game:GetFrameCount() then
            local f = {}
            f.customFunction = data.FUNCTION
            f:customFunction(data.PARAM)
            table.remove(sewingMachineMod.delayedFunctions, i)
        end
    end
end

--------------------
-- MC_POST_RENDER --
--------------------
function sewingMachineMod:onRender()
    if GiantBook:IsPlaying("Appear") then
        GiantBook:RenderLayer(0, Isaac.WorldToRenderPosition(Vector(320,300), true))
    end
    
    sewingMachineMod:renderEID()
end

---------------------------------------
-- MC_ENTITY_TAKE_DMG - EntityPlayer --
---------------------------------------
function sewingMachineMod:playerTakeDamage(player, damageAmount, damageFlags, damageSource, damageCountdownFrames)
    local countCrowns = 0
    local familiars = {}
    player = player:ToPlayer()
    if player:HasTrinket(TrinketType.TRINKET_CRACKED_THIMBLE) then
        for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
            local fData = familiar:GetData()
            familiar = familiar:ToFamiliar()
            if GetPtrHash(familiar.Player) == GetPtrHash(player) and sewingMachineMod:isAvailable(familiar.Variant) then
                table.insert(familiars, familiar)
                countCrowns = countCrowns + fData.Sewn_upgradeState
                fData.Sewn_upgradeState = sewingMachineMod.UpgradeState.NORMAL

                sewingMachineMod:resetFamiliarData(familiar)
            end
        end
        while #familiars > 0 and countCrowns > 0 do
            local familiar_index = math.random(#familiars) -- sewingMachineMod.rng:RandomInt(#familiars) + 1
            local fData = familiars[familiar_index]:GetData()
            if not sewingMachineMod:isUltra(fData) then
                fData.Sewn_upgradeState = fData.Sewn_upgradeState + 1
                countCrowns = countCrowns -1

                sewingMachineMod:callFamiliarUpgrade(familiars[familiar_index])
            end
            if sewingMachineMod:isUltra(fData) then
                table.remove(familiars, familiar_index)
            end
        end
    end
    for _, familiar in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, -1, -1, false, false)) do
        local fData = familiar:GetData()
        familiar = familiar:ToFamiliar()
        if fData.Sewn_custom_playerTakeDamage ~= nil then
            local d = {}
            for i, f in ipairs(fData.Sewn_custom_playerTakeDamage) do
                d.customFunction = f
                d:customFunction(familiar, damageSource, damageAmount, damageFlags)
            end
        end
    end
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
    local room = game:GetLevel():GetCurrentRoom()

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
    
    -- Set familiar description
    sewingMachineMod:InitFamiliarDescription()
end


-- Used for debug
function sewingMachineMod:printTables(table, indent)
    if type(table) == "table" then
        if indent == nil then
            Isaac.DebugString("-------- PRINT_TABLE --------")
            indent = 0
        end
        local strIndent = ""
        for i = 0, indent * 3 do
            strIndent = strIndent .. " "
        end
        for key, value in pairs(table) do
            if type(value) ~= "table" then
                Isaac.DebugString(strIndent .. tostring(key) .. " ; " .. tostring(value))
            else
                Isaac.DebugString(strIndent .. tostring(key))
                sewingMachineMod:printTables(value, indent +1)
            end
        end
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
sewingMachineMod:AddCallback(ModCallbacks.MC_GET_CARD, sewingMachineMod.getCard)
sewingMachineMod:AddCallback(ModCallbacks.MC_USE_CARD, sewingMachineMod.useWunjo, Card.RUNE_WUNJO)
sewingMachineMod:AddCallback(ModCallbacks.MC_USE_CARD, sewingMachineMod.useNaudiz, Card.RUNE_NAUDIZ)
sewingMachineMod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, sewingMachineMod.initPickup)

-- Rooms related callbacks
sewingMachineMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, sewingMachineMod.newRoom)
sewingMachineMod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, sewingMachineMod.onNewFloor)
sewingMachineMod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, sewingMachineMod.finishRoom)

-- Entities related callbacks
sewingMachineMod:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, sewingMachineMod.entitySpawn)

-- Game related callbacks
sewingMachineMod:AddCallback(ModCallbacks.MC_POST_UPDATE, sewingMachineMod.onUpdate)
sewingMachineMod:AddCallback(ModCallbacks.MC_POST_RENDER, sewingMachineMod.onRender)

-- Saving/Loading related callbacks
sewingMachineMod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, sewingMachineMod.saveGame)
sewingMachineMod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, sewingMachineMod.loadSave)
