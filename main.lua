
--// Checking if you are running a file or in the shell
local shell = arg[1] == nil

--// Require all libraries
local L = require("libs.lex")
local P = require("libs.parse")
local I = require("libs.inter")
require('libs.rebind')

--// Create the global scope
local s_G = require("libs.scope").new()

--// Run a section of code
local function run(code)

    --// If the code is to quit, return the exit code
    if code == "q" then return -1 end

    --// Get all the tokens from the code
    local Lexer = L.new(code)
    local tokens, err = Lexer:Tokenize()

    --// If there is an error, print it and break
    if err then
        print(err:GenerateStackTrace())
        return -1
    end

    --// Parse the tokens into the AST
    local Parser = P.new(tokens)
    local AST, err = Parser:Parse()

    --// If there is an error, print it and break
    if err then
        print(err:GenerateStackTrace())
        return -1
    end

    --// Interpret the AST with the global scope
    local Interpreter = I.new(AST, s_G)
    local res = Interpreter:Interpret()

    --// Print out the result
    print(res)
end

--// If it's running in a shell
if shell then

    --// Get input forever
    while true do

        --// Get the command input
        io.write("$ ")
        local line = io.read()  

        --// If the line through an error, break out
        if run(line) == -1 then break end
    end

--// If the user ran a file
else
    
    --// Get the code from the file
    local file = io.open(arg[1], "r")
    if not file then error("Couldn't open file " .. arg[1]) end
    local data = file:read("*a")

    --// Run the file
    run(data)
end