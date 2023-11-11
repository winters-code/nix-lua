
local BinOp = require("libs.parse.node")
BinOp.__index = BinOp

local Result = require('libs.inter.res')
local InvalidOperationError = require('libs.dc.error.InvalidOperationError')

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
    
    local leftValue = self.left:Operate()
    local rightValue = self.right:Operate()

    if leftValue.error then
        return leftValue
    elseif rightValue.error then
        return rightValue
    end

    local a = leftValue.value
    local b = rightValue.value

    local op = self.operator.tokenType
    local res

    if op == TokenType.TT_ADD then
        res = self:Add(a, b)
    elseif op == TokenType.TT_SUB then
        res = self:Sub(a, b)
    elseif op == TokenType.TT_MUL then
        res = self:Mul(a, b)
    elseif op == TokenType.TT_DIV then
        res = self:Div(a, b)
    end

    if typeof(res) == "Error" then
        return Result.new(nil, res)
    end

    return Result.new(res, nil)

end

function BinOp:Add(a, b)
    return a + b
end
function BinOp:Sub(a, b)
    return a - b
end
function BinOp:Mul(a, b)
    return a * b
end
function BinOp:Div(a, b)
    if b == 0 then
        return InvalidOperationError.new("Division by zero")
    end
    return a / b
end

return BinOp