
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

function table.stringify(tb)
    local str = "{\n"
    for k, v in pairs(tb) do
        str = str .. "\t" .. (k .. " = " .. tostring(v)) .. "\n"
    end
    str = str .. "}"
    return str
end