
local Error = {
    message = "",
    data = "",
    position = nil
}
Error.__init = Error

function Error.new(message, data, position)
    local self = setmetatable({}, Error)
    
    self.message = message
    self.data = data
    self.position = position

    return self
end

function Error:Prepare()
    return tostring(self)
end

function Error.__tostring(t)
    return string.format("Error(message=%s, data=%s, position=%s)", t.message, t.data, tostring(t.position))
end

return Error