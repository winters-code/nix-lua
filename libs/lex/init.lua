
--// Create the lexer class
local Lexer = {}
Lexer.__index = Lexer

--// Import required classes
local Position = require("libs.dc.position")
local Token = require("libs.lex.token")
local IllegalCharError = require("libs.dc.error.IllegalCharError")

--// Rebind certain things
require("libs.rebind")
require("libs.consts")

--// Create a new lexer
function Lexer.new(text)

    -- Create the class instance
    local self = setmetatable({}, Lexer)

    -- Load all of the data for the class
    self.position = Position.new()
    self.text = text
    self.textLines = string.split(self.text, "\n")
    self.index = 0
    self.currentChar = ""

    -- Go to the first character
    self:Advance()

    -- Return the class instance
    return self
end

--// Advance to the next character
function Lexer:Advance()
    self.position:Advance()
    self.index = self.index + 1
    self.currentChar = string.sub(self.text, self.index, self.index)
end

--// Create a number token
function Lexer:CreateNumber()

    -- Information about the number
    local stringRep = self.currentChar
    local dots = 0
    local startPos = self.position:Clone()

    -- Go to the next number
    self:Advance()

    -- While the character is in "0123456789.", 
    while tonumber(self.currentChar) ~= nil or self.currentChar == "." do 

        -- Log all the dots
        if self.currentChar == "." then
            dots = dots + 1
        end

        -- Add a number to the string version of the number
        stringRep = stringRep .. self.currentChar

        -- Go to the next character
        self:Advance()
    end

    -- Create the new token and return it
    local tok = Token.new(TokenType.TT_NUMBER, tonumber(stringRep), startPos)
    return tok
end

--// Create an operator token
function Lexer:CreateOperator()

    -- Get the token type
    local tokenType = TT_OPERATOR_HASH[self.currentChar]

    -- Go to the next character
    self:Advance()

    -- Create and return a token of the saved type
    return Token.new(tokenType, nil, self.position:Clone())
end

--// Create any keyword or identifier
function Lexer:CreateKeywordOrID()

    -- Data of the keyword or identifier
    local data = self.currentChar

    -- Move to the next character
    self:Advance()

    -- While the character is valid, add it to the data
    while string.find(ID_VALID_DURING, self.currentChar) and self.currentChar ~= "" do
        data = data .. self.currentChar
        self:Advance()
    end

    -- Get the token type of the data
    local tt = TokenType.TT_IDENTIFIER
    if table.find(KEYWORDS, data) then tt = TokenType.TT_KEYWORD end

    -- Return the token of the keyword or identifier
    return Token.new(tt, data, self.position:Clone())
end

--// Turn the text into tokens
function Lexer:Tokenize()

    -- Create a list of tokens
    local Tokens = {}

    -- For every tkoen
    while self.currentChar ~= nil and self.currentChar ~= "" or self.index <= 1 do

        -- If it's whitespace, skip  to the next character
        if string.find(WHITESPACE_CHARS, self.currentChar, 1, true) then
            self:Advance()
        
        -- If the current character is a number, create a number
        elseif tonumber(self.currentChar) ~= nil then
            table.insert(Tokens, self:CreateNumber())

        -- If the current character is an operator, create an operator
        elseif table.find(OPERATORS, self.currentChar) then
            table.insert(Tokens, self:CreateOperator())
        
        -- If the current character is a valid ID character, create a keyword or ID
        elseif string.find(ID_VALID_START, self.currentChar) then
            table.insert(Tokens, self:CreateKeywordOrID())
        
        -- If the character is not recognized, it's an illegal character.
        else
            return {}, IllegalCharError.new(self.currentChar, self.position)
        end
    end

    -- Return all of the tokens
    return Tokens, nil
end

--// Return the class
return Lexer