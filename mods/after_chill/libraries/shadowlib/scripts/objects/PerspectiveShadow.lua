local PerspectiveShadow, super = Class(Object)

function PerspectiveShadow:init(data)
    super.init(self, 0, 0)
    self.opacity = data.properties["opacity"] or 0.4
    self.shear = data.properties["shear"] or -0.5
    self.shadow_scale_x = data.properties["scale_x"] or -2
    self.shadow_scale_y = data.properties["scale_y"] or 1
    self.layer = WORLD_LAYERS["below_ui"]
    self.canvas = love.graphics.newCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
    self.canvas:setFilter("nearest", "nearest")
end

function PerspectiveShadow:drawCharacterShadow(chara)
    love.graphics.push()
    local last_scale_y = chara.scale_y
    local last_scale_x = chara.scale_x
    chara.scale_y = -self.shadow_scale_y  
    chara.scale_x = -self.shadow_scale_x
    chara:preDraw()
    love.graphics.translate(-chara.height * self.shear, 0)
    love.graphics.shear(self.shear, 0)
    chara:draw()
    chara:postDraw() 
    chara.scale_y = last_scale_y
    chara.scale_x = last_scale_x
    love.graphics.pop()
end

function PerspectiveShadow:draw()
    if Game.state == "BATTLE" then 
        super.draw(self)
        return 
    end

    local r, g, b, a = love.graphics.getColor() 
    Draw.pushCanvas(self.canvas, {clear = true})
    love.graphics.translate(-Game.world.camera.x + (SCREEN_WIDTH / 2), -Game.world.camera.y + (SCREEN_HEIGHT / 2))
    love.graphics.setShader(Kristal.Shaders["AddColor"])
    Kristal.Shaders["AddColor"]:send("inputcolor", {0, 0, 0, 1})
    Kristal.Shaders["AddColor"]:send("amount", 1)

    for _, party_chara in ipairs(Game.party) do
        local chara_obj = Game.world:getPartyCharacter(party_chara)
        if chara_obj then
            self:drawCharacterShadow(chara_obj)
        end
    end
    
    love.graphics.setShader()
    Draw.popCanvas()
    love.graphics.push()
    love.graphics.origin()
    Draw.setColor(0, 0, 0, self.opacity)
    love.graphics.draw(self.canvas, 0, 0)
    love.graphics.pop()
    Draw.setColor(r, g, b, a)
    super.draw(self)
end

return PerspectiveShadow
