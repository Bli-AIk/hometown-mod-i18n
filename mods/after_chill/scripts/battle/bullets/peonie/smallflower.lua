---@class smallflower : Bullet
local smallflower, super = Class(Bullet)

function smallflower:init(x, y, scale)
    super.init(self, x, y, "bullets/flower")
    self:setOrigin(0.5, 0.5)
    self:setScale(scale)
    self.siner = 0
    self.start_x = self.x
    self.sway_speed = speed or 4 
    self.sway_width = 0.5
end

function smallflower:update()
    self.siner = self.siner + DT
    self.rotation = math.sin(self.siner * self.sway_speed) * self.sway_width    
    super.update(self)
end

return smallflower
