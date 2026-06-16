local warning_line, super = Class(WorldBullet)

function warning_line:init(x, y, width, height)
    super.init(self, x, y)
    self.rect = Rectangle(x, y, width, height)
    self.rect:setColor(COLORS.red)
    self.rect.alpha = 0.5 
    self.rect.rotation = math.rad(-30)
end 

function warning_line:onCollide(soul)
    if not self.has_hit then
        self.has_hit = true
        local push_force = 0.1
        local push_x = math.cos(self.physics.direction) * push_force
        local push_y = math.sin(self.physics.direction) * push_force
        Game.world.player:move(push_x, push_y)
        
        Game.world.timer:after(0.5, function()
            self.has_hit = false
        end)
    end
    return super.onCollide(self, soul)
end 

return warning_line
