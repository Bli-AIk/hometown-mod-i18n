local flowerspin, super = Class(Wave) 

function flowerspin:init()
    super.init(self)
    self.time = 12
    self.siner = 0
    self.flower = nil
end 

function flowerspin:onStart()
    local attackers = self:getAttackers()  
    if #attackers == 0 then return end
    
    local getfrom = TableUtils.pick(attackers) 
    local sx, sy = getfrom:getRelativePos(getfrom.width/2, getfrom.height/2, Game.battle)
    
    self.flower = self:spawnBullet("peonie/flower", sx, sy, 3, 18)  
    Assets.playSound("flower")
    self.flower:slideTo(320, 53, 0.8)
    
    self.timer:after(0.4, function()
        self.timer:approach(0.4, 18, 3, function(val) 
            if self.flower and self.flower.stage then
                self.flower.spin_speed = val 
            end
        end, "out-expo")
    end)
    
    self.timer:after(0.8, function()
        self.timer:everyInstant(1.2, function() self:pulse() end)
    end)
end

function flowerspin:pulse()
    if not self.flower or not self.flower.stage then return end
    
    Assets.playSound("bomb")
    
    self:spawnFlowers()
    
    Game.battle.timer:tween(0.25, self.flower, {scale_x = 3.7, scale_y = 3.7}, "out-expo", function()
        Game.battle.timer:tween(0.25, self.flower, {scale_x = 3, scale_y = 3}, "out-expo")
    end)
end  

function flowerspin:spawnFlowers()
    if not self.flower or not self.flower.stage then return end

    local attackers = self:getAttackers()
    local count = #attackers
    local scale 
    local threshold1 
    local threshold2

    if #attackers == 1 then 
        scale = 1.5
        threshold1 = 35 
        threshold2 = 45 
    else 
        scale = 1 
        threshold1 = 30
        threshold2 = 40
    end 
    
    local spawn_count = (count == 1) and 3 or 4
    local origin_x = self.flower.x
    local origin_y = self.flower.y

    local soul = Game.battle.soul
    local base_angle = MathUtils.angle(origin_x, origin_y, soul.x, soul.y)
    local random_tilt = math.rad(love.math.random(-25, 25))
    local target_angle = base_angle + random_tilt

    for i = 1, spawn_count do
        local smallflower = self:spawnBullet("peonie/smallflower", origin_x, origin_y, scale)
        if smallflower then
            smallflower:setLayer(self.flower.layer - 0.01)
            
            local spread_index = i - ((spawn_count + 1) / 2)
            local spread_gap = love.math.random(threshold1, threshold2)
            
            local target_nx = origin_x + math.cos(target_angle) * 40 + math.cos(target_angle + math.pi/2) * (spread_index * spread_gap)
            local target_ny = origin_y + math.sin(target_angle) * 40 + math.sin(target_angle + math.pi/2) * (spread_index * spread_gap)
            
            if target_ny < 110 then
                target_ny = 110
            end           
            
            smallflower:slideTo(target_nx, target_ny, 0.2)    
            
            self.timer:after(0.2, function()
                if smallflower and smallflower.stage then
                    smallflower.start_x = smallflower.x
                    smallflower.physics.speed_y = love.math.random(2, 4)
                end
            end)
        end
    end 
end 

function flowerspin:update()
    super.update(self)
end

return flowerspin
