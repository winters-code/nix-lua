
local Lexer = {}
Lexer.__index = Lexer

local Position = require("libs.gen.position")
local Token = require("libs.lex.token")
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
end

function Lexer:CreateNumber()
    local stringRep = self.currentChar
    local dots = 0
    while tonumber(self.currentChar) ~= nil or self.currentChar == "." do
        self.index = self.index + 1
        self.currentChar = string.sub(self.text, self.index, self.index)
        if self.currentChar == "." then
            dots = dots + 1
        end
        stringRep = stringRep .. self.currentChar
    end
    local tok = Token.new(TokenType.TT_NUMBER, tonumber(stringRep))
    return tok
end

function Lexer:Tokenize()
    local Tokens = {}

    for i = 1, #self.text do
        if self.index <= i then
            self.index = i
            self.currentChar = string.sub(self.text, i, i)

            if string.find(WHITESPACE_CHARS, self.currentChar) then
                print("whitespace")
            elseif string.find(DIGITS, self.currentChar) then
                table.insert(Tokens, self:CreateNumber())
            end
        end
    end

    return Tokens
end

return Lexer