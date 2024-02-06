local UnOp = require('libs.parse.node')
UnOp.__index = UnOp
UnOp.__type = 'UnOp'

function UnOp.new(operator, right)
    local self = setmetatable({}, UnOp)

    self.operator = operator
    self.right = right

    return self
end

function UnOp.__tostring(t)
    return string.format("(UnOpNode(op: %s, right: %s))", t.operator, t.right)
end

function UnOp:Operate()
end

function UnOp:SetPosition(pos)
    self.position = pos
    return self
end

function UnOp:SetError(err)
    self.error = err
    return self
end

return UnOp
