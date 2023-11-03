
local AbstractSyntaxTree = {}
AbstractSyntaxTree.__index = AbstractSyntaxTree

function AbstractSyntaxTree.new()
    local self = setmetatable({}, AbstractSyntaxTree)

    self.layer = {}

    return self
end

function AbstractSyntaxTree:Add(Obj, Layer)
    Layer = Layer or self.layer

    local newLayer = {Obj}
    table.insert(Layer, newLayer)
    return newLayer
end

return AbstractSyntaxTree