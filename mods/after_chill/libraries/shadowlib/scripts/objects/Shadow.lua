---@class Shadow : Object
local Shadow, super = Class(Object) -- this is just an Object that can be added whenever.

function Shadow:init(options)
    super.init(self, 0, 0)
    options = options or {}
    self.opacity = options.opacity or 0.5
    self.shear = options.shear or -0.5
    self.shadow_scale = options.scale or 1
end

function Shadow:draw()
    local chara = self.parent
    if not chara.sprite then return end

    local r, g, b, a = love.graphics.getColor()

    love.graphics.push()

    local w = chara.sprite.width or 0
    local h = chara.sprite.height or 0
    local ox, oy = 0, 0
    if chara.sprite.getOffset then
        local offset_table = chara.sprite:getOffset()
        if type(offset_table) == "table" then
            ox = offset_table[1] or offset_table.x or 0
            oy = offset_table[2] or offset_table.y or 0
        end
    end
    local rel_x, rel_y = chara:getRelativePos(ox + (w / 2), oy + h, self)
    love.graphics.translate(rel_x, rel_y)
    love.graphics.scale(self.shadow_scale, -self.shadow_scale)
    love.graphics.shear(self.shear, 0)
    love.graphics.translate(-w / 2, -h)
    Draw.setColor(0, 0, 0, self.opacity)
    love.graphics.setShader(Kristal.Shaders["AddColor"])
    Kristal.Shaders["AddColor"]:send("inputcolor", {0, 0, 0, self.opacity})
    Kristal.Shaders["AddColor"]:send("amount", 1)
    Draw.draw(chara.sprite.texture, 0, 0)
    love.graphics.setShader()
    love.graphics.pop()
    Draw.setColor(r, g, b, a)
    super.draw(self)
end

return Shadow
