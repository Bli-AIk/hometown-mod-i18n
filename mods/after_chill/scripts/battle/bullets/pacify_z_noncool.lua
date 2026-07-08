---@class SpareZ : Bullet
local SpareZ, super = Class("DarkBullet")

function SpareZ:init(x, y, dir, speed)
    super.init(self, x, y, "effects/spare/z")
    self.tiredness = 12
    self.remove_offscreen = false
    self:setOrigin(0.5, 0.5)
    self:fadeOutSpeedAndRemove(0.02)
    self.damage = 0
    self.tp = 0
    self.grow_x = 0.1
    self.grow_y = 0.1
    self.scale_x = 1
    self.scale_y = 1
    self.physics.speed = 12
    self.physics.direction = math.rad(dir)
    self.physics.friction = 1
    self.base_speed = 0
end
function SpareZ:update()
    self.scale_x = self.scale_x + self.grow_x * DTMULT
    self.scale_y = self.scale_y + self.grow_y * DTMULT

    super.update(self)
end

return SpareZ
