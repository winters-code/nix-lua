
local Token = {
    tokenType = 0,
    data = nil
}
Token.__index = Token

function Token.new(tokenType, data, position)
    local self = setmetatable({}, Token)

    self.tokenType = tokenType
    self.data = data
    self.position = position

    return self
end

function Token.__tostring(tbl)
    return string.format("Token(type=%d, data=\"%s\", pos=(%s))", tbl.tokenType, tbl.data, tbl.position)
end

function Token.__type()
    return 'Token'
end

return Token
