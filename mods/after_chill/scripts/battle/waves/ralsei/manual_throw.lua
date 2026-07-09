local manual_throw, super = Class(Wave)

function manual_throw:init()  
    super.init(self)
    self.time = 12
end 

function manual_throw:onStart()
    local ralsei = self:getAttackers()[1]
    ralsei:setAnimation("spell", function()
        self:spawnManual(ralsei)
    end)
end

function manual_throw:spawnManual(enemy)
    local manual = self:spawnBullet("bullets/manual", 472, 187)
    manual.rotation = math.rad(25)
    manual.trail_timer = 0
    local original_update = manual.update
    manual.update = function(bullet_self)
        original_update(bullet_self)
        bullet_self.trail_timer = bullet_self.trail_timer + DT
        if bullet_self.trail_timer >= 0.05 then
            local afterimage = AfterImage(bullet_self, 0.4)
            afterimage:setColor(1, 0.6, 0)
            Game.battle:addChild(afterimage)
            bullet_self.trail_timer = 0
        end
    end
    manual.alpha = 0 
    manual:fadeTo(1, 0.2, function()
        Assets.playSound("grab")
        self.timer:tween(1.2, Game.battle.arena, {x = 159, y = 295, rotation = math.rad(45)}, "out-cubic")
        self.timer:tween(1.2, manual, {rotation = math.rad(45)}, "out-cubic", function()
            self:openBook(manual)
        end)
    end)
end


function manual_throw:openBook(manual)
    Assets.playSound("book_open")
    manual.sprite:setSprite("bullets/manual_open")
    manual.sprite:flash()
    
    self.timer:after(0.2, function()
        manual:slideTo(341, 112, 0.5, "linear", function()
            self:shootBurst(manual)
        end)
    end)
end 


function manual_throw:shootBurst(manual)
    if not manual or not manual.stage then return end
    
    manual.sprite:flash()
    Assets.playSound("bomb")
    for i = 1, 3 do 
        local bx, by = manual:getRelativePos(manual.width/2, manual.height/2)
        local offset_x = love.math.random(-10, 10)
        local offset_y = love.math.random(-10, 10)  
        local bullet = self:spawnBullet("bullets/page", bx + offset_x, by + offset_y)
        bullet.physics.direction = MathUtils.angle(bullet.x, bullet.y, Game.battle.soul.x, Game.battle.soul.y)
        bullet.physics.speed = love.math.random(10, 14)
        bullet.rotation = math.rad(bullet.physics.direction)
        bullet.trail_timer = 0
        if love.math.random(1, 3) == 2 then 
            bullet:addFX(ColorMaskFX(COLORS.lime))
            bullet.alpha = 0.7
            bullet.onCollide = function(bs) 
              bs:remove()
              for _, follower in ipairs(Game.battle.party) do 
              follower:heal(bs:getDamage()/2)
              end 
            end 
        end 
        local original_update = bullet.update
        bullet.update = function(bullet_self)
        original_update(bullet_self)
        bullet_self.trail_timer = bullet_self.trail_timer + DT
        if bullet_self.trail_timer >= 0.05 then
            local afterimage = AfterImage(bullet_self, 0.4)
            Game.battle:addChild(afterimage)
            bullet_self.trail_timer = 0
        end
        end
        end 
    self.timer:after(0.5, function()
        local start_x, start_y = 100, 80 
        local end_x, end_y     = 400, 220
        local t = love.math.random() 
        local target_x = start_x + (end_x - start_x) * t
        local target_y = start_y + (end_y - start_y) * t
        manual:slideTo(target_x, target_y, 0.6, "out-quad", function()
            self:shootBurst(manual)
        end)
    end)
end


return manual_throw
