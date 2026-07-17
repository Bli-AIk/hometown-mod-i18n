---@class ShadowEvent : Event 
---@param fade? Do the shadows fade out on exit? Defaults to `false`.
---@param fade_speed? How fast the shadow fades out. Defaults to `0.1`.
---@param target_opacity? The opacity the shadow fades out to. Defaults to `0`.
local ShadowEvent, super = Class(Event)

function ShadowEvent:init(x, y, data)
    super.init(self, x, y, data)
    self:setHitbox(0, 0, data.width, data.height)
    local properties = data.properties or {}
    self.fade_out = properties["fade"] or false 
    self.target_opacity = properties["target_opacity"] or 0
    self.fade_speed = properties["fade_speed"] or 0.1
    self.opacity = properties["opacity"] or 0.5
    self.shear = properties["shear"] or -0.5
    self.shadow_scale = properties["scale"] or 1.5
    self.current_opacity = 0
    self.is_inside = false
end

function ShadowEvent:onEnter(player)
    super.onEnter(self, player)
    self.is_inside = true 
end 

function ShadowEvent:onExit(player)
    super.onExit(self, player)
    self.is_inside = false 
end 

function ShadowEvent:update()
    super.update(self)
    local destination_opacity = self.target_opacity
    if self.is_inside then
        destination_opacity = self.opacity
    elseif not self.fade_out then
        destination_opacity = self.target_opacity
    end
    
    self.current_opacity = MathUtils.approach(self.current_opacity, destination_opacity, self.fade_speed * DTMULT)
end

function ShadowEvent:drawCharacterShadow(chara)
    if self.current_opacity <= 0 or not chara.sprite then return end
    if Game.state == "BATTLE" then return end 
    
    love.graphics.push()
    local w = chara.sprite.width or 0
    local h = chara.sprite.height or 0
    local ox, oy = 0, 0
    if chara.sprite.getOffset then
        local offset_table = chara.sprite:getOffset()
        if type(offset_table) == "table" then
            ox = offset_table or offset_table.x or 0
            oy = offset_table or offset_table.y or 0
        end
    end
    
    local rel_x, rel_y = chara:getRelativePos(ox + (w / 2), oy + h, self)
    love.graphics.translate(rel_x, rel_y - 2)
    love.graphics.scale(self.shadow_scale, -self.shadow_scale)
    love.graphics.shear(self.shear, 0)
    love.graphics.translate(-w / 2, -h)
    
    Draw.setColor(0, 0, 0, self.current_opacity)

    if Kristal.Shaders["AddColor"] then
        love.graphics.setShader(Kristal.Shaders["AddColor"])
        Kristal.Shaders["AddColor"]:send("inputcolor", {0, 0, 0, self.current_opacity})
        Kristal.Shaders["AddColor"]:send("amount", 1)
    end
    
    Draw.draw(chara.sprite.texture, 0, 0)
    love.graphics.setShader()
    love.graphics.pop() 
end

function ShadowEvent:draw()
    if self.current_opacity <= 0 then return end
    
    local r, g, b, a = love.graphics.getColor()
    Draw.setColor(0, 0, 0, self.current_opacity)
    
    for _, party_chara in ipairs(Game.party) do
        local chara_obj = Game.world:getPartyCharacter(party_chara)
        if chara_obj then
            self:drawCharacterShadow(chara_obj)
        end
    end
    
    Draw.setColor(r, g, b, a)
    super.draw(self)
end

return ShadowEvent
