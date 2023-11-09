
--// Create the base Parser class
local Parser = {
    tokens = {}
}
Parser.__index = Parser

--// Get the modules for the parser
local InvalidSyntaxError = require('libs.dc.error.InvalidSyntaxError')
local BinOp = require('libs.parse.node.BinOp')
local UnOp = require('libs.parse.node.UnOp')
local Number = require('libs.parse.node.Number')
require('libs.consts')
require('libs.rebind')

--// Create a new parser instance
function Parser.new(tokens)
    local self = setmetatable({}, Parser)

    self.tokens = tokens
    self.currentTokenIdx = 0
    self.currentToken = nil

    self:Advance()

    return self
end

--// Movement between the tokens in the parser
function Parser:Advance()
    self.currentTokenIdx = self.currentTokenIdx + 1
    self.currentToken = self.tokens[self.currentTokenIdx] or nil
end
function Parser:Retreat()
    self.currentTokenIdx = self.currentTokenIdx - 1
    self.currentToken = self.tokens[self.currentTokenIdx] or nil
end

--// Create a BinOp token
function Parser:GenerateBinOp(func, operators)
    local left = self[func](self)

    while self.currentToken and table.find(operators, self.currentToken.tokenType) do
        local operator = self.currentToken
        self:Advance()
        local right = self[func](self)
        self:Advance()
        left = BinOp.new(left, operator, right)
    end

    return left
end

--// Order of operations
function Parser:Factor()
    local token = self.currentToken

    if token and token.tokenType == TokenType.TT_NUMBER then
        self:Advance()
        return Number.new(token)
    end
end
function Parser:Term()
    return self:GenerateBinOp("Factor", {TokenType.TT_MUL, TokenType.TT_DIV})
end
function Parser:Expression()
    return self:GenerateBinOp("Term", {TokenType.TT_ADD, TokenType.TT_SUB})
end

--// Parse the tokens
function Parser:Parse()

    print(table.stringify(self.tokens))

    local res = self:Expression()
    return res

end

--// Return the module
return Parser
