---@class PerspectiveShadow : Object

local PerspectiveShadow, super = Class(Object)
---@param opacity? How light/dark should the shadows be? Defaults to `0.5`.
---@param shear? Slants the shadow at an angle. Defaults to `-0.5`. 
---@param scale? How big should the shadow be, affects scale_x and scale_y. Defaults to `1.5`. 

function PerspectiveShadow:init(data)
    super.init(self, data.x, data.y, data.w, data.h)
    self.opacity = data.properties["opacity"] or 0.5
    self.shear = data.properties["shear"] or -0.5
    self.shadow_scale = data.properties["scale"] or 1.5
end

function PerspectiveShadow:drawCharacterShadow(chara)
    if not chara.sprite then return end
    if Game.state == "BATTLE" then return end 
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
    Draw.setColor(0, 0, 0, self.opacity)
    love.graphics.setShader(Kristal.Shaders["AddColor"])
    Kristal.Shaders["AddColor"]:send("inputcolor", {0, 0, 0, self.opacity})
    Kristal.Shaders["AddColor"]:send("amount", 1)
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
