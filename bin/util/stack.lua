local class = require "util.class"

local Stack = class("Stack")


function Stack:new()
    self.stack_table = {}
    return self
end

function Stack:push(element)
    local size = self:size()
    self.stack_table[size + 1] = element
    return 1
end

function Stack:pop()
    local size = self:size()
    if self:isEmpty() then
        return 0
    end
    return table.remove(self.stack_table,size)
end

function Stack:top()
    local size = self:size()
    if self:isEmpty() then
        return nil, "empty stack"
    end
    return self.stack_table[size]
end

function Stack:isEmpty()
    local size = self:size()
    if size == 0 then
        return true
    end
    return false
end

function Stack:size()
    return table.getn(self.stack_table) or 0
end

function Stack:clear()
    self.stack_table = nil
    self.stack_table = {}
end

function Stack:printElement()
    local size = self:size()

    if self:isEmpty() then
        print("no element")
        return
    end

    local str = "{"..self.stack_table[size]
    size = size - 1
    while size > 0 do
        str = str..", "..self.stack_table[size]
        size = size - 1
    end
    str = str.."}"
    print(str)
end


return Stack
