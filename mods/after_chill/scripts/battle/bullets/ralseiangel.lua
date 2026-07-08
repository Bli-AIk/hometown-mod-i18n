---@class SmallBullet : Bullet
local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, dir, speed)
    super.init(self, x, y, "bullets/ralsei/bullet")
    self.physics.direction = dir
    self.physics.speed = speed
    self.anim_speed = 1/12  -- this is how to make animated bullets fluffy if you ever want them
    self.anim_loop = true   -- this loops it! - gamer12
self.alpha = 0
self.alivetime = 60
self.timealive = 0
    self.sprite:play(self.anim_speed, self.anim_loop)

end
function SmallBullet:onWaveSpawn()
    self.wave.timer:tween(0.5, self, {alpha = 1}, "linear", function() end)
end
function SmallBullet:update()
    super.update(self)
    self.y = self.y + Utils.random(-3, 3)
    if self.timealive < self.alivetime then
        self.timealive = self.timealive + 1
    else
        self.wave.timer:tween(1, self, {alpha = 0}, "linear", function() self:remove() end)
    end
end

return SmallBullet
