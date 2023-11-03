
local Token = {
    tokenType = 0,
    data = nil,
    instanceof = "token"
}
Token.__index = Token

function Token.new(tokenType, data)
    local self = setmetatable({}, Token)

    self.tokenType = tokenType
    self.data = data

    return self
end

function Token.__tostring(tbl)
    return string.format("Token(type=%d, data=\"%s\")", tbl.tokenType, tbl.data)
end

return Token
