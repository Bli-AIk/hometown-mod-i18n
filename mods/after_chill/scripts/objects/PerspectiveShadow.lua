---@class PerspectiveShadow : Object
local PerspectiveShadow, super = Class(Object)

function PerspectiveShadow:init(parent_character, opacity, shear, scale)
    super.init(self, 0, 0)
    self.chara = parent_character
    self.opacity = 0.5
    self.shear = shear or -0.5
    self.shadow_scale = scale or 0.4
    self.layer = -1 
end

function PerspectiveShadow:draw()
    if not self.chara.sprite then return end 
    local r, g, b, a = love.graphics.getColor()

    love.graphics.push()
    local w = self.chara.sprite.width or 0
    local h = self.chara.sprite.height or 0
    local ox, oy = 0, 0
    if self.chara.sprite.getOffset then
        local offset_table = self.chara.sprite:getOffset()
        if type(offset_table) == "table" then
            ox = offset_table[1] or offset_table.x or 0
            oy = offset_table[2] or offset_table.y or 0
        end
    end
    love.graphics.translate(ox + (w / 2), oy + h)
    love.graphics.scale(1, -self.shadow_scale)
    love.graphics.shear(self.shear, 0)
    love.graphics.translate(-w / 2, -h)
    Draw.setColor(0, 0, 0, self.opacity)

    if Kristal.Shaders["AddColor"] then
        love.graphics.setShader(Kristal.Shaders["AddColor"])
        Kristal.Shaders["AddColor"]:send("inputcolor", {0, 0, 0, self.opacity})
        Kristal.Shaders["AddColor"]:send("amount", 1)
    end
    Draw.draw(self.chara.sprite.texture, 0, 0)
    love.graphics.setShader()
    love.graphics.pop()
    Draw.setColor(r, g, b, a)
    super.draw(self)
end



return PerspectiveShadow
