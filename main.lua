
local Lexer = require("libs.lex").new(io.read())
require("libs.rebind")
local tokens = Lexer:Tokenize()
print(table.stringify(tokens))
