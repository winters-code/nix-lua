
local Error = require("libs.dc.error")
Error.__index = Error

function Error.new(data, position)
    local self = setmetatable({}, Error)

    self.message = "Illegal character"
    self.data = data
    self.position = position

    return self
end

return Error