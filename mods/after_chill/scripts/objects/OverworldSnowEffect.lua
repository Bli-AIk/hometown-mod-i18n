local OverworldSnowEffect, super = Class(Object)

function OverworldSnowEffect:init()
    super.init(self, 0, 0)
    self:setLayer((WORLD_LAYERS["above_events"]) - 1)
    
    self.wave_intensity = 6
    
    self.bg_layer = Sprite("effects/IMAGE_SNOW")
    self.bg_layer:setOrigin(0.5, 0.5)
    self.bg_layer:setScale(2, 2)
    self.bg_layer.wrap_texture_x = true
    self.bg_layer.wrap_texture_y = true
    self.bg_layer.physics.speed_x = 2 
    self.bg_layer.alpha = 0
    self:addChild(self.bg_layer)
    
    self.wave_shader = love.graphics.newShader([[
        extern number wave_sine;
        extern number wave_mag;
        extern number wave_height;
        extern vec2 texsize;
        vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
        {
            number i = texture_coords.y * texsize.y;
            number v = texture_coords.x * texsize.x;
            vec2 coords = vec2(
                clamp(texture_coords.x + (sin((i / wave_height) + (wave_sine / 30.0)) * wave_mag) / texsize.x, 0.0, 1.0),
                clamp(texture_coords.y + (sin((v / wave_height) + (wave_sine / 30.0)) * wave_mag) / texsize.y, 0.0, 1.0)
            );
            return Texel(texture, coords) * color;
        }
    ]])
            
    self.wave_fx = ShaderFX(self.wave_shader, {
        ["wave_sine"] = function() return Kristal.getTime() * 20 end,
        ["wave_mag"] = function() return self.wave_intensity end,
        ["wave_height"] = 80,
        ["texsize"] = {640, 480}
    }, false, 1)
end

function OverworldSnowEffect:onAdd(parent)
    super.onAdd(parent)
    Game.world.timer:tween(1, self.bg_layer, {alpha = 1})
    self.bg_layer:addFX(self.wave_fx, "bg_wave")
end

function OverworldSnowEffect:update()
    super.update(self)
    if Game.world and Game.world.camera then
        self:setPosition(Game.world.camera.x, Game.world.camera.y)
    end
end

function OverworldSnowEffect:remove()
    Game.world.timer:tween(1, self, {wave_intensity = 0}, "out-quad")
    Game.world.timer:tween(1, self.bg_layer, {alpha = 0}, "out-quad", function()
        self.bg_layer:removeFX("bg_wave")
        super.remove(self)
    end)
end

return OverworldSnowEffect
