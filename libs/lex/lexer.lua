
local Lexer = {}
Lexer.__index = Lexer

function Lexer.new(text)
    local self = setmetatable({}, Lexer)

    self.column = 0
    self.row = 0

    return self
end

return Lexer