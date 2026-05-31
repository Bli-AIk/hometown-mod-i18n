---@class FileButton : Object
---@overload fun(...) : FileButton
local FileButton, super = Class(Object)

function FileButton:init(list, id, data, x, y, width, height)
    super.init(self, x, y, width, height)

    self.list = list
    self.data = data
    self.id = id or 1

    self:setData(data)

    self.selected = false

    self.font = Assets.getFont("main")
    self.subfont = Assets.getFont("main", 16)

    self.prompt = nil
    self.choices = nil
    self.selected_choice = 1
end

function FileButton:setData(data)
    self.data = data

    self.name = data and data.name or "[EMPTY]"
    self.area = data and data.room_name or "------------"

    if data and data.playtime then
        local hours = math.floor(data.playtime / 3600)
        local minutes = math.floor(data.playtime / 60 % 60)
        local seconds = math.floor(data.playtime % 60)
        self.time = string.format("%d:%02d:%02d", hours, minutes, seconds)
    else
        self.time = "--:--"
    end
end

function FileButton:setChoices(choices, prompt)
    self.prompt = prompt
    self.choices = choices
    self.selected_choice = 1
end

function FileButton:getDrawColor()
    local r, g, b, a = super.getDrawColor(self)
    if not self.selected then
        return 0.35, 0.65, 0.85, a
    else
        return 0.70, 0.90, 1.00, a
    end
end

function FileButton:getHeartPos()
    if not self.choices then
        return 20, self.height / 2 - 9
    else
        if self.selected_choice == 1 then
            return 40, 52
        else
            return 220, 52
        end
    end
end

function FileButton:draw()
    Draw.setColor(0.02, 0.08, 0.15, 0.55)
    love.graphics.rectangle("fill", 0, 0, self.width, self.height)

    Draw.setColor(self:getDrawColor())
    Draw.drawMenuRectangle(0, 0, self.width, self.height)

    Draw.pushScissor()
    Draw.scissor(0, 0, self.width, self.height)

    if not self.prompt then
        Draw.setColor(0, 0, 0)
        love.graphics.print(self.name, 50 + 2, 10 + 2)
        Draw.setColor(self:getDrawColor())
        love.graphics.print(self.name, 50, 10)

        local time_x = self.width - 64 - self.font:getWidth(self.time) + 2
        Draw.setColor(0, 0, 0)
        love.graphics.print(self.time, time_x + 2, 10 + 2)
        Draw.setColor(self:getDrawColor())
        love.graphics.print(self.time, time_x, 10)
    else
        Draw.setColor(0, 0, 0)
        love.graphics.print(self.prompt, 50 + 2, 10 + 2)
        Draw.setColor(self:getDrawColor())
        love.graphics.print(self.prompt, 50, 10)
    end

    if not self.choices then
        Draw.setColor(0, 0, 0)
        love.graphics.print(self.area, 50 + 2, 44 + 2)
        Draw.setColor(self:getDrawColor())
        love.graphics.print(self.area, 50, 44)
    else
        Draw.setColor(0, 0, 0)
        love.graphics.print(self.choices[1], 70 + 2, 44 + 2)
        if self.selected_choice == 1 then
            Draw.setColor(0.70, 0.90, 1.00)
        else
            Draw.setColor(0.35, 0.65, 0.85)
        end
        love.graphics.print(self.choices[1], 70, 44)

        Draw.setColor(0, 0, 0)
        love.graphics.print(self.choices[2], 250 + 2, 44 + 2)
        if self.selected_choice == 2 then
            Draw.setColor(0.70, 0.90, 1.00)
        else
            Draw.setColor(0.35, 0.65, 0.85)
        end
        love.graphics.print(self.choices[2], 250, 44)
    end

    Draw.popScissor()
end

return FileButton
