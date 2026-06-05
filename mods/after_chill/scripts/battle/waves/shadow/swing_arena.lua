local swing_arena, super = Class(Wave)

function swing_arena:init()
    super.init(self)
    self.time = -1 
    self.arenas = {}
    self.cycles = 0 
    self.max_cycles = 8
    self.duration = 0.1
    self.anim = nil
end

function swing_arena:onStart()
    self.orig_width = Game.battle.arena.width
    self.orig_height = Game.battle.arena.height
    local shadow = self:getAttackers()[1]
    self:moveShadow(shadow)
end 

function swing_arena:moveShadow(shadow)
    self.timer:tween(0.5, shadow, {alpha = 0}, "linear", function()
        self.timer:tween(0.5, shadow, {alpha = 1}, "linear", function()
             shadow:setLayer(BATTLE_LAYERS["above_ui"])
             self:swing(shadow)
        end) 
    end)
end 

function swing_arena:swing(shadow)
    self.cycles = self.cycles + 1 
    if self.cycles >= self.max_cycles then 
        self:setFinished(true)
    else 
    local options = {"horizontal", "vertical"}
    local hv = TableUtils.pick(options)
    if hv == "horizontal" then 
        self.anim = "swing"
    else 
        self.duration = self.duration + 0.2
        self.anim = "battle/attack"
    end
    shadow:setAnimation(self.anim, function()
        self.timer:after(0.2, function()
            shadow:shake(2)
            shadow:resetSprite()
        end)
    end)
    if self.anim == "swing" then 
    shadow.sprite:setFrame(3)
    end 
    
    self.timer:after(0.1, function()
        if self.anim == "swing" then 
        Assets.playSound("scytheburst", 0.8, 1.4)
        else 
        Assets.playSound("laz_c", 0.8, 1.1)
        end 
        self.timer:after(self.duration, function()
            self:drawLineToSplit(hv, 320, 172)
        end)
    end)
end 
end 

function swing_arena:drawLineToSplit(hv, rx, ry)
    if hv == "horizontal" then 
        local length = Game.battle.arena.width + 48
        local rect = Rectangle(rx - length/2, ry - 3.5, length, 7)
        rect:setColor(COLORS.white)
        Game.battle:addChild(rect)
        rect.layer = 9999
        rect.alpha = 0 
        rect.height = 0    
        local snd = Assets.playSound("flower", 0.6, 2)
        self.timer:tween(0.3, rect, {alpha = 1, height = 7}, "out-cubic", function()
            self:startSplit(hv, rect)
        end)
    else 
        local length = Game.battle.arena.height + 48
        local rect = Rectangle(rx - 3.5, ry - length/2, 7, length)
        rect:setColor(COLORS.white)
        Game.battle:addChild(rect)
        rect.layer = 9999
        rect.alpha = 0 
        rect.width = 0
        
        local snd = Assets.playSound("flower", 0.6, 2)
        self.timer:tween(0.3, rect, {alpha = 1, width = 7}, "out-cubic", function()
            self:startSplit(hv, rect)
        end)
    end 
end 

function swing_arena:startSplit(hv, rect)
    rect:fadeOutAndRemove(0.2)
    self.timer:after(0.1, function()
        local amount = TableUtils.pick({7, 9})
        self:spawnStars(hv, amount)
        
        local arena = Game.battle.arena
        Game.stage:shake(4, 4) 
        
        if hv == "horizontal" then
            arena:setSize(arena.width, arena.height / 2)
            self.timer:tween(0.5, arena, {y = arena.y - 75}, "out-expo")
        else
            arena:setSize(arena.width / 2, arena.height)
            self.timer:tween(0.5, arena, {x = arena.x - 75}, "out-expo")
        end    
        self:spawnArenaDir(hv)
    end)
end

function swing_arena:spawnArenaDir(dir)
    local main_arena = Game.battle.arena
    local arena2 = Arena()
    table.insert(self.arenas, arena2)
    
    arena2.onAdd = function()
        arena2.sprite:setScale(1)
        arena2.sprite.alpha = 1
    end
    arena2.onRemove = function()
        arena2.sprite:remove()
    end
    local target_x = 320
    local target_y = 172

    if dir == "horizontal" then 
        arena2.width = self.orig_width
        arena2.height = self.orig_height / 2
        arena2:setPosition(target_x, target_y)
        Game.battle:addChild(arena2) 
        self.timer:tween(0.5, arena2, {y = arena2.y + 75}, "out-expo")
    else 
        arena2.width = self.orig_width / 2
        arena2.height = self.orig_height
        arena2:setPosition(target_x, target_y) 
        Game.battle:addChild(arena2)    
        self.timer:tween(0.5, arena2, {x = arena2.x + 75}, "out-expo")
    end 
    
    arena2.motion = true
    self:callWait(1.4, main_arena, arena2, dir)
end 

function swing_arena:spawnStars(hv, amount)
    local arena = Game.battle.arena
    if amount % 2 ~= 0 then amount = amount + 1 end 
    local direction_toggle = love.math.random(1, 2)  
    
    if hv == "horizontal" then 
        local left_bound = arena:getLeft()
        local right_bound = arena:getRight()
        local arena_width = right_bound - left_bound
        local spacing = arena_width / (amount + 1)
        
        for i = 1, amount do 
            local bullet = self:spawnBullet("effects/criticalswing/sparkle")
            bullet.sprite:play(0.1, true)
            bullet:setScale(1.3)
            bullet:addFX(ColorMaskFX(COLORS.black))
            bullet:addFX(OutlineFX())
            bullet.destroy_on_hit = true 
            local x_fuzz = love.math.random(-4, 4)
            bullet.x = left_bound + (i * spacing) + x_fuzz
            bullet.y = 172 + love.math.random(-6, 6)   
            bullet.alpha = 0 
            Assets.playSound("bell_bounce_short", 0.6, 1.2)
            Game.battle.timer:tween(0.2, bullet, {alpha = 1}, "in-cubic", function()
                bullet.graphics.spin = 0.3  
                local random_speed = love.math.random(-2, 2)
                if direction_toggle == 1 then
                    bullet.physics.speed_y = random_speed
                    bullet.physics.gravity = 0.4
                    direction_toggle = 2 
                else
                    bullet.physics.speed_y = -random_speed
                    bullet.physics.gravity = -0.4
                    direction_toggle = 1 
                end  
            end)
        end 
    else
        local top_bound = arena:getTop()
        local bottom_bound = arena:getBottom()
        local arena_height = bottom_bound - top_bound
        local spacing = arena_height / (amount + 1)
        
        for i = 1, amount do 
            local bullet = self:spawnBullet("effects/criticalswing/sparkle")
            bullet.sprite:play(0.1, true)
            bullet:setScale(1.3)
            bullet:addFX(ColorMaskFX(COLORS.black))
            bullet:addFX(OutlineFX())
            bullet.destroy_on_hit = true 
            local y_fuzz = love.math.random(-4, 4)
            bullet.x = 320 + love.math.random(-6, 6)
            bullet.y = top_bound + (i * spacing) + y_fuzz    
            bullet.alpha = 0 
            Assets.playSound("bell_bounce_short", 1, 1.2)
            self.timer:tween(0.2, bullet, {alpha = 1}, "in-cubic", function()
                bullet.graphics.spin = 0.3            
                local random_speed = love.math.random(-2, 2)
                if direction_toggle == 1 then
                    bullet.physics.speed_x = random_speed
                    bullet.physics.gravity = 0.4 
                    bullet.physics.gravity_direction = 0
                    direction_toggle = 2 
                else
                    bullet.physics.speed_x = -random_speed
                    bullet.physics.gravity = 0.4
                    bullet.physics.gravity_direction = math.pi
                    direction_toggle = 1 
                end  
            end)
        end
    end 
end  



function swing_arena:callWait(time, arena, arena2, dir)
    if time then  
        self.timer:after(time, function()
             self:combine(arena, arena2, dir)
        end)
    end 
end 

function swing_arena:combine(fir, sec, dir)
    local target_x = 320
    local target_y = 172
    fir.visible = false 
    
    local third = Arena(fir.x, fir.y)
    third.width = fir.width 
    third.height = fir.height 
    third.onAdd = function()
        third.sprite:setScale(1)
        third.sprite.alpha = 1
    end
    third.onRemove = function()
        third.sprite:remove()
    end
    table.insert(self.arenas, third)
    Game.battle:addChild(third)
    
    if dir == "horizontal" then
        local half_height = fir.height
        self.timer:tween(0.5, third, {y = target_y - half_height/2}, "in-cubic")
        self.timer:tween(0.5, sec, {y = target_y + half_height/2}, "in-cubic", function()
            self:finalizeCombine(target_x, target_y)
        end)
    else
        local half_width = fir.width
        self.timer:tween(0.5, third, {x = target_x - half_width/2}, "in-cubic")
        self.timer:tween(0.5, sec, {x = target_x + half_width/2}, "in-cubic", function()
            self:finalizeCombine(target_x, target_y)
        end)
    end
end

function swing_arena:finalizeCombine(target_x, target_y)
    Assets.playSound("impact", 1, love.math.random(90, 110) / 100)
    Game.stage:shake(4)
    
    for _, arena in ipairs(self.arenas) do 
        if arena then arena:remove() end
    end 
    self.arenas = {} 
    local main_arena = Game.battle.arena
    main_arena:setSize(self.orig_width, self.orig_height)    
    main_arena:setPosition(target_x, target_y)
    main_arena.visible = true
    local shadow = self:getAttackers()[1]
    if shadow then
        self.duration = 0.1
        self:swing(shadow)
    end
end

function swing_arena:beforeEnd()
    for _, arena in ipairs(self.arenas) do 
        arena:remove()
    end 
    local shadow = Game.battle:getEnemyBattler("shadow")
    Game.battle.timer:tween(0.5, shadow, {alpha = 0}, "linear", function()
       shadow:setLayer(-100)
       shadow:resetSprite()
       shadow:setPosition(516, 292)
       Game.battle.timer:tween(0.5, shadow, {alpha = 1})
    end)
end 

return swing_arena
