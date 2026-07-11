---@class PerspectiveShadow : Object
local PerspectiveShadow, super = Class(Object)

function PerspectiveShadow:init(data)
    super.init(self, data.x, data.y, data.w, data.h)

    local properties = data.properties or {}
    
    self.opacity = properties["opacity"] or 0.55
    self.shear = properties["shear"] or -0.5
    self.shadow_scale = properties["scale"] or 1.5
    self.layer = -1 
end

function PerspectiveShadow:drawCharacterShadow(chara)
    if not chara.sprite then return end

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
    love.graphics.translate(rel_x, rel_y - 2)

    love.graphics.scale(self.shadow_scale, -self.shadow_scale)
    love.graphics.shear(self.shear, 0)
    love.graphics.translate(-w / 2, -h)

    if Kristal.Shaders["AddColor"] then
        love.graphics.setShader(Kristal.Shaders["AddColor"])
        Kristal.Shaders["AddColor"]:send("inputcolor", {0, 0, 0, self.opacity})
        Kristal.Shaders["AddColor"]:send("amount", 1)
    end

    Draw.draw(chara.sprite.texture, 0, 0)
    love.graphics.setShader()

    love.graphics.pop()
end

function PerspectiveShadow:draw()
    local r, g, b, a = love.graphics.getColor()
    Draw.setColor(0, 0, 0, self.opacity)
    
    for _, party_chara in ipairs(Game.party) do
        local chara_obj = Game.world:getPartyCharacter(party_chara)
        if chara_obj then
            self:drawCharacterShadow(chara_obj)
        end
    end

    Draw.setColor(r, g, b, a)
    super.draw(self)
end

return PerspectiveShadow
