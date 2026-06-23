local preview = {}

preview.hide_background = true 

function preview:init(mod, button, menu)
    self.particles = {}
    self.particle_timer = 0
    
    self.snow_group = Object()
    
    button:setColor(0.6, 0.9, 1.0)
    button:setFavoritedColor(0.8, 0.8, 1)
end

function preview:update()
    local dt = DT

    local target_alpha = self.fade or 0
    local is_visible = (target_alpha > 0)
    
    if self.snow_group then
        self.snow_group.visible = is_visible
        self.snow_group:update()
    end

    local to_remove = {}
    for _, p in ipairs(self.particles) do
        p.timer = (p.timer or 0) + dt
        
        p.speed_y = p.speed_y + p.gravity * dt
        p.speed_x = p.speed_x * math.exp(-p.friction * dt)
        
        local sine_wave = math.sin(p.timer * p.wave_speed + p.wave_offset)
        local drift_x = sine_wave * p.wave_amplitude * (1 - p.sprite.scale_x)
        
        local new_y = p.sprite.y + p.speed_y * dt
        local new_x = p.sprite.x + (p.speed_x + drift_x) * dt
        local new_rot = p.sprite.rotation + p.spin * dt
        
        p.sprite:setPosition(new_x, new_y)
        p.sprite.rotation = new_rot
        p.sprite.alpha = target_alpha * 0.6
        
        if new_y > SCREEN_HEIGHT + 20 or new_x < -40 or new_x > SCREEN_WIDTH + 400 then 
            table.insert(to_remove, p) 
        end
    end
    for _, p in ipairs(to_remove) do 
        p.sprite:remove() 
        Utils.removeFromTable(self.particles, p)
    end

    self.particle_timer = self.particle_timer + dt
    if self.particle_timer >= 0.04 then 
        self.particle_timer = 0
        
        local size_mult = math.random() * 0.5 + 0.5
        
        local spawn_x = math.random(-40, SCREEN_WIDTH + 350)
        local spawn_y = -40
        
        if spawn_x > SCREEN_WIDTH then
            spawn_y = math.random(-40, SCREEN_HEIGHT / 2)
        end
        
        local flake_sprite = Sprite("snowflake")
        flake_sprite:setOrigin(0.5, 0.5)
        flake_sprite:setScale(size_mult)
        flake_sprite:setPosition(spawn_x, spawn_y)
        flake_sprite:setColor(0.7, 0.9, 1)
        self.snow_group:addChild(flake_sprite)
        
        table.insert(self.particles, {
            sprite = flake_sprite,
            timer = 0,
            speed_y = math.random(140, 240) * (size_mult * 1.5),
            speed_x = math.random(-260, -140), 
            gravity = math.random(30, 60),
            friction = math.random() * 0.4 + 0.1,
            wave_speed = math.random(2, 5),
            wave_amplitude = math.random(20, 60),
            wave_offset = math.random() * math.pi * 2,
            spin = math.random(-2, 2) * (1 - size_mult)
        })
    end
end

function preview:draw()
    local alpha = self.fade or 0
    if alpha <= 0 then return end
    
    local bg_wave = Assets.getTexture("kristal/title_bg_wave")
    if bg_wave then
        Draw.setColor(0.6, 0.6, 0.8, alpha)
        local sx = SCREEN_WIDTH / bg_wave:getWidth()
        local sy = SCREEN_HEIGHT / bg_wave:getHeight()
        Draw.draw(bg_wave, 0, 0, 0, sx, sy) 
    end
    
    if self.snow_group and self.snow_group.visible then
        self.snow_group:draw()
    end
    
    Draw.setColor(0, 0, 0, alpha)
    Draw.setColor(1, 1, 1, 1)
end

return preview
