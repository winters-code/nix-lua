
local ParenScope = {}
ParenScope.__index = ParenScope

function ParenScope.new()
    local self = setmetatable({}, ParenScope)

    self.parentheses = 0

    return self
end

function ParenScope:AddParen()
    self.parentheses = self.parentheses + 1
end
function ParenScope:SubParen()
    self.parentheses = self.parentheses - 1
end

function ParenScope:Check()
    return self.parentheses / math.abs(self.parentheses)
end

return ParenScope
