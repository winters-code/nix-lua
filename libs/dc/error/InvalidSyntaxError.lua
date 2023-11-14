
local Error = require("libs.dc.error")
Error.__index = Error

function Error.new(message, pos)
    local self = setmetatable({}, Error)

    self.message = "Invalid syntax"
    self.data = message
    self.position = pos

    return self
end

return Error