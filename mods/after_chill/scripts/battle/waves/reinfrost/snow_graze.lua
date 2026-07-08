local snow_graze, super = Class(Wave)

function snow_graze:init()
    super.init(self)
    self.time = 9
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

function snow_graze:onArenaEnter()
    for _, arena in ipairs(Game.stage:getObjects(Arena)) do 
        arena:setColor(120/255, 200/255, 240/255)
    end 
    super.onArenaEnter(self)
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
        self:alertTheSnowflakes(rx, ry, deer, index)
    end)
end

function snow_graze:alertTheSnowflakes(rx, ry, deer, index)
    if not Game.battle.soul then return end

    local soul_x = Game.battle.soul.x
    local soul_y = Game.battle.soul.y
    local base_angle = Utils.angle(rx, ry, soul_x, soul_y)
    local wave_attack_data = {}
    local active_alerts = {}
    
    Assets.playSound("alert")
    
    for i = 1, 6 do
        local spray_spread = (love.math.random() * 0.36) - 0.18
        local direction = base_angle + spray_spread
        local start_speed = love.math.random(85, 110) / 10
        local friction = 0.16
        local gravity = 0.05
        local gravity_dir = math.pi / 2   
        local sim_x = rx
        local sim_y = ry
        local sim_speed = start_speed
        local sim_speed_x = math.cos(direction) * sim_speed
        local sim_speed_y = math.sin(direction) * sim_speed
        local sim_time = 0
        local sim_dt = DT > 0 and DT or (1 / 60) 
        local sim_dtmult = DTMULT > 0 and DTMULT or 1        
        while sim_time < 1.2 do
            sim_speed_x = sim_speed_x + math.cos(gravity_dir) * gravity * sim_dtmult
            sim_speed_y = sim_speed_y + math.sin(gravity_dir) * gravity * sim_dtmult
            local current_speed = math.sqrt(sim_speed_x^2 + sim_speed_y^2)
            if current_speed > 0 then
                local new_speed = math.max(0, current_speed - friction * sim_dtmult)
                sim_speed_x = (sim_speed_x / current_speed) * new_speed
                sim_speed_y = (sim_speed_y / current_speed) * new_speed
            end
            sim_x = sim_x + sim_speed_x * sim_dtmult
            sim_y = sim_y + sim_speed_y * sim_dtmult
            
            sim_time = sim_time + sim_dt
        end
        table.insert(wave_attack_data, {
            direction = direction,
            speed = start_speed,
            friction = friction,
            gravity = gravity,
            gravity_direction = gravity_dir,
            target_scale = 1.4 - (i * 0.12)
        })
        local alert_bullet = self:spawnBullet("effects/icespell/snowflake", sim_x, sim_y)
        if alert_bullet then
            alert_bullet.damage = 0
            alert_bullet.destroy_on_hit = false
            alert_bullet.alpha = 0.35
            alert_bullet.can_graze = false       
            local mask = ColorMaskFX(COLORS.red, 1.0)
            alert_bullet:addFX(mask, "alert_mask")
            alert_bullet:setScale(1.4 - (i * 0.12))
            table.insert(active_alerts, alert_bullet)
        end
    end
    self.timer:after(0.2, function()
        for _, alert in ipairs(active_alerts) do
            if alert and alert.stage then
                alert:fadeOutAndRemove(0.2)
            end
        end
        
        self:sendSnow(rx, ry, deer, wave_attack_data)
        
        self.timer:after(1.4, function()
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



function snow_graze:sendSnow(rx, ry, deer, wave_attack_data)
    for i, data in ipairs(wave_attack_data) do
        self.timer:after((i - 1) * 0.04, function()
            local bullet = self:spawnBullet("effects/icespell/snowflake", rx, ry)
            if bullet then
                bullet:setScale(0.2)
                bullet.alpha = 0.85
                bullet.graphics.spin = math.rad(MathUtils.clamp(love.math.random(-1, 10), 1, 5))
                
                bullet.expansion_elapsed = 0
                bullet.expansion_duration = 0.65
                bullet.update = function(b)
                    b.__super.update(b)                    
                    if b.expansion_elapsed < b.expansion_duration then
                        b.expansion_elapsed = b.expansion_elapsed + DT
                        local progress = math.min(b.expansion_elapsed / b.expansion_duration, 1.0)
                        local ease = 1 - (1 - progress) * (1 - progress)
                        local current_scale = Utils.lerp(0.2, data.target_scale, ease)
                        b:setScale(current_scale)
                        b.alpha = Utils.lerp(0.85, 0.45, ease)
                    end
                end
                bullet.physics.direction = data.direction
                bullet.rotation = bullet.physics.direction
                bullet.physics.speed = data.speed
                bullet.physics.friction = data.friction            
                bullet.physics.gravity = data.gravity
                bullet.physics.gravity_direction = data.gravity_direction
                
                self.timer:after(1.2, function()
                    if bullet and bullet.stage then
                        bullet.destroy_on_hit = false    
                    end
                    self.timer:after(0.6, function()
                        if bullet and bullet.stage then
                            bullet:fadeOutAndRemove(0.2)
                        end
                    end)
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
