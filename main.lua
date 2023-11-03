
local Lexer = require("libs.lex").new(io.read())
require("libs.rebind")
local tokens, err = Lexer:Tokenize()

if err then
    print(err:GenerateStackTrace())
else
    print(table.stringify(tokens))
end

