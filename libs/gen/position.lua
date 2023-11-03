
local Position = {}
Position.__index = Position

function Position.new(row, column)
    local self = setmetatable({}, Position)

    self.row = row
    self.column = column

    return self
end

function Position.__tostring(tbl)
    return string.format("Position(row=%d, column=%d)", tbl.row, tbl.column)
end

return Position