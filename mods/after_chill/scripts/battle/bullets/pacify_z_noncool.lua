---@class SpareZ : Bullet
local SpareZ, super = Class("DarkBullet")

function SpareZ:init(x, y, dir, speed)
    super.init(self, x, y, "effects/spare/z")
    self.tiredness = 12
    self.remove_offscreen = false
    self:setScale(0.02)
    self.graphics.grow = 0.04
    self:fadeOutSpeedAndRemove(0.02)
    self:addFX(ColorMaskFX({0.4, 0.6, 1.0}, 0.4))
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

return SpareZ
