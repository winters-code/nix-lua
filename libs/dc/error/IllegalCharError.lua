
--// Create the subclass
local Error = require("libs.dc.error")
Error.__index = Error

--// Constructor
function Error.new(data, position)

    --// Create the instance
    local self = setmetatable({}, Error)

    --// Set the data
    self.message = "Illegal character"
    self.data = data
    self.position = position

    --// Return the instance
    return self
end

--// Return the class
return Error
