
local Error = {
    message = "",
    data = "",
    position = nil,
    instanceof = "error"
}
Error.__index = Error

function Error.new(message, data, position)
    local self = setmetatable({}, Error)
    
    self.message = message
    self.data = data
    self.position = position

    return self
end

function Error:GenerateStackTrace()
    return string.format("%s error at %s: %s", self.message, self.position:GetPositionString(), self.data)
end

function Error.__type()
    return "Error"
end

function Error.__tostring(t)
    return string.format("Error(message=%s, data=%s, position=%s)", t.message, t.data, tostring(t.position))
end

return Error