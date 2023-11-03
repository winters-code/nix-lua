
local InvalidSyntaxError = require("libs.gen.error")
InvalidSyntaxError.__index = InvalidSyntaxError

function InvalidSyntaxError.new(data, position)
    local self = setmetatable({}, InvalidSyntaxError)

    self.message = "Invalid syntax"
    self.data = data
    self.position = position

    return self
end

return InvalidSyntaxError