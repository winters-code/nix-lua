
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
    local visitMethod = 'Visit_'..typeof(firstNode)
    return self['Visit_'..typeof(firstNode)](self, firstNode)
end

function Interpreter:Visit_BinOp(n)
    print('Bin op visit')
    return n.left:add(n.right):Get()
end
function Interpreter:Visit_Number(n)
    print('Number node visit')
    return n:Get()
end
function Interpreter:Visit_nil(n)
    error('No visit method for node type `{typeof(node)}`')
end

function Interpreter.__type()
    return "Interpreter"
end

return Interpreter