
--// Create the token class
local Token = {
    tokenType = 0,
    data = nil
}
Token.__index = Token

--// Create a new instance of the class
function Token.new(tokenType, data, position)

    -- Create the local slef
    local self = setmetatable({}, Token)

    -- Set all of the data of the instance
    self.tokenType = tokenType
    self.data = data
    self.position = position

    -- Return the instance
    return self
end

--// Convert the token into a string nicely
function Token.__tostring(tbl)
    return string.format("Token(tokenType=%d, data=%s, position=(%s))", tbl.tokenType, tbl.data, tbl.position)
end

--// Get the special type of the token
function Token.__type()
    return 'Token'
end

--// Return the token class
return Token
