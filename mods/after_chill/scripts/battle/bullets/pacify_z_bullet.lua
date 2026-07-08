local pacify_z_bullet, super = Class("DarkBullet")

function pacify_z_bullet:init(x, y)
    super.init(self, x, y, "effects/spare/z")
    self:setScale(0.02)
    self:addFX(ColorMaskFX({0.4, 0.6, 1.0}, 0.4))
    self.graphics.grow = 0.04
    self.base_speed = 10
    self.physics.speed = self.base_speed
    self.physics.direction = math.rad(-90 + (love.math.random(-30, 30)))
    self.lifetime = 0
    self.destroy_on_hit = true 
    self.tiredness = 12 
    self.is_fading = false
end

function pacify_z_bullet:update()
    if not Game.battle or not Game.battle.soul then 
        super.update(self)
        return 
    end

    self.lifetime = self.lifetime + DT
    if self.lifetime >= 1.4 and not self.is_fading then
        self.is_fading = true
        self:fadeTo(0, 0.2, function()
            self:remove()
        end)
    end

    local soul = Game.battle.soul
    if self.lifetime > 0.4 and not self.is_fading then
        local current_vx = math.cos(self.physics.direction) * self.physics.speed
        local current_vy = math.sin(self.physics.direction) * self.physics.speed
        
        local target_angle = Utils.angle(self.x, self.y, soul.x, soul.y)
        
        local target_vx = math.cos(target_angle) * self.base_speed
        local target_vy = math.sin(target_angle) * self.base_speed
        
        local turn_speed = 4.5
        local new_vx = current_vx + (target_vx - current_vx) * (turn_speed * DT)
        local new_vy = current_vy + (target_vy - current_vy) * (turn_speed * DT)
        
        self.physics.speed = math.sqrt(new_vx^2 + new_vy^2)
        self.physics.direction = math.atan2(new_vy, new_vx)
    end
    
    super.update(self)
end

return pacify_z_bullet
