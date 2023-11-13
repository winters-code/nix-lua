
local Error = require("libs.dc.error")
Error.__index = Error

function Error.new(message, data)
    local self = setmetatable({}, Error)

    self.message = "Invalid syntax"
    self.data = message
    self.position = data.position

    return self
end

return Error