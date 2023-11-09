
local Lexer = {}
Lexer.__index = Lexer

local Position = require("libs.dc.position")
local Token = require("libs.lex.token")
local IllegalCharError = require("libs.dc.error.IllegalCharError")
require("libs.rebind")
require("libs.consts")

function Lexer.new(text)
    local self = setmetatable({}, Lexer)

    self.position = Position.new()
    self.text = text
    self.textLines = string.split(self.text, "\n")
    self.index = 0
    self.currentChar = ""
    self:Advance()

    return self
end

function Lexer:Advance()
    self.position:Advance()
    self.index = self.index + 1
    self.currentChar = string.sub(self.text, self.index, self.index)
end
function Lexer:Retreat()
    self.position:Retreat()
    self.index = self.index - 1
    self.currentChar = string.sub(self.text, self.index, self.index)
end

function Lexer:CreateNumber()
    local stringRep = self.currentChar
    local dots = 0
    local startPos = self.position:Clone()
    self:Advance()
    while tonumber(self.currentChar) ~= nil or self.currentChar == "." do 
        self.currentChar = string.sub(self.text, self.index, self.index)
        if self.currentChar == "." then
            dots = dots + 1
        end
        stringRep = stringRep .. self.currentChar
        self:Advance()
    end
    local tok = Token.new(TokenType.TT_NUMBER, tonumber(stringRep), startPos)
    return tok
end

function Lexer:CreateOperator()
    local tokenType = TT_OPERATOR_HASH[self.currentChar]
    self:Advance()
    return Token.new(tokenType, nil, self.position:Clone())
end

function Lexer:Tokenize()
    local Tokens = {}

    while self.currentChar ~= nil and self.currentChar ~= "" or self.index <= 1 do

        if string.find(WHITESPACE_CHARS, self.currentChar, 1, true) then
            self:Advance()
        elseif tonumber(self.currentChar) ~= nil then
            table.insert(Tokens, self:CreateNumber())
        elseif table.find(OPERATORS, self.currentChar) then
            table.insert(Tokens, self:CreateOperator())
        else
            return {}, IllegalCharError.new(self.currentChar, self.position)
        end
    end

    return Tokens, nil
end

return Lexer