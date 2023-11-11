
local InterpreterResult = {}
InterpreterResult.__index = InterpreterResult

function InterpreterResult.new(value, error)
    local self = setmetatable({}, InterpreterResult)

    self.value = value
    self.error = error

    return self
end

function InterpreterResult.__tostring(t)
    if t.error then
        return t.error:GenerateStackTrace()
    end
    return t.value
end

function InterpreterResult.__type()
    return "InterpreterResult"
end

return InterpreterResult