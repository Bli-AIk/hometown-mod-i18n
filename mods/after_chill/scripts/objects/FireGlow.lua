local FireGlow, super = Class(BattleBackground)

function FireGlow:init()
    super.init(self)

    self.timer = 0

    local top_vertices = {
        {0,   0,   0, 0,  1, 0.4, 0, 0.8},
        {640, 0,   0, 0,  1, 0.4, 0, 0.8},
        {640, 200, 0, 0,  1, 0.2, 0, 0.0},
        {0,   200, 0, 0,  1, 0.2, 0, 0.0},
    }
    self.top_mesh = love.graphics.newMesh(top_vertices, "fan", "static")

    local bottom_vertices = {
        {0,   480, 0, 0,  1, 0.4, 0, 0.8}, 
        {640, 480, 0, 0,  1, 0.4, 0, 0.8}, 
        {640, 200, 0, 0,  1, 0.2, 0, 0.0}, 
        {0,   200, 0, 0,  1, 0.2, 0, 0.0}, 
    } 
    self.bottom_mesh = love.graphics.newMesh(bottom_vertices, "fan", "static")

    self.particles = {}
    
    for i = 1, 10 do
        local p = {side = love.math.random(1, 2), is_circle = true}
        self:resetParticle(p)
        p.y = p.y + (p.side == 1 and love.math.random(0, 80) or -love.math.random(0, 80))
        table.insert(self.particles, p)
    end

    for i = 1, 30 do
        local p = {side = love.math.random(1, 2), is_circle = false}
        self:resetParticle(p)
        p.y = p.y + (p.side == 1 and love.math.random(0, 50) or -love.math.random(0, 50))
        table.insert(self.particles, p)
    end
end

function FireGlow:resetParticle(p)
    p.x = love.math.random(0, 640)
    if p.side == 1 then
        p.y = love.math.random(-10, 10)
    else
        p.y = love.math.random(320, 340)
    end
    p.start_y = p.y
    
    if p.is_circle then
        p.radius = love.math.random(6, 12)  
        p.speed = love.math.random(20, 50)   
        p.max_dist = 100
    else
        p.size = 2                          
        p.speed = love.math.random(50, 100) 
        p.max_dist = love.math.random(70, 90)
    end
end

function FireGlow:update()
    super.update(self)
    
    self.timer = self.timer + DT

    for _, p in ipairs(self.particles) do
        local sway_speed = p.is_circle and 3 or 5
        local sway_width = p.is_circle and 8 or 16
        p.x = p.x + math.sin(self.timer * sway_speed + p.start_y) * sway_width * DT

        if p.side == 1 then
            p.y = p.y + (p.speed * DT)
            if (p.y - p.start_y) >= p.max_dist then self:resetParticle(p) end
        else
            p.y = p.y - (p.speed * DT)
            if (p.start_y - p.y) >= p.max_dist then self:resetParticle(p) end
        end
    end
end

function FireGlow:draw()
    super.draw(self)
    love.graphics.setColor(1, 1, 1, self.alpha)
    love.graphics.draw(self.top_mesh, 0, -90)
    love.graphics.draw(self.bottom_mesh, 0, 0)

    for _, p in ipairs(self.particles) do
        local distance_traveled = math.abs(p.y - p.start_y)
        
        if distance_traveled < p.max_dist then
            local fade = math.max(0, 1 - (distance_traveled / p.max_dist))
            local color_shift = 0.2 + math.sin(self.timer * 10 + p.x) * 0.2
            
            if p.is_circle then
                local alpha_mod = (0.3 + math.sin(self.timer * 4 + p.x) * 0.3) * fade * self.alpha
                love.graphics.setColor(1, 0.4, 0, alpha_mod)
                love.graphics.circle("fill", p.x, p.y, p.radius)
            else
                local pixel_alpha = fade * self.alpha
                love.graphics.setColor(1, 0.6 - color_shift, 0.05, pixel_alpha)
                love.graphics.rectangle("fill", p.x, p.y, p.size, p.size)
            end
        end
    end

    love.graphics.setColor(1, 1, 1, 1)
end

return FireGlow
