
local ParserRes = {}
ParserRes.__index = ParserRes

function ParserRes.new()
    local self = setmetatable({}, ParserRes)
    self.node = nil
    self.error = nil
    return self
end


function ParserRes:Register(op)
    if op.error then
        self.error = op.error
    else
        self.node = op
    end
    return op
end

function ParserRes:Get()
    if self.error then
        return nil, self.error
    end
    return self.node, nil
end

return ParserRes