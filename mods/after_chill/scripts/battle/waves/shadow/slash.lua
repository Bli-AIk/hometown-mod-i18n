local slash, super = Class(Wave)

function slash:init()
    super.init(self)
    self:setArenaPosition(320, 230)
    self.time = 13
end

function slash:onStart()
    local shadow = self:getAttackers()[1]
    self.timer:everyInstant(1.2, function()
    shadow:setAnimation("battle/act")
    self.timer:after(0.1, function()
        self:alertSlash()
    end)
    end)
end  

function slash:hitSlash(x, y)
    local sx, sy = x, y
    local bullet = self:spawnBullet("effects/attack/shard", sx, sy)
    bullet.destroy_on_hit = false
    local damage = bullet:getDamage()
    bullet.damage = damage + 30
   bullet.collider = PolygonCollider(bullet, {
        {-2, -7},  
        {16, 9},  
        {42, 45},
        {5, 17}
    })
    local shadow = self:getAttackers()[1]
    Assets.playSound("laz_c", 0.4, 0.8)
    Assets.playSound("scytheburst", 1.5)
    shadow:setAnimation("battle/attack", function()
        shadow:shake(2)
        shadow:resetSprite()
    end)
    bullet.sprite:play(0.15, false, function()
          bullet:remove()
    end)
end 

function slash:alertSlash()
    local x, y = self:getSoulCoords()
    local sprite = Sprite("effects/shard", x, y)
    Game.stage:addChild(sprite) 
    sprite.alpha = 0.5
    sprite:setScale(2)
    sprite:setOrigin(0.5, 0.5)
    Assets.playSound("alert")
    for i = 1, 3 do 
    self.timer:tween(0.1, sprite, {alpha = 0.5}, "out-expo", function()
    self.timer:tween(0.1, sprite, {alpha = 0}, "in-expo", function()
        if i == 2 then
        self.timer:after(0.08, function()
        self:hitSlash(x, y)
        end)
        end 
    end)
    end)
end
end 


function slash:getSoulCoords() 
    if Game.battle.soul then 
    return Game.battle.soul.x, Game.battle.soul.y 
    end 
end

return slash
