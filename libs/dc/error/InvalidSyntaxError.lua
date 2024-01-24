
--// Create the subclass
local InvalidSyntaxError = require("libs.dc.error")
InvalidSyntaxError.__index = InvalidSyntaxError

--// Constructor
function InvalidSyntaxError.new(message, pos)

    --// Create the class instance
    local self = setmetatable({}, InvalidSyntaxError)

    --// Load the error data
    self.message = "Invalid syntax"
    self.data = message
    self.position = pos

    --// Return the error
    return self
end

--// Return the class
return InvalidSyntaxError
