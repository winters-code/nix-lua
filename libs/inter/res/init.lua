
local InterpreterResult = {}
InterpreterResult.__index = InterpreterResult

function InterpreterResult.new(value, err)
    local self = setmetatable({}, InterpreterResult)

    self.value = value
    self.error = err

    return self
end

function InterpreterResult.__tostring(t)
    if t.error then
        return t.error:GenerateStackTrace()
    end
    return tostring(t.value)
end

function InterpreterResult.__type()
    return "InterpreterResult"
end

return InterpreterResult