
local Parser = {
    tokens = {}
}
Parser.__index = Parser

local BinOp = require('libs.parse.op.BinOp')
require('libs.consts')

function Parser.new(tokens)
    local self = setmetatable({}, Parser)

    self.tokens = tokens
    self.currentTokenIdx = 0
    self.currentToken = nil

    return self
end

function Parser:Advance()
    self.currentTokenIdx = self.currentTokenIdx + 1
    self.currentToken = self.tokens[self.currentTokenIdx] or nil
end

function Parser:GenerateBinOp()
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

function Parser:Parse()

    self:Advance()
    while self.currentToken ~= nil do
        
        if self.currentToken.tokenType == TokenType.TT_NUMBER then
            print(self:GenerateBinOp())
        end
        self:Advance()

    end
end

return Parser