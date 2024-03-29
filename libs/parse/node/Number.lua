
local Number = require('libs.parse.node')
Number.__index = Number
Number.__type = 'Number'

local Result = require('libs.inter.res')

function Number.new(val)
    local self = setmetatable({}, Number)

    self.value = val

    return self
end

function Number:Get()
    return self.value
end

function Number:add(o)
    return Number.new(self.value + o.value)
end
function Number:sub(o)
    return Number.new(self.value - o.value)
end
function Number:mul(o)
    return Number.new(self.value * o.value)
end
function Number:div(o)
    return Number.new(self.value / o.value)
end

function Number:Operate()
    return Result.new(tonumber(self.value.data), nil)
end
function Number:SetPosition(pos)
    self.position = pos
    return self
end
function Number:SetError(err)
    self.error = err
    return self
end

function Number.__tostring(t)
    local d = t.value
    if t.value then d = t.value end
    return string.format("(NumberNode(val: %s, err: %s))", d, t.error)
end

return Number
