
local Error = require("libs.dc.error")
Error.__index = Error

function Error.new(data)
    local self = setmetatable({}, Error)

    self.message = "Invalid Operation"
    self.data = data

    return self
end

return Error