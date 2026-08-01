local manual_throw, super = Class(Wave)

function manual_throw:init()  
    super.init(self)
    self.time = 12
    self.manual_timer = nil
    self.book_direction = "left" 
end 

function manual_throw:onStart()
    local ralsei = self:getAttackers()[1]
    if ralsei then
        ralsei:setAnimation("spell", function()
            self:spawnManual(ralsei)
        end)
    end
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
    if not manual or not manual.stage then return end
    Assets.playSound("book_open")
    manual.sprite:setSprite("bullets/manual_open")
    manual.sprite:flash()
    manual:slideTo(159, 180, 0.5, "out-quad", function()
        self:startBookRoutine(manual)
    end)
end 

function manual_throw:startBookRoutine(manual)
    local start_x = 90
    local end_x   = 230
    manual:slideTo(start_x, 180, 1.5, "in-out-sine")
    self.book_direction = "left"
    
    self.manual_timer = self.timer:every(0.4, function()
        if not manual or not manual.stage then return end
        if not Game.battle.soul then return end    
        local bx, by = manual:getRelativePos(manual.width/2, manual.height/2)
        local bullet = self:spawnBullet("bullets/page", bx, by)
        bullet.layer = manual.layer - 0.0001
        bullet.physics.gravity = 0.4 
        bullet.graphics.spin = love.math.random(0.2, 0.4)
        bullet.physics.direction = math.rad(90)
        bullet:setHitbox(0, 0, 12, 18)
        bullet.physics.speed = 4.5  
        bullet.rotation = math.rad(love.math.random(0, 360)) 
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
            if bullet_self.trail_timer >= 0.06 then
                local afterimage = AfterImage(bullet_self, 0.3)
                if bullet:getFX(ColorMaskFX) then 
                    afterimage:addFX(ColorMaskFX(COLORS.lime))
                end 
                Game.battle:addChild(afterimage)
                bullet_self.trail_timer = 0
            end
        end
        if self.book_direction == "left" and manual.x <= start_x + 5 then
            self.book_direction = "right"
            manual:slideTo(end_x, 180, 1.5, "in-out-sine")
            manual.sprite:flash()
            Assets.playSound("bell_bounce_short")
        elseif self.book_direction == "right" and manual.x >= end_x - 5 then
            self.book_direction = "left"
            manual:slideTo(start_x, 180, 1.5, "in-out-sine")
            manual.sprite:flash()
            Assets.playSound("bell_bounce_short")
        end
    end)
end

function manual_throw:onEnd()
    if self.manual_timer then
        self.timer:cancel(self.manual_timer)
    end
    super.onEnd(self)
end

return manual_throw
