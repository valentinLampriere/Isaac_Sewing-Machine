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

	for i, value in ipairs(args) do
		table.insert(arguments, value)
	end
	for i, defaultValue in ipairs(callbackDefaultValues[callbackId]) do
		arguments[i] = arguments[i] or callbackDefaultValues[callbackId][i]
	end

	table.insert(registeredCallbacks[callbackId], {
		Function = _function,
		Argument = arguments
	})
end

return CustomCallbacks