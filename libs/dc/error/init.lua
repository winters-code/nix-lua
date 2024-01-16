
--// Create the class with all defaults
local Error = {
    message = "",
    data = "",
    position = nil,
    instanceof = "error"
}
Error.__index = Error

--// Construct a new class intance
function Error.new(message, data, position)

    -- Create the instance
    local self = setmetatable({}, Error)
    
    -- Load the data
    self.message = message
    self.data = data
    self.position = position

    -- Return the instance
    return self
end

--// Generate the stack trace for the error
function Error:GenerateStackTrace()
    return string.format("%s error at %s: %s", self.message, self.position:GetPositionString(), self.data)
end

--// Make sure the type is known as an error
function Error.__type()
    return "Error"
end

--// A readable, debugable string representation
function Error.__tostring(t)
    return string.format("Error(message=%s, data=%s, position=%s)", t.message, t.data, tostring(t.position))
end

--// Return the class
return Error
