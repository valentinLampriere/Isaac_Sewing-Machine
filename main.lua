local SewnMod = RegisterMod("!Sewing machine rework", 1)

Sewn_API = require("sewn_scripts.sewn_api")


require("sewn_scripts.helpers.embeddablecallbackhack")
require("sewn_scripts.helpers.apioverride")

local Enums = require("sewn_scripts.core.enums")
local Globals = require("sewn_scripts.core.globals")
local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")
local CustomCallbacksHandler = require("sewn_scripts.callbacks.custom_callbacks_handler")

local SaveManager = require("sewn_scripts.core.save_manager")
SaveManager:Init(SewnMod)

-- Player related callbacks
local PostPeffectUpdate = require("sewn_scripts.callbacks.vanilla.post_peffect_update")
local EvaluateCache = require("sewn_scripts.callbacks.vanilla.evaluate_cache")
local PostPlayerInit = require("sewn_scripts.callbacks.vanilla.post_player_init")
-- Pickup related callbacks
local UseItem = require("sewn_scripts.callbacks.vanilla.use_item")
local GetLoseCollectible = require("sewn_scripts.callbacks.custom.get_lose_collectible")
local UseCard = require("sewn_scripts.callbacks.vanilla.use_card")
local GetCard = require("sewn_scripts.callbacks.vanilla.get_card")
-- Familiar related callbacks
local FamiliarUpdate = require("sewn_scripts.callbacks.vanilla.familiar_update")
local PostFamiliarRender = require("sewn_scripts.callbacks.vanilla.post_familiar_render")
local PreFamiliarCollision = require("sewn_scripts.callbacks.vanilla.pre_familiar_collision")
-- Entities related callbacks
local PostEffectUpdate = require("sewn_scripts.callbacks.vanilla.post_effect_update")
local PostEffectInit = require("sewn_scripts.callbacks.vanilla.post_effect_init")
local EntityTakeDamage = require("sewn_scripts.callbacks.vanilla.entity_take_damage")
-- Tear.Laser related callbacks
local PostTearUpdate = require("sewn_scripts.callbacks.vanilla.post_tear_update")
local PreTearCollision = require("sewn_scripts.callbacks.vanilla.pre_tear_collision")
local PostLaserUpdate = require("sewn_scripts.callbacks.vanilla.post_laser_update")
-- Level related callbacks
local PostNewRoom = require("sewn_scripts.callbacks.vanilla.post_new_room")
local PostNewLevel = require("sewn_scripts.callbacks.vanilla.post_new_level")
local PreSpawnCleanAward = require("sewn_scripts.callbacks.vanilla.pre_spawn_clean_award")
-- Game related callbacks
local PostUpdate = require("sewn_scripts.callbacks.vanilla.post_update")
local PreGameExit = require("sewn_scripts.callbacks.vanilla.pre_game_exit")
local PostGameStarted = require("sewn_scripts.callbacks.vanilla.post_game_started")
-- Sewing Machine related callbacks
local PostMachineUpdate = require("sewn_scripts.callbacks.custom.post_machine_update")
local PostPlayerTouchMachine = require("sewn_scripts.callbacks.custom.post_player_touch_machine")
local PostMachineDestroy = require("sewn_scripts.callbacks.custom.post_machine_destroy")

-- Player related callbacks
SewnMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, PostPeffectUpdate)
SewnMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, PostPlayerInit)
SewnMod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, EvaluateCache)
-- Pickup related callbacks
SewnMod:AddCallback(ModCallbacks.MC_USE_ITEM, UseItem)
CustomCallbacks:AddCallback(Enums.ModCallbacks.GET_LOSE_COLLECTIBLE, GetLoseCollectible.LilDelirium, CollectibleType.COLLECTIBLE_LIL_DELIRIUM)
CustomCallbacks:AddCallback(Enums.ModCallbacks.GET_LOSE_COLLECTIBLE, GetLoseCollectible.DollsTaintedHead, Enums.CollectibleType.COLLECTIBLE_DOLL_S_TAINTED_HEAD)
CustomCallbacks:AddCallback(Enums.ModCallbacks.GET_LOSE_COLLECTIBLE, GetLoseCollectible.DollsPureBody, Enums.CollectibleType.COLLECTIBLE_DOLL_S_PURE_BODY)
SewnMod:AddCallback(ModCallbacks.MC_GET_CARD, GetCard)
SewnMod:AddCallback(ModCallbacks.MC_USE_CARD, UseCard)
-- Familiar related callbacks
SewnMod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, FamiliarUpdate)
SewnMod:AddCallback(ModCallbacks.MC_POST_FAMILIAR_RENDER, PostFamiliarRender)
SewnMod:AddCallback(ModCallbacks.MC_PRE_FAMILIAR_COLLISION, PreFamiliarCollision)
-- Entity related callbacks
SewnMod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, EntityTakeDamage)
SewnMod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, PostEffectUpdate)
SewnMod:AddCallback(ModCallbacks.MC_POST_EFFECT_INIT, PostEffectInit)
-- Tear/Laser related callbacks
SewnMod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, PostTearUpdate)
SewnMod:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, PreTearCollision)
SewnMod:AddCallback(ModCallbacks.MC_POST_LASER_UPDATE, PostLaserUpdate)
-- Level related callbacks
SewnMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, PostNewRoom)
SewnMod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, PostNewLevel)
SewnMod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, PreSpawnCleanAward)
-- Game related callbacks
SewnMod:AddCallback(ModCallbacks.MC_POST_UPDATE, PostUpdate)
SewnMod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, PreGameExit)
SewnMod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, PostGameStarted)
-- Sewing Machine related callbacks
CustomCallbacks:AddCallback(Enums.ModCallbacks.POST_MACHINE_UPDATE, PostMachineUpdate, Enums.SlotMachineVariant.SEWING_MACHINE, true)
CustomCallbacks:AddCallback(Enums.ModCallbacks.POST_PLAYER_TOUCH_MACHINE, PostPlayerTouchMachine, Enums.SlotMachineVariant.SEWING_MACHINE)
CustomCallbacks:AddCallback(Enums.ModCallbacks.POST_MACHINE_DESTROY, PostMachineDestroy, Enums.SlotMachineVariant.SEWING_MACHINE)


require("sewn_scripts.entities.familiar.upgrades.prepare_vanilla_familiars")
require("sewn_scripts.items.new_trinkets")

require("sewn_scripts.mod_compat.eid.eid")