local Basic, super = Class(Wave)


function Basic:init()
    super.init(self)
    self.base_w = nil -- i defined these here in case you like, wanna change the default.
    self.base_h = nil 
    self.my_clock = 0
end 

function Basic:onStart()
    self.base_w = Game.battle.arena.width -- (arena doesnt exist in init)
    self.base_h = Game.battle.arena.height

    self.timer:every(1 / 3, function()
        local x = SCREEN_WIDTH + 20
        local y = MathUtils.random(Game.battle.arena.top, Game.battle.arena.bottom)
        
        local bullet = self:spawnBullet("smallbullet", x, y, math.rad(180), 8)
        bullet.remove_offscreen = false
    end)
end

return Basic
