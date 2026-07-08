---@class DarkBullet : Bullet
local DarkBullet, super = Class(Bullet, "DarkBullet")

function DarkBullet:init(x, y, texture, ...)
    super.init(self, x, y, texture, ...)
    self.tiredness = 8
end

function DarkBullet:getTired()
    return self.tiredness 
end 

function DarkBullet:onCollide(soul)
    super.onCollide(self, soul)
    if Game.battle.tired_bar then 
    Game.battle.tired_bar:addTired(self:getTired())
    end 
    for _, follower in ipairs(Game.battle.party) do 
        local status = follower:statusMessage("mercy", self:getTired() or 5)
        status:addFX(HueShift(math.rad(90)))
    end 
end 

return DarkBullet
