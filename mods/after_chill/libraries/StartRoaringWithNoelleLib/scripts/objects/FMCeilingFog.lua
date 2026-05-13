---@class FMCeilingFog : Object
---@overload fun(...) : FMCeilingFog
local FMCeilingFog, super = Class(Object)

function FMCeilingFog:init()
    super.init(self, 0, 0, SCREEN_WIDTH/2, SCREEN_HEIGHT/2)

    self:setParallax(0, 0)
    self:setScale(2, 2)

    self.ball = Assets.getTexture("effects/make_fountain/ball")
    self.ball_ox = 24
    self.ball_oy = 24

    self.timer = 0
    self.cur_height = 0
end

function FMCeilingFog:update()
    self.timer = self.timer + DTMULT
    if self.cur_height < 120 then
        self.cur_height = self.cur_height + (math.sin(self.timer / 18) + 0.3) * DTMULT
    else
        self.cur_height = self.cur_height + 1 * DTMULT
    end
end

function FMCeilingFog:draw()
    local ball_x = {}
    love.graphics.setColor(COLORS["white"])
    for i = 0, 12 - 1 do
        ball_x[i] = -40 + ((self.timer + i * 40) % 400)
        love.graphics.draw(self.ball, ball_x[i], self.cur_height - 80 + math.sin(i + self.timer / 8) * 7, 0, 1.05, 1.05, self.ball_ox, self.ball_oy)
    end
    love.graphics.setColor(COLORS["black"])
    for i = 0, 12 - 1 do
        love.graphics.draw(self.ball, ball_x[i], self.cur_height - 80 + math.sin(i + self.timer / 8) * 7, 0, 1, 1, self.ball_ox, self.ball_oy)
    end
    local function rectAxis1toAxis2(mode, x1, y1, x2, y2)
        if x1 > x2 then x1, x2 = x2, x1 end
        if y1 > y2 then y1, y2 = y2, y1 end
        love.graphics.rectangle(mode, x1, y1, x2-x1, y2-y1)
    end
    rectAxis1toAxis2("fill", 0, self.cur_height - 80, self.width, -90)
end

return FMCeilingFog