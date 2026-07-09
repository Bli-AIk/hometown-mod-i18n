local clock_drop_bullet, super = Class("DarkBullet")

function clock_drop_bullet:init(x, y)
    super.init(self, x, y, "effects/spare/z")
    self:setScale(0.02)
    self:addFX(ColorMaskFX({0.4, 0.6, 1.0}, 0.4))
    self.graphics.grow = 0.04
    self.tiredness = 6
    self.damage = 12
    self.destroy_on_hit = true
    self.remove_offscreen = true 
    self.lifetime = 0
    self.is_fading = false
    self:setHitbox(0, 0, 16, 16)
end

function clock_drop_bullet:update()
    super.update(self)
    self.lifetime = self.lifetime + DT
    if self.lifetime >= 2 and not self.is_fading then
        self.is_fading = true
        self:fadeTo(0, 0.2, function()
            self:remove()
        end)
    end
end

return clock_drop_bullet
