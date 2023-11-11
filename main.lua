
local shell = arg[1] == nil

if shell then
    while true do
        io.write("$ ")
        local line = io.read()

        if line == "q" then break end

        local Lexer = require("libs.lex").new(line)
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

        local Interpreter = require("libs.inter").new(AST)
        Interpreter:Interpret()
    end
else
    print("Ran file " .. arg[1])
end