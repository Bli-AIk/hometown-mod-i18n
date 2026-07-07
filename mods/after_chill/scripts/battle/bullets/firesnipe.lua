local firesnipe, super = Class(Bullet)

function firesnipe:init(x, y)
    super.init(self, x, y, "bullets/fire")
    self.destroy_on_hit = true
    self.remove_offscreen = true
    self.graphics.spin = 0.1
    self.trail_timer = 0
end

function firesnipe:update()
    self.trail_timer = self.trail_timer + DT
    if self.trail_timer >= 0.04 then
        local trail = AfterImage(self, 0.4, 0.08)
        trail:setColor(1, 0.2, 0)
        trail.layer = self.layer - 1
        Game.battle:addChild(trail)
        self.trail_timer = 0
    end
    super.update(self)
end

return firesnipe
