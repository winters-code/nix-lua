
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
local ParenScope = require('libs.scope.paren')
require('libs.consts')
require('libs.rebind')

--// Create a new parser instance
function Parser.new(tokens)
    local self = setmetatable({}, Parser)

    self.tokens = tokens
    self.currentTokenIdx = 0
    self.currentToken = nil
    self.lastToken = nil
    self.parenScope = ParenScope.new()

    self:Advance()

    return self
end

--// Movement between the tokens in the parser
function Parser:Advance()
    self.lastToken = self.currentToken or self.lastToken
    self.currentTokenIdx = self.currentTokenIdx + 1
    self.currentToken = self.tokens[self.currentTokenIdx] or nil
end

--// Create a BinOp node
function Parser:GenerateBinOp(func, operators)
    local left = self[func](self)
    local op = nil

    while self.currentToken ~= nil and table.find(operators, self.currentToken.tokenType) do
        local operator = self.currentToken
        self:Advance()
        local right = self[func](self)
        self:Advance()
        op = BinOp.new(left, operator, right):SetPosition(left.position)
    end
    if (self.currentToken or self.lastToken).tokenType == TokenType.TT_RPAREN then
        self.parenScope:SubParen()
    end

    return op or left
end

--//// NAMES ARE BASED ON PEMDAS, THE ORDER OF OPERATIONS
--// Order of operations
function Parser:Factor() 
    local token = self.currentToken

    if token and token.tokenType == TokenType.TT_NUMBER then
        self:Advance()
        local num = Number.new(token):SetPosition(token.position)
        return num
    end

    return Number.new(self.lastToken):SetError(InvalidSyntaxError.new("Missing value in expression", self.lastToken.position))
end
function Parser:P()
    if not self.currentToken then
        return Number.new(self.lastToken):SetError(InvalidSyntaxError.new("Missing value in expresion", self.lastToken.position))
    elseif self.currentToken.tokenType == TokenType.TT_LPAREN then
        self:Advance()
        self.parenScope:AddParen()
        return self:AS()
    end
    self:Advance()
    return self:Factor()
end
function Parser:E()
    return self:GenerateBinOp("P", {TokenType.TT_POW})
end
function Parser:MD()
    return self:GenerateBinOp("E", {TokenType.TT_MUL, TokenType.TT_DIV})
end
function Parser:AS()
    return self:GenerateBinOp("MD", {TokenType.TT_ADD, TokenType.TT_SUB})
end

--// Parse the tokens
function Parser:Parse()

    local res = self:AS()

    if self.parenScope.parentheses > 0 then
        res:SetError(InvalidSyntaxError.new("Missing ending parenthesis", self.lastToken.position))
    elseif self.parenScope.parentheses < 0 then
        res:SetError(InvalidSyntaxError.new("Missing starting parenthesis", self.lastToken.position))
    end

    if res.error then
        return nil, res.error
    end
    return res, nil

end

--// Return the module
return Parser
