local TableHelper = { }

function TableHelper:CopyTable(table)
    if type(table) ~= "table" then
        return table
    end

    local copyTable = { }

    for key, value in pairs(table) do
        copyTable[key] = TableHelper:CopyTable(value)
    end

    return copyTable
end

return TableHelper