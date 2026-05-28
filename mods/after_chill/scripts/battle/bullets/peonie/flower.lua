---@class flower : Bullet
local flower, super = Class(Bullet)

function flower:init(x, y, scale, speed)
    super.init(self, x, y, "bullets/flower")
    self:setOrigin(0.5, 0.5)
    self:setScale(scale)
    self.wave_time = 0
    self.spin_speed = speed
end

function flower:update()
    self.wave_time = self.wave_time + DT
    self.rotation = self.rotation + (self.spin_speed * DT)
    super.update(self)
end

return flower
