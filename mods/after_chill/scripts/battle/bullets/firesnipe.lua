local firesnipe, super = Class("DarkBullet")

function firesnipe:init(x, y)
    super.init(self, x, y, "bullets/fire")
    self.tiredness = 24
    self:addFX(ColorMaskFX({0.4, 0.6, 1.0}, 0.4))
    self.destroy_on_hit = true
    self.remove_offscreen = true
 --   self.graphics.spin = 0.1
    self.trail_timer = 0
    self.state = "NORMAL" 
end

function firesnipe:update()
    if self.state == "EXPAND_RING" then
        self.angle = self.angle + (1 * DT)     
        self.x = self.center_x + math.cos(self.angle) * (self.radius or 0)
        self.y = self.center_y + math.sin(self.angle) * (self.radius or 0)    
    elseif self.state == "ROTATE" then 
        self.angle = self.angle + (3 * DT) 
        self.x = self.center_x + math.cos(self.angle) * self.radius
        self.y = self.center_y + math.sin(self.angle) * self.radius
    end
    
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

function firesnipe:fireAtSoul()
    local soul = Game.battle.soul
    if not soul then return end
    self.state = "NORMAL"
    local target_angle = MathUtils.angle(self.x, self.y, soul.x, soul.y)
    self.physics.speed = 9
    self.physics.direction = target_angle
end

return firesnipe
