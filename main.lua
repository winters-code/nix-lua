
local shell = arg[1] == nil

local L = require("libs.lex")
local P = require("libs.parse")
local I = require("libs.inter")

local s_G = require("libs.scope").new()

local function run(code)
    if code == "q" then return -1 end

    local Lexer = L.new(code)
    local tokens, err = Lexer:Tokenize()

    if err then
        print(err:GenerateStackTrace())
    else
        local Parser = P.new(tokens)
        local AST, err = Parser:Parse()

        if err then
            print(err:GenerateStackTrace())
        else

            local Interpreter = I.new(AST, s_G)
            Interpreter:Interpret()
        end
    end
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