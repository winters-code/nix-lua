
local shell = arg[1] == nil

local function run(code)
    if code == "q" then return -1 end

    local Lexer = require("libs.lex").new(code)
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

if shell then
    while true do
        io.write("$ ")
        local line = io.read()  

        if run(line) == -1 then break end
    end
else
    print("Ran file " .. arg[1])
    
    local file = io.open(arg[1], "r")
    if not file then error("Couldn't open file " .. arg[1]) end
    local data = file:read("*a")
    run(data)
end