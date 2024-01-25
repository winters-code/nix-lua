
--// Create the parser result class
local ParserRes = {}
ParserRes.__index = ParserRes
ParserRes.__type = function()return"ParserRes"end

--// Create a new parser result
function ParserRes.new()

    -- Create the local self
    local self = setmetatable({}, ParserRes)

    -- Set default values
    self.node = nil
    self.error = nil

    -- Return the class instance
    return self
end

--// Register an operation
function ParserRes:Register(op)

    -- If the check had an error, log that
    if typeof(op) == "ParserRes" then
        if op.error then self.error = op.error end
        return self
    end

    -- Return the node so everyrthing works as normal
    return op
end

--// Set the node from the parser
function ParserRes:Success(node)
    self.node = node
    return self
end

--// Set an error for the result
function ParserRes:Failure(error)
    self.error = error
    return self
end

--// Return the class
return ParserRes
