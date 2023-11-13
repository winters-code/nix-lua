
local BinOp = require("libs.parse.node")
BinOp.__index = BinOp

local Result = require('libs.inter.res')
local InvalidOperationError = require('libs.dc.error.InvalidOperationError')
local InvalidSyntaxError = require('libs.dc.error.InvalidSyntaxError')

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

    if not self.right then
        print(self.operator)
        return Result.new(nil, InvalidSyntaxError.new("Missing term on the right of the operation", self.operator))
    elseif not self.left then
        print(self.operator)
        return Result.new(nil, InvalidSyntaxError.new("Missing term on the left of the operation", self.operator))
    end
    
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
    elseif op == TokenType.TT_POW then
        res = self:Pow(a, b)
    end

    if typeof(res) == "Error" then
        return Result.new(nil, res)
    end

    return Result.new(res, nil)
end
function BinOp:SetPosition(pos)
    self.position = pos
    return self
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
        return InvalidOperationError.new("Division by zero", self.position)
    end
    return a / b
end
function BinOp:Pow(a, b)
    return math.pow(a, b)
end

function BinOp:SetError(err)
    self.error = err
end

return BinOp