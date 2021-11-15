local CustomCallbacks = { }

local registeredCallbacks = { }
local callbackDefaultValues = { }

function CustomCallbacks:InitCallback(callbackId, handlerTable, defaultValues)
	callbackDefaultValues[callbackId] = defaultValues or { }
	registeredCallbacks[callbackId] = handlerTable
end

function CustomCallbacks:AddCallback(callbackId, _function, ...)
	local args = {...}

	if registeredCallbacks[callbackId] == nil then
		return
	end

	if _function == nil then
		return
	end

	local arguments = { }

	for i = 1, #args do
		table.insert(arguments, args[i] or callbackDefaultValues[callbackId][i])
	end
	for i = #args, #callbackDefaultValues[callbackId] do
		table.insert(arguments, callbackDefaultValues[callbackId][i])
	end
	
	table.insert(registeredCallbacks[callbackId], {
		Function = _function,
		Argument = arguments
	})
end

return CustomCallbacks