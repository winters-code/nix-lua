
--// Create the position class
local Position = {}
Position.__index = Position

--// Constructor
function Position.new(row, column, file)

    --// Create the instance
    local self = setmetatable({}, Position)

    --// Load the position data
    self.row = row or 0
    self.column = column or 0
    self.file = file or "<stdin>"

    --// Return the instance
    return self
end

--// Turn the position into a nice, readable strnig
function Position.__tostring(tbl)
    return string.format("Position(file=\"%s\", row=%d, column=%d)", tbl.file, tbl.row, tbl.column)
end

--// Set the file of the position after the fact
function Position:SetFile(name)
    self.file = name
    return self
end

--// Turn it into a position for the user to use
function Position:GetPositionString()
    return string.format("file %s, row %d, column %d", self.file, self.row, self.column - 1)
end

--// Advance the position
function Position:Advance(toNewRow)
    
    --// If it's going into a new row
    if toNewRow then
        self.row = self.row + 1
        self.column = 0
    
    --// If it's just moving columns
    else
        self.column = self.column + 1
    end
end

--// Deep clone the position
function Position:Clone()
    return Position.new(self.row, self.column)
end

--// Return the position class
return Position
