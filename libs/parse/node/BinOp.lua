
local BinOp = require("libs.parse.node")
BinOp.__index = BinOp

require("libs.rebind")
require("libs.consts")

function BinOp.new(left, operator, right)
    local self = setmetatable({}, BinOp)

    self.left = left
    self.operator = operator
    self.right = right

    return self
end

function BinOp.__tostring(t)
    return string.format("(BinOpNode(%s %s %s))", tostring(t.left), tostring(t.operator), tostring(t.right))
end

function BinOp:Operate()
    local leftValue = self.left
    if typeof(leftValue) == 'Node' then leftValue = leftValue:Operate() end
    local rightValue = self.right
    if typeof(rightValue) == 'Node' then rightValue = rightValue:Operate() end

    local operation = OPERATIONS[self.operator.data]
    self[operation](self)
end

function BinOp:Add()
    print("Add")
end

return BinOp