if not APIOverride then
    APIOverride = {
        OverridenClasses = {}
    }
end

local metatable = getmetatable(EntityTear)
local function recursive__index(tbl, key, initial, noOverride)
    local meta = getmetatable(tbl)
    local val = rawget(meta, key)
    if val then
        if not noOverride then
            local initialType = getmetatable(initial or tbl).__type
            if APIOverride.OverridenClasses[initialType] and APIOverride.OverridenClasses[initialType][key] then
                return APIOverride.OverridenClasses[initialType][key]
            end
        end

        return val
    end

    local propget = rawget(meta, "__propget")
    if propget and propget[key] then
        return propget[key](initial or tbl)
    end

    local parent = rawget(meta, "__parent")
    if parent then
        return recursive__index(parent, key, initial or tbl)
    end
end

function APIOverride.OverrideClass(class)
    local class_mt = getmetatable(class).__class
    if not APIOverride.OverridenClasses[class_mt.__type] then
        APIOverride.OverridenClasses[class_mt.__type] = {}
        rawset(getmetatable(class).__class, "__index", recursive__index)
    end
end

function APIOverride.GetCurrentClassFunction(class, funcKey)
    local class_mt = getmetatable(class).__class
    if APIOverride.OverridenClasses[class_mt.__type] and APIOverride.OverridenClasses[class_mt.__type][funcKey] then
        return APIOverride.OverridenClasses[class_mt.__type][funcKey]
    else
        return recursive__index(class_mt, funcKey, nil, true)
    end
end

function APIOverride.OverrideClassFunction(class, funcKey, fn)
    local class_mt = getmetatable(class).__class
    APIOverride.OverrideClass(class)
    APIOverride.OverridenClasses[class_mt.__type][funcKey] = fn
end

--[[ Example, changes the Remove function on EntityTear only.
APIOverride.OverrideClassFunction(EntityTear, "Remove", function()
    Isaac.DebugString("no removing for you")
end)]]
