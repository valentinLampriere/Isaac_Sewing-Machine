local CustomCallbacks = require("sewn_scripts.callbacks.custom_callbacks")

local PostMachineUpdateHandler = require("sewn_scripts.callbacks.custom.handlers.post_machine_update_handler")
local PostPlayerTouchMachineHandler = require("sewn_scripts.callbacks.custom.handlers.post_player_touch_machine_handler")
local PostMachineDestroyHandler = require("sewn_scripts.callbacks.custom.handlers.post_machine_destroy_handler")
local PostTearInitHandler = require("sewn_scripts.callbacks.custom.handlers.post_tear_init_handler")
local PostFamiliarFireTearHandler = require("sewn_scripts.callbacks.custom.handlers.post_familiar_fire_tear_handler")
local PostLaserInitHandler = require("sewn_scripts.callbacks.custom.handlers.post_laser_init_handler")
local PostFamiliarFireLaserHandler = require("sewn_scripts.callbacks.custom.handlers.post_familiar_fire_laser_handler")
local PostFamiliarTearUpdateHandler = require("sewn_scripts.callbacks.custom.handlers.post_familiar_tear_update_handler")
local GetLoseCollectibleHandler = require("sewn_scripts.callbacks.custom.handlers.get_lose_collectible_handler")
local GetLoseTrinketHandler = require("sewn_scripts.callbacks.custom.handlers.get_lose_trinket_handler")
local PreGetFamiliarFromSewingMachineHandler = require("sewn_scripts.callbacks.custom.handlers.pre_get_familiar_from_sewing_machine_handler")
local PostGetFamiliarFromSewingMachineHandler = require("sewn_scripts.callbacks.custom.handlers.post_get_familiar_from_sewing_machine_handler")
local FamiliarUpdateHandler = require("sewn_scripts.callbacks.custom.handlers.familiar_update_handler")
local FamiliarHitNpcHandler = require("sewn_scripts.callbacks.custom.handlers.familiar_hit_npc_handler")
local FamiliarKillNpcHandler = require("sewn_scripts.callbacks.custom.handlers.familiar_kill_npc_handler")
local PostFamiliarPlayAnimHandler = require("sewn_scripts.callbacks.custom.handlers.post_familiar_play_anim_handler")
local PostFamiliarNewRoomHandler = require("sewn_scripts.callbacks.custom.handlers.post_familiar_new_room_handler")
local OnFamiliarUpgradedHandler = require("sewn_scripts.callbacks.custom.handlers.on_familiar_upgraded_handler")
local PostFamiliarNewLevelHandler = require("sewn_scripts.callbacks.custom.handlers.post_familiar_new_level_handler")
local PreFamiliarTearCollision = require("sewn_scripts.callbacks.custom.handlers.pre_familiar_tear_collision")
local FamiliarCleanRoom = require("sewn_scripts.callbacks.custom.handlers.familiar_clean_room")
local PreAddFamiliarInSewingMachineHandler = require("sewn_scripts.callbacks.custom.handlers.pre_add_familiar_in_sewing_machine")
local OnFamiliarLoseUpgradeHandler = require("sewn_scripts.callbacks.custom.handlers.on_familiar_lose_upgrade_handler")

local postUpdate = { }
local postTearUpdate = { }
local postLaserUpdate = { }
local peffectUpdate = { }
local familiarUpdate = { }
local entityTakeDamage = { }
local postNewRoom = { }
local postNewLevel = { }
local preTearCollision = { }
local preSpawnCleanAward = { }

local customCallbacks = { }

local function InitCallback(callback)
	callback["RegisteredCallbacks"] = { }
	CustomCallbacks:InitCallback(callback["ID"], callback["RegisteredCallbacks"], callback["DefaultArguments"])
	
	if callback.PostUpdate ~= nil then
		table.insert(postUpdate, callback.PostUpdate)
	end
	if callback.PostTearUpdate ~= nil then
		table.insert(postTearUpdate, callback.PostTearUpdate)
	end
	if callback.PostLaserUpdate ~= nil then
		table.insert(postLaserUpdate, callback.PostLaserUpdate)
	end
	if callback.PeffectUpdate ~= nil then
		table.insert(peffectUpdate, callback.PeffectUpdate)
	end
	if callback.FamiliarUpdate ~= nil then
		table.insert(familiarUpdate, callback.FamiliarUpdate)
	end
	if callback.EntityTakeDamage ~= nil then
		table.insert(entityTakeDamage, callback.EntityTakeDamage)
	end
	if callback.PostNewRoom ~= nil then
		table.insert(postNewRoom, callback.PostNewRoom)
	end
	if callback.PostNewLevel ~= nil then
		table.insert(postNewLevel, callback.PostNewLevel)
	end
	if callback.PreTearCollision ~= nil then
		table.insert(preTearCollision, callback.PreTearCollision)
	end
	if callback.PreSpawnCleanAward ~= nil then
		table.insert(preSpawnCleanAward, callback.PreSpawnCleanAward)
	end

	customCallbacks[callback["ID"]] = callback

	if callback.Init ~= nil then
		callback:Init()
	end
end

InitCallback(PostMachineUpdateHandler)
InitCallback(PostPlayerTouchMachineHandler)
InitCallback(PostMachineDestroyHandler)
InitCallback(PostTearInitHandler)
InitCallback(PostFamiliarFireTearHandler)
InitCallback(PostLaserInitHandler)
InitCallback(PostFamiliarFireLaserHandler)
InitCallback(PostFamiliarTearUpdateHandler)
InitCallback(GetLoseCollectibleHandler)
InitCallback(GetLoseTrinketHandler)
InitCallback(PreGetFamiliarFromSewingMachineHandler)
InitCallback(PostGetFamiliarFromSewingMachineHandler)
InitCallback(FamiliarUpdateHandler)
InitCallback(FamiliarHitNpcHandler)
InitCallback(FamiliarKillNpcHandler)
InitCallback(PostFamiliarPlayAnimHandler)
InitCallback(PostFamiliarNewRoomHandler)
InitCallback(OnFamiliarUpgradedHandler)
InitCallback(PostFamiliarNewLevelHandler)
InitCallback(PreFamiliarTearCollision)
InitCallback(FamiliarCleanRoom)
InitCallback(PreAddFamiliarInSewingMachineHandler)
InitCallback(OnFamiliarLoseUpgradeHandler)

local CustomCallbacksHandler = { }

function CustomCallbacksHandler:PostUpdate()
	for _, _function in ipairs(postUpdate) do
		_function(_)
	end
end
function CustomCallbacksHandler:PostTearUpdate(tear)
	for _, _function in ipairs(postTearUpdate) do
		_function(_, tear)
	end
end
function CustomCallbacksHandler:PostLaserUpdate(laser)
	for _, _function in ipairs(postLaserUpdate) do
		_function(_, laser)
	end
end
function CustomCallbacksHandler:PeffectUpdate(player)
	for _, _function in ipairs(peffectUpdate) do
		_function(_, player)
	end
end
function CustomCallbacksHandler:FamiliarUpdate(player)
	for _, _function in ipairs(familiarUpdate) do
		_function(_, player)
	end
end
function CustomCallbacksHandler:EntityTakeDamage(entity, amount, flags, source, countdown)
	for _, _function in ipairs(entityTakeDamage) do
		_function(_, entity, amount, flags, source, countdown)
	end
end
function CustomCallbacksHandler:PostNewRoom()
	for _, _function in ipairs(postNewRoom) do
		_function(_)
	end
end
function CustomCallbacksHandler:PostNewLevel()
	for _, _function in ipairs(postNewLevel) do
		_function(_)
	end
end
function CustomCallbacksHandler:PreTearCollision(tear, collider)
	for _, _function in ipairs(preTearCollision) do
		local ignoreCollision = _function(_, tear, collider)
		if ignoreCollision ~= nil then
			return ignoreCollision
		end
	end
end
function CustomCallbacksHandler:PreSpawnCleanAward()
	for _, _function in ipairs(preSpawnCleanAward) do
		_function(_)
	end
end

function CustomCallbacksHandler:Evaluate(callbackId, ...)
	local args = {...}
	print(callbackId)
	return customCallbacks[callbackId]:Evaluate(table.unpack(args))
end


return CustomCallbacksHandler