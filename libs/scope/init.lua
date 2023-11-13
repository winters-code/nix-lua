
local Scope = {}
Scope.__index = Scope

function Scope.new()
    local self = setmetatable({}, Scope)
    return self
end

function Scope:AddLayer(uid)
    local layer = Scope.new()
    self[uid] = layer
    return layer
end

return Scope