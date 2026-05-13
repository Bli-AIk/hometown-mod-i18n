local ShieldEffect, super = Class(Object)

function ShieldEffect:init(target, radius, time)
    self.target_radius = radius or 45
    self.duration = time or 2
    self.radius = 0
    self.alpha = 1
    super.init(self, 0, 0)
    
    self.target = target
    
    local orange = {1, 0.4, 0, 0.7} 
    local yellow = {1, 0.9, 0, 0.7}
    local segments = 64 
    local vertices = {}

    table.insert(vertices, {0, 0, 0, 0, unpack(ColorUtils.mergeColor(orange, yellow, 0.5))})
    for i = 0, segments do
        local angle = (i / segments) * math.pi * 2
        local cos_a = math.cos(angle)
        table.insert(vertices, {cos_a, math.sin(angle), 0, 0, unpack(ColorUtils.mergeColor(orange, yellow, (cos_a + 1) / 2))})
    end
    self.mesh = love.graphics.newMesh(vertices, "fan", "static")

    Game.battle.timer:tween(0.3, self, {radius = self.target_radius}, "out-back", function()
        Game.battle.timer:after(self.duration, function()
            Game.battle.timer:tween(0.3, self, {alpha = 0}, "in-back", function()
                self:remove()
            end)
        end)
    end)
end

function ShieldEffect:draw()
    love.graphics.push()
    love.graphics.scale(self.radius)
    
    love.graphics.setColor(1, 1, 1, self.alpha)
    love.graphics.draw(self.mesh)
    
    love.graphics.setLineWidth(1.2 / self.radius)
    love.graphics.setColor(0.6, 0.6, 0.6, self.alpha)
    love.graphics.circle("line", 0, 0, 1)
    
    love.graphics.pop()
    super.draw(self)
end

return ShieldEffect
