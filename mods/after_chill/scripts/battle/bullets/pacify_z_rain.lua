local pacify_z_rain, super = Class("DarkBullet")

function pacify_z_rain:init(x, y)
    super.init(self, x, y, "effects/spare/z")
    self:setScale(0.02)
    self:addFX(ColorMaskFX({0.4, 0.6, 1.0}, 0.4))
    self.graphics.grow = 0.04
    self.tiredness = 8
    self.damage = self:getDamage()/1.3
    self.tp = 0
    self.destroy_on_hit = true 
    self.remove_offscreen = true
    self.lifetime = 0
    self.is_fading = false
    self.trail_timer = 0 
end


function pacify_z_rain:update()
    super.update(self)
    
    self.lifetime = self.lifetime + DT
    if not self.is_fading then
        self.trail_timer = self.trail_timer + DT
        if self.trail_timer >= 0.04 then
            local trail = AfterImage(self, 0.4, 0.08)
            trail:setColor(0.3, 0.5, 1)
            trail.layer = self.layer - 1
            Game.battle:addChild(trail)
            self.trail_timer = 0
        end
    end
    if self.lifetime >= 1.5 and not self.is_fading then
        self.is_fading = true
        self:fadeTo(0, 0.2, function()
            self:remove()
        end)
    end
end

return pacify_z_rain
