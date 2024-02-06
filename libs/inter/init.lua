
local Interpreter = {}
Interpreter.__index = Interpreter

require('libs.rebind')

function Interpreter.new(ast, globalScope)
    local self = setmetatable({}, Interpreter)

    self.ast = ast
    self.globalScope = globalScope

    return self
end

function Interpreter:Interpret()

    local firstNode = self.ast.node
    self['Visit_'..typeof(firstNode)](self)

end

function Interpreter:Visit_BinOp()
    print('Binary operation')
end
function Interpreter:Visit_Number()
    print('Number')
end
function Interpreter:Visit_nil()
    error('No visit method for node type `{typeof(node)}`')
end

function Interpreter.__type()
    return "Interpreter"
end

return Interpreter