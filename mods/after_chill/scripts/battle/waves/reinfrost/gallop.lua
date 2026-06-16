local gallop, super = Class(Wave)

function gallop:init()
    super.init(self)
    self.time = -1 
    self:setArenaPosition(320, 230) 
    self.original_positions = {}
    self.attackers_registry = {}  
    self.run_count = 0
    self.max_runs = 3
    self.snow_count = 0
    self.last_speed_x = 0
end 

function gallop:checkIfMoreThanTwo()
    local enemies = self:getAttackers()
    return #enemies > 1
end 

function gallop:onStart()
    local attackers = self:getAttackers()
    for i, enemy in ipairs(attackers) do
        self.attackers_registry[i] = enemy
        self.original_positions[enemy] = {x = enemy.x, y = enemy.y}
    end

    self:sendFirst()
end 

function gallop:isEnemyAlive(index)
    local target = self.attackers_registry[index]
    if not target then return false end
    for _, enemy in ipairs(self:getAttackers()) do
        if enemy == target then
            return true
        end
    end
    return false
end

function gallop:triggerNextFrom(currentIndex)
    if self.run_count >= self.max_runs then
        return
    end
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

function gallop:sendFirst()
    local deer = self.attackers_registry[1]
    if not self:isEnemyAlive(1) then 
        self:triggerNextFrom(1)
        return 
    end   
    local target_y = Game.battle.arena:getTop() - 50
    self:executeGallopRun(deer, 1, target_y)
end 

function gallop:sendSecond()
    local deer = self.attackers_registry[2]
    if not self:isEnemyAlive(2) then 
        self:triggerNextFrom(2)
        return 
    end   
    local target_y = Game.battle.arena:getTop() - 50
    self:executeGallopRun(deer, 2, target_y)
end 

function gallop:sendThird()
    local deer = self.attackers_registry[3]
    if not self:isEnemyAlive(3) then 
        self:triggerNextFrom(3)
        return 
    end
    
    local target_y = Game.battle.arena:getTop() - 50
    self:executeGallopRun(deer, 3, target_y)
end

function gallop:executeGallopRun(deer, deer_index, target_y)
    deer.visible = true
    deer:setAnimation("gallop")
    deer.alpha = 0
    
    local orig = self.original_positions[deer]
    local sx, sy = orig.x, orig.y
    local tx = -100
    
    local duration = 2.8
    local elapsed = 0
    local arena = Game.battle.arena
    local snow_cooldown = 0
    deer:fadeTo(1, 0.2)
    self.timer:during(duration, function()
        elapsed = elapsed + DT
        local p = math.min(elapsed / duration, 1.0)
        
        deer.x = Utils.lerp(sx, tx, p)
        
        local y_progress = math.min(p / 0.35, 1.0) 
        local y_ease = Utils.ease(0, 1, y_progress, "out-cubic")
        local base_y = Utils.lerp(sy, target_y, y_ease)
        
        local wave_fade = math.sin(p * math.pi)
        local frequency = 4.0
        local amplitude = 25
        local sine_offset = math.sin(p * math.pi * 2.0 * frequency) * amplitude * wave_fade
        
        deer.y = base_y - sine_offset
        
        local arena_left = arena.x - (arena.width / 2)
        local arena_right = arena.x + (arena.width / 2)
        
        if deer.x >= (arena_left - 40) and deer.x <= (arena_right + 20) then
            snow_cooldown = snow_cooldown - DT
            if snow_cooldown <= 0 then
                self:spawnSnow(deer)
                snow_cooldown = 0.09
            end
        end
    end, function()
        deer:resetSprite()
        deer.visible = true
        local orig = self.original_positions[deer]
        deer:setPosition(orig.x, orig.y)
        
        self.run_count = self.run_count + 1
        
        if self.run_count >= self.max_runs then
            self:setFinished(true)
        else
            self:triggerNextFrom(deer_index)
        end
    end)
end

function gallop:spawnSnow(deer)
    self.snow_count = self.snow_count + 1
    if self.snow_count % 6 == 0 then
        return
    end
    
    local rx, ry = deer:getRelativePos(deer.width, deer.height)
    local bullet = self:spawnBullet("bullets/puff", rx, ry)
    bullet.collider = CircleCollider(bullet, 8, 8, 8.5)
    
    if bullet then
        bullet:setScale(1)
        bullet.alpha = 0.7 
        bullet.graphics.spin = 0.2
        bullet.physics.gravity = 0.16
        if self.snow_count % 3 == 0 then
            bullet.physics.speed_y = 5.5 
            bullet.physics.speed_x = love.math.random(-3.0, -1.0)
        elseif self.snow_count % 3 == 1 then
            bullet.physics.speed_y = love.math.random(2.0, 4.0)
            bullet.physics.speed_x = love.math.random(-1.0, 1.0) 
        else
            bullet.physics.speed_y = 4.0 
            bullet.physics.speed_x = love.math.random(1.5, 3.5) 
        end
    end
end

function gallop:beforeEnd()
    for _, deer in ipairs(self:getAttackers()) do
        local orig = self.original_positions[deer]
        deer:resetSprite()
        deer:setPosition(orig.x, orig.y)
    end 
end 

return gallop
