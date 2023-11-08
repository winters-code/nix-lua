
local Parser = {
    tokens = {}
}
Parser.__index = Parser

local AbstractSyntaxTree = require("libs.parse.AbstractSyntaxTree")

function Parser.new(tokens)
    local self = setmetatable({}, Parser)

    self.tokens = tokens

    return self
end

function Parser:Parse()

    local ast = AbstractSyntaxTree.new()
    local currentLayer = ast:GetMainLayer()

    for _, token in ipairs(self.tokens) do
        print(tostring(token))
    end

end

return Parser