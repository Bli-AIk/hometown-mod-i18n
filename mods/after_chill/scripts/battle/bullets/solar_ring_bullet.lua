local solar_ring_bullet, super = Class("DarkBullet")

function solar_ring_bullet:init(x, y, dir, speed)
    super.init(self, x, y, "bullets/fire")
    self:setHitbox(0, 0, 10, 12)
    self:addFX(ColorMaskFX({0.4, 0.6, 1.0}, 0.4))
    self.physics.direction = dir
    self.physics.speed = speed or 4
    self.destroy_on_hit = true
    self.remove_offscreen = true
   -- self.graphics.spin = 0.1
    self.trail_timer = 0
end

function solar_ring_bullet:update()
    super.update(self)
    self.trail_timer = self.trail_timer + DT
    if self.trail_timer >= 0.04 then
        local trail = AfterImage(self, 0.4, 0.08)
        trail:setColor(1, 0.2, 0)
        trail.layer = self.layer - 1 
        Game.battle:addChild(trail)
        self.trail_timer = 0
    end
end

return solar_ring_bullet
