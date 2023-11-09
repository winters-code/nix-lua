
local UnOp = {
}
UnOp.__index = UnOp

function UnOp.new(operator, right)
    local self = setmetatable({}, UnOp)

    self.operator = operator
    self.right = right

    return self
end

function UnOp.__tostring(t)
    return string.format("(op: %s, right: %s)", self.operator, self.right)
end

function UnOp:Operate()
end

return UnOp
