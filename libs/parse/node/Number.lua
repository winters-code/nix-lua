
local Number = require('libs.dc.error')
Number.__index = Number

local Result = require('libs.inter.res')

function Number.new(val)
    local self = setmetatable({}, Number)

    self.value = val

    return self
end

function Number:Operate()
    return Result.new(tonumber(self.value.data), nil)
end
function Number:SetPosition(pos)
    self.position = pos
    return self
end

function Number.__tostring(t)
    return string.format("(NumberNode(val: %s))", t.value.data)
end

return Number
