
local Node = {
}
Node.__index = Node
Node.__type = 'Node'

function Node.new()
    local self = setmetatable({}, Node)
    return self
end

function Node.__tostring(t)
    return string.format("(Undefined Node())")
end

function Node:SetError(err)
    self.error = err
    return self
end

function Node:Operate()
end

return Node
