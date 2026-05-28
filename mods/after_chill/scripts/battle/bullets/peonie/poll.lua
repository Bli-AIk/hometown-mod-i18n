---@class poll : Bullet
local poll, super = Class(Bullet)

function poll:init(x, y, angle, speed)
    super.init(self, x, y, "bullets/pollen")
    self:setOrigin(0.5, 0.5)
    self.physics.direction = angle
    self.physics.speed = speed
    self.siner = love.math.random() * 10
    self.drift_speed = love.math.random(2, 4)
    self.drift_width = love.math.random(10, 20)
end 

function poll:update()
    self.siner = self.siner + DT
    self.rotation = self.rotation + (1.5 * DT)
    
    local perpendicular = self.physics.direction + math.pi / 2
    local wind_push = math.sin(self.siner * self.drift_speed) * self.drift_width * DT
    
    self.x = self.x + math.cos(perpendicular) * wind_push
    self.y = self.y + math.sin(perpendicular) * wind_push
    
    local soul = Game.battle.soul
    local dist = MathUtils.dist(self.x, self.y, soul.x, soul.y)
    
    if dist < 25 then
        local push_angle = MathUtils.angle(soul.x, soul.y, self.x, self.y)
        local push_force = (25 - dist) * 4
        
        self.x = self.x + math.cos(push_angle) * push_force * DT
        self.y = self.y + math.sin(push_angle) * push_force * DT
    end
    
    super.update(self)
end 

return poll
