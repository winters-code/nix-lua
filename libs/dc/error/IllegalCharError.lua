
--// Create the subclass
local IllegalCharError = require("libs.dc.error")
IllegalCharError.__index = IllegalCharError

--// Constructor
function IllegalCharError.new(data, position)

    --// Create the instance
    local self = setmetatable({}, IllegalCharError)

    --// Set the data
    self.message = "Illegal character"
    self.data = data
    self.position = position

    --// Return the instance
    return self
end

--// Return the class
return IllegalCharError
