local preview = {}

preview.hide_background = true 

function preview:init(mod, button, menu)
    self.particles = {}
    self.particle_timer = 0

    self.kris = Sprite("party/kris/dark/battle/idle")
    self.ralsei = Sprite("party/ralsei/dark/battle/idle")
    self.noelle = Sprite("party/noelle/dark/battle/idle")
    self.noelle.scale_x = -1 
    self.ralsei.scale_x = -1

    self.kris:play(1/6, true)
    self.ralsei:play(1/6, true)
    self.noelle:play(1/6, true)

    button:setColor(0.6, 0.9, 1.0)
    button:setFavoritedColor(0.8, 0.8, 1)
end

function preview:update()
    local dt = DT

    local to_remove = {}
    for _,p in ipairs(self.particles) do
        p.timer = (p.timer or 0) + dt
        p.y = p.y + p.speed * dt
        p.x = p.x + math.sin(p.timer * 2) * 20 * dt
        p.rotation = p.rotation + p.spin * dt
        
        if p.y > SCREEN_HEIGHT + 20 then table.insert(to_remove, p) end
    end
    
    for _,p in ipairs(to_remove) do Utils.removeFromTable(self.particles, p) end

    self.particle_timer = self.particle_timer + dt
    if self.particle_timer >= 0.1 then
        self.particle_timer = 0
        table.insert(self.particles, {
            x = math.random(0, SCREEN_WIDTH),
            y = -20,
            timer = 0,
            size = math.random(0.4, 0.6),
            speed = math.random(60, 120),
            spin = math.random(-2, 2),
            rotation = math.random(0, 360),
            color = {0.7, 0.9, 1}
        })
    end

    if self.kris then self.kris:update(dt) end
    if self.ralsei then self.ralsei:update(dt) end
    if self.noelle then self.noelle:update(dt) end
end

function preview:draw()
    local alpha = self.fade or 0
    if alpha <= 0 then return end

    local bg_wave = Assets.getTexture("kristal/title_bg_wave")
    if bg_wave then
        love.graphics.setColor(0.6, 0.6, 0.8, alpha)
        local sx = SCREEN_WIDTH / bg_wave:getWidth()
        local sy = SCREEN_HEIGHT / bg_wave:getHeight()
        love.graphics.draw(bg_wave, 0, 0, 0, sx, sy) 
    end

    love.graphics.setBlendMode("alpha") 
    local texture = Assets.getTexture("snowflake")
    
    for _,p in ipairs(self.particles) do
        love.graphics.setColor(p.color[1], p.color[2], p.color[3], alpha * 0.5)
        if texture then
            local ox, oy = texture:getWidth()/2, texture:getHeight()/2
            love.graphics.draw(texture, p.x, p.y, p.rotation, p.size, p.size, ox, oy)
        else
            love.graphics.push()
            love.graphics.translate(p.x, p.y)
            love.graphics.rotate(p.rotation)
            local s = 10 * p.size
            love.graphics.polygon("fill", 0, -s, s, 0, 0, s, -s, 0)
            love.graphics.setColor(1, 1, 1, alpha * 0.3)
            love.graphics.setLineWidth(1)
            love.graphics.polygon("line", 0, -s, s, 0, 0, s, -s, 0)
            love.graphics.pop()
        end
    end

    love.graphics.setColor(0, 0, 0, alpha)
    local function drawSil(sprite, x, y, scale_x)
        if sprite and sprite.frames and sprite.frames[sprite.frame] then
            love.graphics.draw(sprite.frames[sprite.frame], x, y, 0, scale_x, 2)
        end
    end

    drawSil(self.kris, 140, 390, 2)   
    drawSil(self.noelle, 520, 375, -2) 
    drawSil(self.ralsei, 460, 375, -2)

    love.graphics.setColor(1, 1, 1, 1)
end

return preview
