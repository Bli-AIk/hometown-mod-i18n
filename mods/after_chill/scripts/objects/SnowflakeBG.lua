local SnowflakeBG, super = Class(BattleBackground)

function SnowflakeBG:init()
    super.init(self)
    self.timer = 0

    local bottom_vertices = {
        {0,   480, 0, 0,  0.4, 0.7, 0.9, 0.5}, 
        {640, 480, 0, 0,  0.4, 0.7, 0.9, 0.5}, 
        {640, 320, 0, 0,  0.4, 0.7, 0.9, 0.0}, 
        {0,   320, 0, 0,  0.4, 0.7, 0.9, 0.0}, 
    }
    self.glow_mesh = love.graphics.newMesh(bottom_vertices, "fan", "static")

    for i = 1, 20 do
        self:spawnFlake(true)
    end
end

function SnowflakeBG:spawnFlake(init)
    local f = Sprite("effects/icespell/snowflake")
    f.x = love.math.random(-50, 690)
    f.y = init and love.math.random(-50, 480) or love.math.random(-100, -20)
    local scale = love.math.random(4, 10) / 10
    f:setScale(scale)
    f:setOrigin(0.5, 0.5)
    f:setColor(0.8, 0.95, 1, 0.35)
    f.physics.speed_y = love.math.random(8, 12)
    f.physics.gravity = 0.5                      -- Drastically reduced to prevent heavy plummeting
    f.physics.friction = 0.02                    -- Soft air resistance to break terminal velocity speed
    f.graphics.spin = math.abs(love.math.random(-5, 5)) / 50
    f.graphics.grow = 0.01                  -- Subtle breathing distortion on the Y axis
    f.start_x = love.math.random(0, 100)
    f.sway_speed = love.math.random(1, 3)
    f.sway_width = love.math.random(8, 15)       -- Reduced width so they swing calmly rather than rushing
    self:addChild(f)
end

function SnowflakeBG:update()
    super.update(self)
    self.timer = self.timer + DT

    for _, f in ipairs(self.children) do
        f.physics.speed_x = math.sin(self.timer * f.sway_width)

        if f.y > 500 then
            f:remove()
            self:spawnFlake(false)
        end
    end
end

function SnowflakeBG:draw()
    super.draw(self)

    love.graphics.setBlendMode("add", "alphamultiply")
    love.graphics.setColor(1, 1, 1, self.alpha)
    love.graphics.draw(self.glow_mesh, 0, -110)
    love.graphics.setBlendMode("alpha")
end

return SnowflakeBG
