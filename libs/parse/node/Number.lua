
local Number = {
}
Number.__index = Number

function Number.new(val)
    local self = setmetatable({}, Number)

    self.value = val

    return self
end

function Number.__tostring(t)
    return string.format("(NumberNode(val: %s))", t.value.data)
end

return Number
