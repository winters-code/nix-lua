
local Node = {
}
Node.__index = Node

function Node.new()
    local self = setmetatable({}, Node)
    return self
end

function Node.__tostring(t)
    return string.format("(Undefined Node())")
end

function Node:SetError(err)
    self.error = err
end

function Node.__type()
    return 'Node'
end

function Node:Operate()
end

return Node
