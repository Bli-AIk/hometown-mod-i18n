local ThunderTint, super = Class(Object)

function ThunderTint:init()
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    self:setLayer(WORLD_LAYERS["above_ui"] or 1000)
end

function ThunderTint:draw()
    super.draw(self)  
    local darker = 70
    Draw.setColor((99 - darker)/255, (99 - darker)/255, (110 - darker)/255, (150/255) * self.alpha)
    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
end


return ThunderTint