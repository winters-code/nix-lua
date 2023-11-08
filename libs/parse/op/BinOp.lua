
local BinOp = {
    left = nil,
    right = nil,
    operator = nil
}
BinOp.__index = BinOp

function BinOp.new(left, operator, right)
    local self = setmetatable({}, BinOp)

    self.left = left
    self.operator = operator
    self.right = right

    return self
end

function BinOp.__tostring(t)
    return string.format("(%s %s %s)", tostring(t.left), tostring(t.operator), tostring(t.right))
end

return BinOp