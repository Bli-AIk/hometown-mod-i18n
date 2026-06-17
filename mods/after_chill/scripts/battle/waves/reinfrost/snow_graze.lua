local snow_graze, super = Class(Wave)

function snow_graze:init()
    super.init(self)
    self.time = 13
    self.original_positions = {}
    self.attackers_registry = {}  
    self.run_count = 0
    self.max_runs = math.huge
    self.snow_count = 0
    self.last_speed_x = 0
end 

function snow_graze:checkIfMoreThanTwo()
    local enemies = self:getAttackers()
    return #enemies > 1
end 

function snow_graze:onStart()
    local attackers = self:getAttackers()
    for i, enemy in ipairs(attackers) do
        self.attackers_registry[i] = enemy
        self.original_positions[enemy] = {x = enemy.x, y = enemy.y}
    end
    self:sendFirst()
end

function snow_graze:isEnemyAlive(index)
    local target = self.attackers_registry[index]
    if not target then return false end
    for _, enemy in ipairs(self:getAttackers()) do
        if enemy == target then
            return true
        end
    end
    return false
end

function snow_graze:sendFirst()
    if not self:isEnemyAlive(1) then 
        self:triggerNextFrom(1)
        return 
    end   
    local deer = self.attackers_registry[1]
    self:executeGrazeAction(deer, 1)
end 

function snow_graze:sendSecond()
    if not self:isEnemyAlive(2) then 
        self:triggerNextFrom(2)
        return 
    end   
    local deer = self.attackers_registry[2]
    self:executeGrazeAction(deer, 2)
end 

function snow_graze:sendThird()
    if not self:isEnemyAlive(3) then 
        self:triggerNextFrom(3)
        return 
    end   
    local deer = self.attackers_registry[3]
    self:executeGrazeAction(deer, 3)
end

function snow_graze:executeGrazeAction(deer, index)
    self.timer:afterCond(function()
        return deer.sprite.frame == 2 
    end, function()
        local rx, ry = deer:getRelativePos(0, deer.height)
        self:sendSnow(rx, ry, deer)
        self.timer:after(1.2, function()
            deer:resetSprite()
            self.run_count = self.run_count + 1
            if self.run_count >= self.max_runs then
                self:setFinished(true)
            else
                self.timer:after(0.2, function()
                    self:triggerNextFrom(index)
                end)
            end
        end)
    end)
end

function snow_graze:sendSnow(rx, ry, deer)
    if not Game.battle.soul then return end
    
    local soul_x = Game.battle.soul.x
    local soul_y = Game.battle.soul.y
    local base_angle = Utils.angle(rx, ry, soul_x, soul_y)
    
    for i = 1, 6 do
        self.timer:after((i - 1) * 0.04, function()
            local bullet = self:spawnBullet("effects/icespell/snowflake", rx, ry)
            if bullet then
                bullet:setScale(0.2)
                bullet.alpha = 0.85
                bullet.graphics.spin = math.rad(MathUtils.clamp(love.math.random(-1, 10), 1, 5))
                local start_scale = 0.2
                local target_scale = 1.6 - (i * 0.12)           
                bullet.expansion_elapsed = 0
                bullet.expansion_duration = 0.65
                bullet.update = function(b)
                    b.__super.update(b)                    
                    if b.expansion_elapsed < b.expansion_duration then
                        b.expansion_elapsed = b.expansion_elapsed + DT
                        local progress = math.min(b.expansion_elapsed / b.expansion_duration, 1.0)
                        local ease = 1 - (1 - progress) * (1 - progress)
                        local current_scale = Utils.lerp(start_scale, target_scale, ease)
                        b:setScale(current_scale)
                        b.alpha = Utils.lerp(0.85, 0.45, ease)
                    end
                end
                local spray_spread = (love.math.random() * 0.36) - 0.18
                bullet.physics.direction = base_angle + spray_spread
                bullet.rotation = bullet.physics.direction
                bullet.physics.speed = love.math.random(85, 110) / 10
                bullet.physics.friction = 0.16 
                
                bullet.physics.gravity = 0.05
                bullet.physics.gravity_direction = math.pi / 2
                self.timer:after(1.8, function()
                    if bullet and bullet.stage then
                        bullet:fadeOutAndRemove(0.2)
                    end
                end)
            end
        end)
    end 
end 

function snow_graze:triggerNextFrom(currentIndex)
    if currentIndex == 1 then
        if self:isEnemyAlive(2) then
            self:sendSecond()
        elseif self:isEnemyAlive(3) then
            self:sendThird()
        elseif self:isEnemyAlive(1) then
            self:sendFirst()
        end
    elseif currentIndex == 2 then
        if self:isEnemyAlive(3) then
            self:sendThird()
        elseif self:isEnemyAlive(1) then
            self:sendFirst()
        elseif self:isEnemyAlive(2) then
            self:sendSecond()
        end
    elseif currentIndex == 3 then
        if self:isEnemyAlive(1) then
            self:sendFirst()
        elseif self:isEnemyAlive(2) then
            self:sendSecond()
        elseif self:isEnemyAlive(3) then
            self:sendThird()
        end
    end
end

function snow_graze:beforeEnd()
    for _, deer in ipairs(self:getAttackers()) do
        local orig = self.original_positions[deer]
        deer:resetSprite()
        deer:setPosition(orig.x, orig.y)
    end 
end 

return snow_graze
