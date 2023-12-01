
--// Create the subclass
local Error = require("libs.dc.error")
Error.__index = Error

--// Constructor
function Error.new(message, pos)

    --// Create the class instance
    local self = setmetatable({}, Error)

    --// Load the error data
    self.message = "Invalid syntax"
    self.data = message
    self.position = pos

    --// Return the error
    return self
end

--// Return the class
return Error
