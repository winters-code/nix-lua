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
local ParserRes = require('libs.parse.res')

--// Get the required global modules to change stuff
require('libs.consts')
require('libs.rebind')

--// Create a new parser instance
function Parser.new(tokens)
    -- Create the parser instance
    local self = setmetatable({}, Parser)

    -- Set all of the data about the parser
    self.tokens = tokens
    self.currentTokenIdx = 0
    self.currentToken = nil
    self.lastToken = nil

    -- Set up positioning
    self:Advance()

    -- Return the parser instance
    return self
end

--// Movement between the tokens in the parser
function Parser:Advance()
    -- Set what the last token was
    self.lastToken = self.currentToken or self.lastToken

    -- Increase the position of the current token
    self.currentTokenIdx = self.currentTokenIdx + 1
    self.currentToken = self.tokens[self.currentTokenIdx] or nil
end

--// Create a BinOp node
function Parser:GenerateBinOp(func, operators)
    -- Get the left side of the binary operation
    local res = ParserRes.new()
    local left = res:Register(self[func](self))
    if res.error then return res end

    -- Thile the token is one of the operators
    while self.currentToken ~= nil and table.find(operators, self.currentToken.type) do
        -- Get the operator of the binary operation
        local operator = self.currentToken
        res:Register(self:Advance())

        -- Get the right side of the binary operation
        local right = res:Register(self[func](self))

        -- Create the binary operation node
        left = BinOp.new(left, operator, right):SetPosition(left.position)
    end

    -- Return the created node
    return res:Success(left)
end

--//// NAMES ARE BASED ON PEMDAS, THE ORDER OF OPERATIONS
--// Factor just returns a number
function Parser:Factor()
    -- Get the current token
    local res = ParserRes.new()
    local token = self.currentToken

    -- If the current token is a number
    if token and token.tokenType == TokenType.TT_NUMBER then
        -- Get and return a number with the value
        local num = Number.new(token):SetPosition(token.position)
        res:Register(self:Advance())
        return res:Success(num)
    elseif token and token.tokenType == TokenType.TT_LPAREN then
        res:Register(self:Advance())
        expr = self:AS()
        if expr.error then
            return expr
        end
        if self.token and self.token.tokenType == TokenType.TT_RPAREN then
            res:Register(self:Advance())
            return res.success(expr)
        else
            return res:Failure(InvalidSyntaxError.new("Expected ')'", self.lastToken.position))
        end
    end

    -- Return an error since it's supposed to have a value
    return res:Failure(InvalidSyntaxError.new("Missing value in expression", self.lastToken.position))
end

--// Exponentiation
function Parser:E()
    -- Return a binary operation for powers
    return self:GenerateBinOp("Factor", { TokenType.TT_POW })
end

--// Multiplication and division
function Parser:MD()
    -- Return a binary operation using multiplication and division
    return self:GenerateBinOp("E", { TokenType.TT_MUL, TokenType.TT_DIV, TokenType.TT_MOD })
end

--// Addition and subtraction
function Parser:AS()
    -- Return a binary operation using addition and subtraction
    return self:GenerateBinOp("MD", { TokenType.TT_ADD, TokenType.TT_SUB })
end

--// Parse the tokens
function Parser:Parse()
    -- Create the run node out from addition and subtraction
    local res = self:AS()

    -- If there is an error, return the error and no result
    if res.error then
        return nil, res.error
    end

    -- Return the result
    return res, nil
end

--// Return the module
return Parser
