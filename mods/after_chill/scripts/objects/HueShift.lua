---@class HueShift : FXBase
local HueShift, super = Class(FXBase)

function HueShift:init(hue_shift)
    super.init(self)
    self.hue_shift = hue_shift or 0
    self.shader = love.graphics.newShader([[
        extern number hue_shift;

        vec4 effect(vec4 color, Image tex, vec2 texcoord, vec2 pixcoord) {
            vec4 pixel = Texel(tex, texcoord) * color;

            float angle = hue_shift;
            float s = sin(angle), c = cos(angle);

            mat3 hueRotation = mat3(
                vec3(0.213 + c*0.787 - s*0.213, 0.715 - c*0.715 - s*0.715, 0.072 - c*0.072 + s*0.928),
                vec3(0.213 - c*0.213 + s*0.143, 0.715 + c*0.285 + s*0.140, 0.072 - c*0.072 - s*0.283),
                vec3(0.213 - c*0.213 - s*0.787, 0.715 - c*0.715 + s*0.715, 0.072 + c*0.928 + s*0.072)
            );

            pixel.rgb = hueRotation * pixel.rgb;
            return pixel;
        }
    ]])
end

function HueShift:draw(texture, transform)
    love.graphics.push()

    self.shader:send("hue_shift", self.hue_shift)
    love.graphics.setShader(self.shader)
    love.graphics.draw(texture, 0, 0)
    love.graphics.setShader()

    love.graphics.pop()
end

return HueShift
