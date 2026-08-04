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
    self.timer:everyInstant(1.8, function()
        if not Game.battle.soul then return end
        local ralsei = self:getAttackers()[1]
        ralsei:setAnimation("spell", function()
        Assets.playSound("alert")
        local pacify_x, pacify_y = Game.battle.soul:getRelativePos(Game.battle.soul.width/2, Game.battle.soul.height/2, Game.battle)
        local z = self:spawnSprite("effects/spare/z", pacify_x, pacify_y, Game.battle.soul.layer + 0.01)
        z.alpha = 0.7 
        z:setScale(1)
        z:addFX(ColorMaskFX(COLORS.red, 0.7))
        self.timer:after(0.15, function()   
        z:fadeOutSpeedAndRemove(0.2)
        if not Game.battle.soul then return end    
        Assets.stopAndPlaySound("spell_pacify")
        local z_count = 0
        self.timer:every(1/20, function()
            if not Game.battle.soul then return end
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


return Basic
