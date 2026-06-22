local warning_line, super = Class(WorldBullet)

function warning_line:init(x, y, width, height, is_even)
    super.init(self, x, y)
    self.width = width
    self.height = height
    self.is_even = is_even or false
    
    self.rotation = math.rad(-30) 
    
    self.rect = Rectangle(0, 0, width, height)
    self.rect:setColor(238/255, 210/255, 2/255)
    self.rect.alpha = 0.15 
    self.rect:setOrigin(0.5, 0.0)
    self:addChild(self.rect) 
    
    self.dmg = 40
    self.damage = 0 
    
    local rhythm_time = 1.4
    
    -- FIX: Changed initial stagger so odd lanes wait 0.4s to warn you, and even lanes wait 1.1s!
    local initial_stagger = self.is_even and (rhythm_time / 2 + 0.4) or 0.4
    
    -- PRE-FLASH CONPRO: Visually brighten the line slightly early to alert the player
    Game.world.timer:after(initial_stagger - 0.2, function()
        if not self.parent then return end
        Game.world.timer:tween(0.15, self.rect, {alpha = 0.4})
    end)
    
    Game.world.timer:after(initial_stagger, function()
        if not self.parent then return end
        self:executeConveyorLoop(rhythm_time)
    end)
end 

function warning_line:executeConveyorLoop(time)
    self:pulseAndHit(function()
        local animation_duration = 0.5
        local rest_break = math.max(0, time - animation_duration)
        
        Game.world.timer:after(rest_break, function()
            if not self.parent then return end
            self:executeConveyorLoop(time)
        end)
    end)
end

function warning_line:pulseAndHit(on_complete)
    self.rect.scale_x = 1.0
    self.rect.alpha = 1.0
    self:setHitbox(-(self.width * 1.3)/2, 0, self.width * 1.3, self.height)
    self.damage = self.dmg
    
    Game.world.timer:tween(0.25, self.rect, {alpha = 0.7, scale_x = 1.3}, "out-quad", function()
        if not self.parent then return end
        
        self.damage = 0 
        self:setHitbox(0, 0, 0, 0)
        
        Game.world.timer:tween(0.25, self.rect, {alpha = 0.15, scale_x = 1.0}, "out-quad", function()
            if not self.parent then return end
            if on_complete then on_complete() end
        end)
    end)
end

return warning_line
