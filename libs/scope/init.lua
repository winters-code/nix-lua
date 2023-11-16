
local Scope = {}
Scope.__index = Scope

function Scope.new(parent)
    local self = setmetatable({}, Scope)
    self.parent = parent
    self.identifiers = {}
    return self
end

function Scope:Increase()
    return Scope.new(self)
end

function Scope:GetParent()
    return self.parent
end

function Scope:GetIdentifier(ID)
    return self.identifiers[ID] or (self.parent and self.parent:GetIdentifier(ID))
end

return Scope