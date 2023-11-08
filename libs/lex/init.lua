
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
    self.index = 1
    self.currentChar = ""

    return self
end

function Lexer:Advance()
    self.position:Advance()
    self.index = self.index + 1
end

function Lexer:CreateNumber()
    local stringRep = self.currentChar
    local dots = 0
    while tonumber(self.currentChar) ~= nil or self.currentChar == "." do
        self:Advance()
        self.currentChar = string.sub(self.text, self.index, self.index)
        if self.currentChar == "." then
            dots = dots + 1
        end
        stringRep = stringRep .. self.currentChar
    end
    local tok = Token.new(TokenType.TT_NUMBER, tonumber(stringRep))
    return tok
end

function Lexer:CreateOperator()
    return Token.new(TokenType.TT_OPERATOR, self.currentChar)
end

function Lexer:Tokenize()
    local Tokens = {}

    while self.currentChar ~= nil and self.currentChar ~= "" or self.index <= 1 do
        self.currentChar = string.sub(self.text, self.index, self.index)

        if string.find(WHITESPACE_CHARS, self.currentChar) then
        elseif string.find(DIGITS, self.currentChar) then
            table.insert(Tokens, self:CreateNumber())
        elseif table.find(OPERATORS, self.currentChar) then
            table.insert(Tokens, self:CreateOperator())
        else
            return {}, IllegalCharError.new(self.currentChar, self.position)
        end

        self:Advance()
    end

    return Tokens, nil
end

return Lexer