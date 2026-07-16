local HeartScreen, super = Class(Event)

function HeartScreen:init(data)
    super.init(self, data)
    self.width = 30
    self.height = 10
    self.scroll_timer = 0
    self.is_solved = false
end

function HeartScreen:update()
    super.update(self)
    if not self.is_solved then
        self.scroll_timer = self.scroll_timer + (DT * 40)
        if self.scroll_timer > 30 then
            self.scroll_timer = 0
        end
        local current = Game:getFlag("heart_puzzle_state", {1, 1, 1})
        local target = Game:getFlag("heart_puzzle_target", {2, 1, 3})
        if Utils.equal(current, target) then
            self.is_solved = true
            Assets.playSound("locker")
            for _, thing in ipairs(Game.stage:getObjects()) do 
            if thing.id == "heartbutton" then 
            thing.sprite:setSprite("world/events/glowtile/pressed")
            thing.can_be_pressed = false 
            end 
            end
            Game.world:showText("* (Seems a forcefield )")
        end
    end
end

function HeartScreen:draw()
    love.graphics.push()
    love.graphics.scale(2, 2)
    
    local target_offset_x = 40

    love.graphics.setColor(0.4, 0.4, 0.45, 1)
    love.graphics.rectangle("fill", target_offset_x - 2, -2, self.width + 4, self.height + 4)
    love.graphics.setColor(0.05, 0.05, 0.05, 1)
    love.graphics.rectangle("fill", target_offset_x - 1, -1, self.width + 2, self.height + 2)
    love.graphics.setColor(0.2, 0, 0, 1)
    love.graphics.rectangle("fill", target_offset_x, 0, self.width, self.height)
    love.graphics.setColor(1, 0.2, 0.2, 1)
    love.graphics.setLineWidth(1)
    local target = Game:getFlag("heart_puzzle_target", {2, 1, 3})
    self:drawLineSegment(target_offset_x, 0, target[1])
    self:drawLineSegment(target_offset_x, 10, target[2])
    self:drawLineSegment(target_offset_x, 20, target[3])

    if self.is_solved then
        love.graphics.setColor(0.8, 0.8, 0.85, 1)
    else
        love.graphics.setColor(0.4, 0.4, 0.45, 1)
    end
    love.graphics.rectangle("fill", -2, -2, self.width + 4, self.height + 4)
    love.graphics.setColor(0.05, 0.05, 0.05, 1)
    love.graphics.rectangle("fill", -1, -1, self.width + 2, self.height + 2)
    love.graphics.setColor(0.1, 0.1, 0.1, 1)
    love.graphics.rectangle("fill", 0, 0, self.width, self.height)
    
    local screen_x, screen_y = self:getScreenPos()
    love.graphics.setScissor(screen_x, screen_y, self.width * 2, self.height * 2)
    
    if self.is_solved then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setLineWidth(1)
    else
        love.graphics.setColor(0, 1, 0, 1)
        love.graphics.setLineWidth(1)
    end
    
    local states = Game:getFlag("heart_puzzle_state", {1, 1, 1})
    for loop_offset = -30, 30, 30 do
        local draw_x = loop_offset - self.scroll_timer
        self:drawLineSegment(draw_x, 0, states[1])
        self:drawLineSegment(draw_x, 10, states[2])
        self:drawLineSegment(draw_x, 20, states[3])
    end
    
    love.graphics.setScissor()
    love.graphics.pop()
    super.draw(self)
end

function HeartScreen:drawLineSegment(base_x, start_offset, state)
    local x1 = base_x + start_offset
    local x2 = x1 + 10
    local y_mid = self.height / 2
    if state == 1 then
        love.graphics.line(x1, y_mid, x2, y_mid)
    elseif state == 2 then
        love.graphics.line(x1, y_mid, x1 + 5, 1)
        love.graphics.line(x1 + 5, 1, x2, y_mid)
    elseif state == 3 then
        love.graphics.line(x1, y_mid, x1 + 5, self.height - 1)
        love.graphics.line(x1 + 5, self.height - 1, x2, y_mid)
    end
end

return HeartScreen
