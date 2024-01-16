
--// Create the parser result class
local ParserRes = {}
ParserRes.__index = ParserRes

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
    if op.error then
        self.error = op.error
    
    -- If the check was safe, set the current node to that
    else
        self.node = op
    end

    -- Return the node so everyrthing works as normal
    return op
end

--// Get the node from the parser
function ParserRes:Get()
    if self.error then
        return nil, self.error
    end
    return self.node, nil
end

--// Return the class
return ParserRes
