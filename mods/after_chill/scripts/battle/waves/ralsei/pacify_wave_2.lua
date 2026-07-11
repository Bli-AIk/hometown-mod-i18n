local Basic, super = Class(Wave)

function Basic:init()
    super.init(self)
    self.time = 12.5
end 

function Basic:onArenaEnter()
    super.onArenaEnter(self)
    Game.battle.arena:setFire(true, false)
end

function Basic:onStart()
    Game.battle.arena:setFire(true, true)
    if Game.battle.soul then 
    self.timer:everyInstant(1.8, function()
        local ralsei = self:getAttackers()[1]
        ralsei:setAnimation("spell", function()
        Assets.playSound("alert")
        local pacify_x, pacify_y = Game.battle.soul:getRelativePos(Game.battle.soul.width/2, Game.battle.soul.height/2, Game.battle)
        self.timer:after(0.13, function()       
        Assets.stopAndPlaySound("spell_pacify")
        local z_count = 0
        self.timer:every(1/20, function()
            z_count = z_count + 1
            local z = self:spawnBullet("pacify_z_noncool", pacify_x, pacify_y, z_count * -40)
            z:setHitbox(4, 4, 14, 14)
            z.layer = Game.battle.soul.layer + 0.002
            z.tiredness = 24 
        end, 8)
    end) 
end)
end)
end 
end


return Basic
