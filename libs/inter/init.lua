
local Interpreter = {}
Interpreter.__index = Interpreter

function Interpreter.new(ast, globalScope)
    local self = setmetatable({}, Interpreter)

    self.ast = ast
    self.globalScope = globalScope

    return self
end

function Interpreter:Interpret()

    return self.ast:Operate(self.globalScope)

end

function Interpreter.__type()
    return "Interpreter"
end

return Interpreter