local solar_vacuum_bullet, super = Class("DarkBullet")

function solar_vacuum_bullet:init(x, y)
    super.init(self, x, y, "bullets/fire")
    self:setHitbox(0, 0, 10, 12)
    self:addFX(ColorMaskFX({0.4, 0.6, 1.0}, 0.4))
    
    self.destroy_on_hit = true
    self.remove_offscreen = false 
    self.graphics.spin = 0.1
    self.trail_timer = 0
    
    self.base_speed = 5.2
    self.physics.speed = self.base_speed
    
    -- 🌌 Start with the center coordinates as a baseline destination
    self.target_x = SCREEN_WIDTH / 2
    self.target_y = SCREEN_HEIGHT / 2
    
    self.initialized_direction = false
end

function solar_vacuum_bullet:update()
    super.update(self)
    
    self.trail_timer = self.trail_timer + DT
    if self.trail_timer >= 0.04 then
        local trail = AfterImage(self, 0.4, 0.08)
        trail:setColor(0.2, 0.6, 1) 
        trail.layer = self.layer - 1 
        Game.battle:addChild(trail)
        self.trail_timer = 0
    end

    local soul = Game.battle.soul
    if soul then
        -- 🎯 1. THE INITIAL LANE ACQUISITION: Launch straight down the player's track
        if not self.initialized_direction then
            self.initialized_direction = true
            self.physics.direction = MathUtils.angle(self.x, self.y, soul.x, soul.y)
        end
        
        -- 🧠 2. THE MOVING VORTEX SEED:
        -- Instead of pulling toward the rigid screen center, the gravity destination
        -- slowly interpolates (drifts) toward the player's active SOUL positions!
        self.target_x = self.target_x + (soul.x - self.target_x) * (1.5 * DT)
        self.target_y = self.target_y + (soul.y - self.target_y) * (1.5 * DT)
        
        local current_vx = math.cos(self.physics.direction) * self.physics.speed
        local current_vy = math.sin(self.physics.direction) * self.physics.speed
        
        -- Pull toward our fluid, moving destination target map
        local angle_to_core = MathUtils.angle(self.x, self.y, self.target_x, self.target_y)
        local target_vx = math.cos(angle_to_core) * self.base_speed
        local target_vy = math.sin(angle_to_core) * self.base_speed
        
        local turn_speed = 2.5
        local new_vx = current_vx + (target_vx - current_vx) * (turn_speed * DT)
        local new_vy = current_vy + (target_vy - current_vy) * (turn_speed * DT)
        
        self.physics.speed = self.base_speed
        self.physics.direction = math.atan2(new_vy, new_vx)
    end

    -- Clean up if it touches its active target tracking bounds
    local distance_to_core = MathUtils.dist(self.x, self.y, self.target_x, self.target_y)
    if distance_to_core <= 25 then
        self:remove()
    end
end

return solar_vacuum_bullet
