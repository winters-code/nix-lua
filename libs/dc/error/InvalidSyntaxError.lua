
local InvalidSyntaxError = require("libs.dc.error")
InvalidSyntaxError.__index = InvalidSyntaxError

function InvalidSyntaxError.new(data)
    local self = setmetatable({}, InvalidSyntaxError)

    self.message = "Invalid syntax"
    self.data = data
    self.position = data.position

    return self
end

return InvalidSyntaxError