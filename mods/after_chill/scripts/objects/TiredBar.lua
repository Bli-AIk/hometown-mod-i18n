---@class TiredBar : Object
---@overload fun(...) : TiredBar
local TiredBar, super = Class(Object)

function TiredBar:init(x, y, dont_animate)
    self.target_x = x or 70
    self.target_y = y or 3
    super.init(self, self.target_x, self.target_y)
    self.layer = BATTLE_LAYERS["ui"]
    self.tp_bar_fill = Assets.getTexture("ui/battle/tp_bar_fill")
    self.tp_bar_outline = Assets.getTexture("ui/battle/tp_bar_outline")
    self.tired_text = Assets.getTexture("ui/battle/tired_text")
    -- we need to make it draw ("ui/battle/tired_text") MAKE SURE TO COMMENT WHAT I MANUALLY NEED TO CHANGE IF IT DOESNT WORK.
    self.width = self.tp_bar_outline:getWidth()
    self.height = self.tp_bar_outline:getHeight()

    self.tiredness = 0
    self.apparent = 0
    self.current = 0
    self.changetimer = 15
    self.font = Assets.getFont("main")

    if dont_animate then
        self.animating_in = false
    else
        self.animating_in = true
    end

    self.animation_timer = 0
    self.shown = false
    self.timer = self:addChild(Timer())
end

function TiredBar:show()
    if not self.shown then
        self:resetPhysics()
        self.x = 0
        self.y = self.target_y
        self.shown = true
        self.animating_in = true
        self.animation_timer = 0
    end
end

function TiredBar:processSlideIn()
    if self.animating_in then
        self.animation_timer = self.animation_timer + DTMULT
        if self.animation_timer > 12 then
            self.animation_timer = 12
            self.animating_in = false
        end
        self.x = Utils.ease(self.animation_timer, 0, self.target_x, "out-cubic")
    end
end

function TiredBar:hide()
    if self.shown then
        self.animating_in = false
        self.shown = false
        self.physics.speed_x = -10
        self.physics.friction = -0.4
    end
end

function TiredBar:addTired(amount)
    Assets.playSound("ghostappear", 1.4, 0.9)
    self.tiredness = math.min(100, math.max(0, self.tiredness + (amount or 0)))
    if self.tiredness >= 100 then
        self:onMaxTired()
    end
end

function TiredBar:onMaxTired()
    -- add code here if wanted.
end

function TiredBar:getDebugInfo()
    local info = super.getDebugInfo(self)
    table.insert(info, "Tiredness: " .. MathUtils.round(self.tiredness) .. "%")
    table.insert(info, "Apparent: " .. MathUtils.round(self.apparent))
    table.insert(info, "Current: " .. MathUtils.round(self.current))
    return info
end

function TiredBar:processTiredness()
    local target_value = self.tiredness

    if (math.abs((self.apparent - target_value)) < 8) then
        self.apparent = target_value
    end

    if (self.apparent < target_value) then
        self.apparent = self.apparent + (8 * DTMULT)
    end

    if (self.apparent > target_value) then
        self.apparent = self.apparent - (8 * DTMULT)
    end

    if (self.apparent ~= self.current) then
        self.changetimer = self.changetimer + (1 * DTMULT)
        if (self.changetimer > 15) then
            if ((self.apparent - self.current) > 0) then self.current = self.current + (2 * DTMULT) end
            if ((self.apparent - self.current) > 10) then self.current = self.current + (2 * DTMULT) end
            if ((self.apparent - self.current) > 25) then self.current = self.current + (3 * DTMULT) end
            if ((self.apparent - self.current) > 50) then self.current = self.current + (4 * DTMULT) end
            if ((self.apparent - self.current) > 75) then self.current = self.current + (5 * DTMULT) end
            if ((self.apparent - self.current) < 0) then self.current = self.current - (2 * DTMULT) end
            if ((self.apparent - self.current) < -10) then self.current = self.current - (2 * DTMULT) end
            if ((self.apparent - self.current) < -25) then self.current = self.current - (3 * DTMULT) end
            if ((self.apparent - self.current) < -50) then self.current = self.current - (4 * DTMULT) end
            if ((self.apparent - self.current) < -75) then self.current = self.current - (5 * DTMULT) end
            if (math.abs((self.apparent - self.current)) < 1) then
                self.current = self.apparent
            end
        end
    end
end

function TiredBar:update()
    self:processSlideIn()
    self:processTiredness()
    super.update(self)
end

function TiredBar:drawText()
    local text_x_offset = self.width + 12
    local tamt = math.floor(self.apparent)
    self.maxed = false
    Draw.setColor(1, 1, 1, 1) 
    Draw.draw(self.tired_text, 30, 10, 0, 1, 1)
    love.graphics.setFont(self.font) 
    if (tamt < 100) then
        Draw.setColor(1, 1, 1, 1)
        love.graphics.print(tostring(math.floor(self.apparent)), text_x_offset, 40)
        love.graphics.print("%", text_x_offset + 5, 65)
    else
        self.maxed = true
        self:drawMaxText()
    end
end

function TiredBar:drawMaxText()
    local text_x_offset = self.width + 12
    Draw.setColor(40/255, 90/255, 240/255, 1)
    love.graphics.print("M", text_x_offset, 40)
    love.graphics.print("A", text_x_offset + 4, 60)
    love.graphics.print("X", text_x_offset + 8, 80)
end

function TiredBar:drawBack()
    Draw.setColor(20/255, 30/255, 75/255, 1)
    local fill_y = self.height - ((self.current / 100) * self.height) + 1
    Draw.drawPart(self.tp_bar_fill, 0, 0, 0, 0, self.width, fill_y)
end

function TiredBar:drawFill()
    local tired_fill     = {40/255, 90/255, 240/255, 1}
    local tired_max      = {0/255, 160/255, 255/255, 1}
    local tired_decrease = {20/255, 45/255, 120/255, 1}

    if (self.apparent < self.current) then
        Draw.setColor(tired_decrease)
        local y = MathUtils.clamp(self.height - ((self.current / 100) * self.height) + 1, 0, self.height)
        Draw.drawPart(self.tp_bar_fill, 0, y, 0, y, self.width, self.height)

        Draw.setColor(tired_fill)
        local y2 = MathUtils.clamp(self.height - ((self.apparent / 100) * self.height) + 1, 0, self.height)
        Draw.drawPart(self.tp_bar_fill, 0, y2, 0, y2, self.width, self.height)
        
    elseif (self.apparent > self.current) then
        Draw.setColor(1, 1, 1, 1)
        local y = MathUtils.clamp(self.height - ((self.apparent / 100) * self.height) + 1, 0, self.height)
        Draw.drawPart(self.tp_bar_fill, 0, y, 0, y, self.width, self.height)

        Draw.setColor(tired_fill)
        if (self.maxed) then Draw.setColor(tired_max) end

        local y2 = MathUtils.clamp(self.height - ((self.current / 100) * self.height) + 1, 0, self.height)
        Draw.drawPart(self.tp_bar_fill, 0, y2, 0, y2, self.width, self.height)
        
    elseif (self.apparent == self.current) then
        Draw.setColor(tired_fill)
        if (self.maxed) then Draw.setColor(tired_max) end

        local y = MathUtils.clamp(self.height - ((self.current / 100) * self.height) + 1, 0, self.height)
        Draw.drawPart(self.tp_bar_fill, 0, y, 0, y, self.width, self.height)
    end

    if (self.apparent > 3) then
        Draw.setColor(1, 1, 1, 1)
        local y = MathUtils.clamp(self.height - ((self.current / 100) * self.height) + 1, 0, self.height)
        Draw.drawPart(self.tp_bar_fill, 0, y, 0, y, self.width, 3)
    end
end

function TiredBar:draw()
    Draw.setColor(1, 1, 1, 1)
    Draw.draw(self.tp_bar_outline, 0, 0)
    self:drawBack()
    self:drawFill()
    self:drawText()
    super.draw(self)
end

return TiredBar
