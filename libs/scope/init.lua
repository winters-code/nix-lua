
--// Create the scope class
local Scope = {}
Scope.__index = Scope

--// Construct a new scope class
function Scope.new(parent)

    -- Create the metatable
    local self = setmetatable({}, Scope)

    -- Load the properties of the scope
    self.parent = parent
    self.identifiers = {}

    -- Return the scope
    return self
end

--// Increase the scope
function Scope:Increase()
    return Scope.new(self)
end

--// Get the parent of the scope to go back up
function Scope:GetParent()
    return self.parent
end

--// Get an identifier out of the scope
function Scope:GetIdentifier(ID)
    return self.identifiers[ID] or (self.parent and self.parent:GetIdentifier(ID))
end

--// Set an identifier in the scope
function Scope:SetIdentifier(ID, value)
    self.identifiers[ID] = value
end

--// Return the scope file
return Scope
