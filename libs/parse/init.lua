
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

--// Create a BinOp token
function Parser:GenerateBinOp(func, operators)
    local left = self[func](self)

    while self.currentToken ~= nil and table.find(operators, self.currentToken.tokenType) do
        local operator = self.currentToken
        self:Advance()
        local right = self[func](self)
        left = BinOp.new(left, operator, right):SetPosition(operator.position)
    end

    return left
end

--// Order of operations
function Parser:Factor()
    local token = self.currentToken

    if token and token.tokenType == TokenType.TT_NUMBER then
        self:Advance()
        return Number.new(token):SetPosition(token.position)
    end

    return Number.new(token):SetError(InvalidSyntaxError.new("Missing value in expression", self.lastToken.position))
end
function Parser:Paren()
    if not self.currentToken then
        return Number.new(self.currentToken):SetError(InvalidSyntaxError.new("Missing value in expresion", self.lastToken.position))
    elseif self.currentToken.tokenType == TokenType.TT_LPAREN then
        self:Advance()
        local res = self:Expression()
        self.parenScope:AddParen()
        self:Advance()
        return res
    else
        return self:Factor()
    end
end
function Parser:Atom()
    return self:GenerateBinOp("Paren", {TokenType.TT_POW})
end
function Parser:Term()
    return self:GenerateBinOp("Atom", {TokenType.TT_MUL, TokenType.TT_DIV})
end
function Parser:Expression()
    return self:GenerateBinOp("Term", {TokenType.TT_ADD, TokenType.TT_SUB})
end

--// Parse the tokens
function Parser:Parse()

    local res = self:Expression()

    if not self.parenScope:Check() then
        if self.parenScope.parentheses > 0 then
            res:SetError(InvalidSyntaxError.new("Missing ending parenthesis", self.lastToken.position))
        else
            res:SetError(InvalidSyntaxError.new("Missing starting parenthesis", self.lastToken.position))
        end
    end

    if res.error then
        return nil, res.error
    end
    return res, nil

end

--// Return the module
return Parser
