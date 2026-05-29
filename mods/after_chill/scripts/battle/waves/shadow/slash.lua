local slash, super = Class(Wave)

function slash:init()
    super.init(self)
    self:setArenaPosition(320, 230)
    self.time = 9
end

function slash:onStart()
    local shadow = self:getAttackers()[1]
    self.timer:everyInstant(1, function()
    Assets.playSound("laz_c")
    shadow:setAnimation("battle/attack", function()
        shadow:shake(2)
        shadow:setAnimation("battle/idle")
    end)
    self:alertSlash()
    end)
end  

function slash:hitSlash(x, y)
    local sx, sy = x, y
    local bullet = self:spawnBullet("effects/attack/shard", sx, sy)
    bullet.destroy_on_hit = false
    bullet.sprite:play(0.15, false, function()
          bullet:remove()
    end)
end 

function slash:alertSlash()
    local x, y = self:getSoulCoords()
    local sprite = Sprite("effects/attack/shard_1", x, y)
    Game.stage:addChild(sprite) 
    sprite.alpha = 0
    sprite:setScale(2)
    sprite:setOrigin(0.5, 0.5)
    sprite:addFX(ColorMaskFX(COLORS.red, 1)) 
    Assets.playSound("alert")
    self.timer:tween(0.1, sprite, {alpha = 0.5}, "out-expo", function()
    self.timer:tween(0.1, sprite, {alpha = 0}, "in-expo", function()
      self:hitSlash(x, y)
    end)
    end)
end 


function slash:getSoulCoords() 
    if Game.battle.soul then 
    return Game.battle.soul.x, Game.battle.soul.y 
    end 
end

return slash
