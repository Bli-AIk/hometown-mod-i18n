local fire_spin, super = Class(Wave)

function fire_spin:onStart()
    self.time = 9
    self.fire_timer = 0
    self.fire_interval = 0.8
    self.fireballs = {}
    self.ralsei = self:getAttackers()[1] 
    self:spawnNewFireballs()
end

function fire_spin:update()
    super.update(self)
    TableUtils.filterInPlace(self.fireballs, function(fb)
        return fb.stage ~= nil and fb.state ~= "DONE"
    end)

    local rotating_count = 0
    for _, fb in ipairs(self.fireballs) do
        if fb.state == "ROTATE" then rotating_count = rotating_count + 1 end
    end

    self.fire_timer = self.fire_timer + DT
    if self.fire_timer >= self.fire_interval and rotating_count > 0 then
        self.fire_timer = 0
        
        for _, fb in ipairs(self.fireballs) do
            if fb.state == "ROTATE" then
                fb:fireAtSoul()
                if self.ralsei then self.ralsei:setAnimation("spell") end
                break 
            end
        end
    end

    if rotating_count == 0 and not self.spawning then
        self:spawnNewFireballs()
    end
end

function fire_spin:spawnNewFireballs()
    self.spawning = true
    
    if self.ralsei then          
        local fx = self.ralsei:addFX(ColorMaskFX(COLORS.white, 1))
        self.timer:tween(0.4, fx, {amount = 0})
        Assets.playSound("boost")
    end

    self.timer:after(0.3, function()
        local rx, ry = self.ralsei:getRelativePos(self.ralsei.width/2, self.ralsei.height/2)  
        ry = ry + 40 
        rx = rx - 15 
        
        for i = 1, 4 do
            local start_angle = (math.pi * 2 / 4) * i
            
            local fb = self:spawnBullet("fireball", rx, ry - 40)
            if fb then
                fb.alpha = 0 
                fb:fadeTo(1, 0.3)
                
                fb.center_x = rx
                fb.center_y = ry - 40
                fb.angle = start_angle
                fb.radius = 60
                fb.state = "ROTATE"
                
                table.insert(self.fireballs, fb)
            end
        end

        self.timer:after(0.6, function()
            self.spawning = false
        end)
    end)
end 

return fire_spin
