
io.write("$ ")
local Lexer = require("libs.lex").new(io.read())
require("libs.rebind")
local tokens, err = Lexer:Tokenize()

if err then
    print(err:GenerateStackTrace())
else
    local Parser = require("libs.parse").new(tokens)
    Parser:Parse()
end

