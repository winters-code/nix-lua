
local IllegalCharError = require("libs.dc.error")
IllegalCharError.__index = IllegalCharError

function IllegalCharError.new(data, position)
    local self = setmetatable({}, IllegalCharError)

    self.message = "Illegal character"
    self.data = data
    self.position = position

    return self
end

return IllegalCharError