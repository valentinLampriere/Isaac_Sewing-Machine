local CustomCallbacks = require("sewn_scripts/callbacks/custom_callbacks")

local PostMachineUpdateHandler = require("sewn_scripts/callbacks/custom/handlers/post_machine_update_handler")
local PostPlayerTouchMachineHandler = require("sewn_scripts/callbacks/custom/handlers/post_player_touch_machine_handler")
local PostMachineDestroyHandler = require("sewn_scripts/callbacks/custom/handlers/post_machine_destroy_handler")
local PostTearInitHandler = require("sewn_scripts/callbacks/custom/handlers/post_tear_init_handler")
local PostFamiliarFireTearHandler = require("sewn_scripts/callbacks/custom/handlers/post_familiar_fire_tear_handler")
local PostLaserInitHandler = require("sewn_scripts/callbacks/custom/handlers/post_laser_init_handler")
local PostFamiliarFireLaserHandler = require("sewn_scripts/callbacks/custom/handlers/post_familiar_fire_laser_handler")
local PostFamiliarTearUpdateHandler = require("sewn_scripts/callbacks/custom/handlers/post_familiar_tear_update_handler")
local GetLoseCollectibleHandler = require("sewn_scripts/callbacks/custom/handlers/get_lose_collectible_handler")
local GetLoseTrinketHandler = require("sewn_scripts/callbacks/custom/handlers/get_lose_trinket_handler")
local PreGetFamiliarFromSewingMachineHandler = require("sewn_scripts/callbacks/custom/handlers/pre_get_familiar_from_sewing_machine_handler")
local PostGetFamiliarFromSewingMachineHandler = require("sewn_scripts/callbacks/custom/handlers/post_get_familiar_from_sewing_machine_handler")


local postUpdate = { }
local postTearUpdate = { }
local postLaserUpdate = { }
local peffectUpdate = { }

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

function CustomCallbacksHandler:Evaluate(callbackId, ...)
	local args = {...}
	return customCallbacks[callbackId]:Evaluate(table.unpack(args))
end


return CustomCallbacksHandler