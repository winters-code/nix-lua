
local Lexer = require("libs.lex.lexer").new(io.read())
require("libs.rebind")
local tokens = Lexer:Tokenize()
print(table.stringify(tokens))