---@class SmallBullet : Bullet
local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, dir, speed)
    super.init(self, x, y, "bullets/ralsei/bullet")
    self.physics.direction = dir
    self.physics.speed = speed
    self.anim_speed = 1/12  -- this is how to make animated bullets fluffy if you ever want them
    self.anim_loop = true   -- this loops it! - gamer12
    self.alpha = 0
    self.alivetime = 2.0
    self.timealive = 0
    self.is_dying = false
    self.start_y = y
    self.wave_offset = love.math.random() * math.pi * 2
    self.sprite:play(self.anim_speed, self.anim_loop)
end

function SmallBullet:onWaveSpawn()
    if self.wave and self.wave.timer then
        self.wave.timer:tween(0.5, self, {alpha = 1}, "linear")
    end
end

function SmallBullet:update()
    super.update(self)  
    self.timealive = self.timealive + DT
    if not self.is_dying then
        local wave_movement = math.sin((self.timealive * 6) + self.wave_offset) * 9
        self.y = self.start_y + wave_movement
    end
    if self.timealive >= self.alivetime and not self.is_dying then
        self.is_dying = true
        
        if self.wave and self.wave.timer then
            self.wave.timer:tween(1, self, {alpha = 0}, "linear", function() 
                self:remove() 
            end)
        else
            self:remove()
        end
    end
end

return SmallBullet
