
local Interpreter = {}
Interpreter.__index = Interpreter

function Interpreter.new(ast)
    local self = setmetatable({}, Interpreter)

    self.ast = ast

    return self
end

function Interpreter:Interpret()

    print(self.ast:Operate())

end

function Interpreter.__type()
    return "Interpreter"
end

return Interpreter