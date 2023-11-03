
local Parser = {
    tokens = {}
}
Parter.__index = Parser

local AbstractSyntaxTree = require("libs.parse.AbstractSyntaxTree")

function Parser.new(tokens)
    local self = setmetatable({}, Parser)

    self.tokens = tokens

    return self
end

function Parser:Parse()

    local ast = AbstractSyntaxTree.new()

end

return Parser