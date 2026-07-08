local Basic, super = Class(Wave)


function Basic:init()
    super.init(self)
    self.base_w = nil -- i defined these here in case you like, wanna change the default.
    self.base_h = nil 
    self.my_clock = 0
    self.time = 15
end 
function Basic:onArenaEnter()
    super.onArenaEnter(self)
    Game.battle.arena:setFire(true, false)
end
function Basic:onStart()
    Game.battle.arena:setFire(true, true)
    self.base_w = Game.battle.arena.width -- (arena doesnt exist in init)
    self.base_h = Game.battle.arena.height
    self.timer:everyInstant(2.3, function ()
        Assets.stopAndPlaySound("spell_pacify")
        local pacify_x, pacify_y = Game.battle.soul.x + Utils.random(-100, 100), Game.battle.soul.y + Utils.random(-100, 100)
        local z_count = 0
    self.timer:every(1 / 15, function ()
            z_count = z_count + 1
            local z = self:spawnBullet("pacify_z_noncool", pacify_x, pacify_y, z_count * -40)
            z.layer = Game.battle.soul.layer + 0.002
        end, 8)
    end) 
end


return Basic
