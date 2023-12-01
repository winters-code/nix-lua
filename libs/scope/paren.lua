
--// Create the class & index function
local ParenScope = {}
ParenScope.__index = ParenScope

--// Create a new parenthesis scope
function ParenScope.new()

    --// Create the metatable
    local self = setmetatable({}, ParenScope)

    --// Get the amount of parentheses
    self.parentheses = 0

    --// Return the scope object
    return self
end

--// Add a parenthesis to the scope
function ParenScope:AddParen()
    self.parentheses = self.parentheses + 1
    return 0
end

--// Remove a parenthesis from the scope
function ParenScope:SubParen()
    self.parentheses = self.parentheses - 1
    if self.parentheses < 0 then return -1 end
    return 0
end

--// Check the scope of the parentheses to make sure it's good
function ParenScope:Check()
    return self.parentheses / math.abs(self.parentheses)
end

--// Return the scope
return ParenScope
