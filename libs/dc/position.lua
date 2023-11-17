
local Position = {}
Position.__index = Position

function Position.new(row, column)
    local self = setmetatable({}, Position)

    self.row = row or 0
    self.column = column or 0
    self.file = "<stdin>"

    return self
end

function Position.__tostring(tbl)
    return string.format("Position(file=\"%s\", row=%d, column=%d)", tbl.file, tbl.row, tbl.column)
end

function Position:SetFile(name)
    self.file = name
    return self
end

function Position:GetPositionString()
    return string.format("file %s, row %d, column %d", self.file, self.row, self.column - 1)
end
function Position:Advance(toNewRow)
    if toNewRow then
        self.row = self.row + 1
        self.column = 0
    else
        self.column = self.column + 1
    end
end

function Position:Clone()
    return Position.new(self.row, self.column)
end

return Position
