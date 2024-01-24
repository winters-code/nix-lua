
--// Create the subclass
local InvalidOperationError = require("libs.dc.error")
InvalidOperationError.__index = InvalidOperationError

--// Constructor
function InvalidOperationError.new(data, position)

    --// Create the instance
    local self = setmetatable({}, InvalidOperationError)

    --// Load the data
    self.message = "Invalid operation"
    self.data = data
    self.position = position

    --// Return the instance
    return self
end

--// Return the class
return InvalidOperationError