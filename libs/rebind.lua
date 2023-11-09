
--// Split a string by characters
function string.split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

--// Turn a table into a nicely formatted string
function table.stringify(tb)
    local str = "{\n"
    for k, v in pairs(tb) do
        str = str .. "\t" .. (k .. " = " .. tostring(v)) .. "\n"
    end
    str = str .. "}"
    return str
end

--// Find a value in a table
function table.find(tb, val)
    for k, v in pairs(tb) do
        if v == val then return k end
    end
    return nil
end

--// Get the class type
typeof = function(o)
    if o.__type ~= nil then
        return o.__type()
    end
    return type(o)
end