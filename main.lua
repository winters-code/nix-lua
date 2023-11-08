
io.write("$ ")
local Lexer = require("libs.lex").new(io.read())
require("libs.rebind")
local tokens, err = Lexer:Tokenize()

if err then
    error(err:GenerateStackTrace())
end
local Parser = require("libs.parse").new(tokens)
local AST, err = Parser:Parse()

if err then
    error(err:GenerateStackTrace())
end

print(AST)
