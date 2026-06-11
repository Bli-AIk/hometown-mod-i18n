local gallop, super = Class(Wave)

function gallop:init()
    super.init(self)
    self.time = -1 
    self:setArenaPosition(320, 230) 
    self.original_positions = {}
    self.attackers_registry = {}
end 

function gallop:checkIfMoreThanTwo()
    local enemies = self:getAttackers()
    return #enemies > 1
end 

function gallop:onStart()
    for i, enemy in ipairs(self:getAttackers()) do
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
    if self.time ~= -1 then return end

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
    local spawned_snow = false
    local arena = Game.battle.arena

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
        if deer.x >= arena_left and deer.x <= arena_right then
            if not spawned_snow then
                spawned_snow = true
                -- self:spawnSnow()
            end
        end
    end, function()
        deer:resetSprite()
        deer.visible = true
        local orig = self.original_positions[deer]
        deer:setPosition(orig.x, orig.y)
        self:triggerNextFrom(deer_index)
    end)
end

return gallop
