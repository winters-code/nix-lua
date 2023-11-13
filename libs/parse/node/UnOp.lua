
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
    return string.format("(UnOpNode(op: %s, right: %s))", self.operator, self.right)
end

function UnOp:Operate()
end

function UnOp:SetError(err)
    self.error = err
end

return UnOp
