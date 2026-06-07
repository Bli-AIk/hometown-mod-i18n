local sword_star, super = Class(Wave)

function sword_star:init()
    super.init(self)
    self.time = -1 
    self:setArenaPosition(214, 229)
end

function sword_star:onStart()
    self.orig_width = Game.battle.arena.width
    self.orig_height = Game.battle.arena.height

    local arena = Game.battle.arena 
    local bleh = arena.height
    local shadow = self:getAttackers()[1]
    shadow:setAnimation("battle/act_ready") 
    local snd = Assets.playSound("appear", 1, 1.6)
    
    self.timer:tween(0.5, arena, {height = bleh / 3, y = 229}, "in-expo", function()
        self.timer:after(0.3, function()
            shadow:setAnimation("no_heart")
            Assets.playSound("bell_bounce_short")
            local bullet = self:spawnBullet("bullets/sword", 443, 230)
            bullet.layer = Game.battle.arena.layer - 1
            bullet:setScale(2.4)
            bullet.alpha = 0
            bullet:fadeTo(1, 0.3, function()
                bullet:slideTo(299, 230, 0.4, "in-back", function()
                    bullet.can_graze = false
                    Assets.playSound("impact")
                    arena:shake() 
                    self:spawnStars(3, bullet)        
                end)
            end)
        end) 
    end)
end

function sword_star:spawnStars(amount, sword)
    local x = Game.battle.arena:getRight() 
    local y1 = Game.battle.arena:getTop()
    local bullet 
    for i = 1, amount do
        self.timer:after(i * 0.05, function() 
            if i == 1 then 
                bullet = self:spawnBullet("effects/criticalswing/sparkle", x, 216) 
            elseif i == 2 then 
                bullet = self:spawnBullet("effects/criticalswing/sparkle", x, 230)   
            else 
                bullet = self:spawnBullet("effects/criticalswing/sparkle", x, 230 + i * 5) 
            end 
            bullet:setScale(1.5)
            bullet.sprite:play(0.1, true)
            local speeds = {love.math.random(-6, -9), love.math.random(-4, -7), love.math.random(-5, -8)} 
            bullet.physics.speed_x = speeds[i] 
        end)
    end  
    self:waitAndRemoveSword(0.8, sword)
end

function sword_star:waitAndRemoveSword(time, bullet) 
    self.timer:after(time, function() 
        self:getSwordOut(bullet)
    end)
end  

function sword_star:getSwordOut(bullet)
    Assets.playSound("bomb")  
    bullet:slideTo(bullet.x + 50, bullet.y, 0.3, "out-back", function()
        local snd = Assets.playSound("boost")
        local duration = snd:getDuration() - 0.1
        local target = (math.pi * 6) + math.rad(160)    
        self.timer:tween(duration, bullet, {rotation = target}, "out-cubic", function()
            bullet.rotation = math.rad(160) 
            local shadow = self:getAttackers()[1]
            Assets.playSound("wing")
            shadow:setAnimation("battle/act_end")
            self.timer:after(0.3, function()
                Assets.playSound("bigcut", 1, 0.8)
                bullet:slideTo(515, 176, 0.3, "out-expo", function()
                    self:sendShot(bullet)
                    self.timer:after(0.2, function()
                        Assets.playSound("boost")
                        self.timer:tween(0.2, bullet, {rotation = math.rad(20)}, "out-cubic", function()
                            local x, y = Game.battle.arena:getCenter()
                            bullet:slideTo(x, 50, 0.5, "in-cubic")
                            self.timer:tween(0.5, bullet, {rotation = math.rad(270)}, "linear", function()
                                self:afterimageTime(bullet)
                            end)
                        end)
                    end)
                end)
            end)
        end)
    end)
end

function sword_star:sendShot(bullet)
    local clone = self:spawnBullet("bullets/sword", bullet.x, bullet.y)
    clone:addFX(ColorMaskFX(COLORS.red, 0.5))
    clone.alpha = 0 
    clone:setScale(2)
    Assets.playSound("bell_bounce_short")
    clone:fadeTo(1, 0.2, function()
    clone.physics.speed = 27
    clone.physics.match_rotation = false 
    clone.physics.direction = MathUtils.angle(clone.x, clone.y, Game.battle.soul.x, Game.battle.soul.y)
    clone.sprite.scale_x = -1 
    clone:setOrigin(0.5, 0.5)
    clone.rotation = MathUtils.angle(clone.x, clone.y, Game.battle.soul.x, Game.battle.soul.y)
    end)
end 

function sword_star:afterimageTime(bullet)
    local sound = Assets.playSound("charge")
    sound:setLooping(true)
    self.timer:every(0.05, function()
        local afterimage = AfterImage(bullet.sprite, 1, 0.08)
        Game.battle:addChild(afterimage)
        afterimage.physics.speed_x = MathUtils.random(-4, 4)
        afterimage.physics.speed_y = MathUtils.random(-4, 4)
        afterimage.physics.friction = 0.2
    end, 32)
    self.timer:after(0.05 * 32, function()
        sound:stop()
        self:spawnSwords(bullet)
    end)
end

function sword_star:spawnSwords(bullet)
    local arena = Game.battle.arena
    local cloned = {}
    for i = 1, 8 do 
        local clone = self:spawnBullet("bullets/sword", bullet.x, bullet.y)
        clone.alpha = 0.7
        bullet.layer = 9999
        clone.layer = bullet.layer - 1
        clone:setScale(2.4)
        clone.rotation = math.rad(270)
        table.insert(cloned, clone)
    end 
    local sfx = Assets.playSound("appear")
    self.timer:tween(sfx:getDuration(), arena, {width = arena.width + 100}, "out-expo")
    for num, clone in ipairs(cloned) do 
    if num % 2 == 0 then 
        local multiplier = num / 2
        local amount = multiplier * 30 
        clone:slideTo(bullet.x - amount, bullet.y, 0.6)
    else
        local multiplier = (num + 1) / 2
        local amount = multiplier * 30
        clone:slideTo(bullet.x + amount, bullet.y, 0.6)
    end 
    self:moveThemDown(bullet, cloned)
end
end 

function sword_star:moveThemDown(bullet, cloned)
    Assets.playSound("alert")
    bullet.sprite:flash(0, 0, 100, COLORS.red)
    self.timer:after(0.2, function() 
        Assets.playSound("bigcut", 0.4, 1.3)
        bullet.physics.speed_y = 14
        bullet.physics.gravity = 0.5
        Game.stage:shake(6, 6)
        for num, clone in ipairs(cloned) do 
                local tier = math.floor((num - 1) / 2) + 1       
                local delay = tier * 0.25
                local speed = 25 - (tier * 2)
                clone.sprite:flash()
                self.timer:after(delay, function()
                self.timer:after(0.008, function()
                    clone.physics.speed_y = speed
                    clone.physics.gravity = 0.4
                    Game.stage:shake()
                    Assets.playSound("bigcut", 0.8, 1.2 - (tier * 0.1)) 
                end)
            end)
        end 
        self.timer:after(3, function()
            self:setFinished(true)
        end)
    end)
end

return sword_star
