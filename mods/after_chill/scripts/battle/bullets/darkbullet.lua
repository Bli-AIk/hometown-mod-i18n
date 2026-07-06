---@class SmallBullet : Bullet
local DarkBullet, super = Class(Bullet)

function DarkBullet:init(x, y, texture, ...)
    super.init(self, x, y, texture, ...)
    self.tiredness = 8
end

function DarkBullet:getTired()
    return self.tiredness 
end 

function DarkBullet:onCollide(soul)
    super.onCollide(self, soul)
    for _, follower in ipairs(Game.battle.party) do 
        local status = follower:statusMessage("mercy", self:getTired() or 5)
        status:addFX(HueShift(math.rad(90)))
    end 
end 

return DarkBullet
