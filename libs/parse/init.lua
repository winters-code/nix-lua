
--// Create the base Parser class
local Parser = {
    tokens = {}
}
Parser.__index = Parser

--// Get the modules for the parser
local InvalidSyntaxError = require('libs.dc.error.InvalidSyntaxError')
local BinOp = require('libs.parse.node.BinOp')
local UnOp = require('libs.parse.node.UnOp')
require('libs.consts')

--// Create a new parser instance
function Parser.new(tokens)
    local self = setmetatable({}, Parser)

    self.tokens = tokens
    self.currentTokenIdx = 0
    self.currentToken = nil

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
function Parser:CreateBinOpToken()
    local left = self.currentToken
    self:Advance()
    local operator = self.currentToken
    self:Advance()
    local right = self.currentToken

    if left == nil or operator == nil or right == nil then
        return
    end
    return BinOp.new(left, operator, right)
end

--// Generate a binary operator
function Parser:GenerateBinOp()
    self:Advance()
    local thisfunc = nil

    if table.find({"+","-"}, self.currentToken.data) then
        thisfunc = self.AS
    end

    self:Retreat()
    thisfunc(self)
end

--// Order of operations
function Parser:AS()
    return self:CreateBinOpToken()
end
function Parser:DM()
end
function Parser:P()
end
function Parser:E()
end

--// Parse the tokens
function Parser:Parse()

    self:Advance()
    local nodesUnsorted = {}

    --// Collapse the tokens
    while self.currentToken ~= nil do
        
        if self.currentToken.tokenType == TokenType.TT_NUMBER and self.tokens[self.currentTokenIdx + 1].tokenType == TokenType.TT_OPERATOR then
            return self:GenerateBinOp(), nil
        else
            return nil, InvalidSyntaxError.new(self.currentToken)
        end
        self:Advance()

    end

    --// Collapse the nodes
    

    --// Return the AST
    return nil, nil
end

--// Return the module
return Parser
