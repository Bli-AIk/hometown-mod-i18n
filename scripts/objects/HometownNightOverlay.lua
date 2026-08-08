local HometownNightOverlay, super = Class(Object)

local lg = love.graphics
local Draw_pushCanvas = Draw.pushCanvas
local Draw_popCanvas = Draw.popCanvas
local Draw_setColor = Draw.setColor
local Draw_draw = Draw.draw

function HometownNightOverlay:init(x, y, width, height)
    super.init(self, x, y)

    self.width = width
    self.height = height
    self.color = {1, 1, 1}

    self.line = false
    self.line_width = 1
end

function HometownNightOverlay:draw()
    local stage = Game.world.stage
    local objects = stage:getObjects(Object)

    local mask = Draw_pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)

    local transformed = false

    for i = 1, #objects do
        local obj = objects[i]

        if obj.night_mode == 2 then
            if not transformed then
                lg.applyTransform(obj.parent:getFullTransform())
                transformed = true
            end

            obj:fullDraw(not self.draw_children)
        end
    end

    Draw_popCanvas()

    Draw_setColor(1, 1, 1, 1)

    lg.stencil(function()
        local last_shader = lg.getShader()
        lg.setShader(Kristal.Shaders["Mask"])
        Draw_draw(mask)
        lg.setShader(last_shader)
    end, "replace", 1)

    Draw_setColor(self.color[1], self.color[2], self.color[3], self.alpha)

    lg.setLineWidth(self.line_width)
    lg.setStencilTest("less", 1)

    lg.rectangle(self.line and "line" or "fill", 0, 0, self.width, self.height)

    lg.setStencilTest()

    Draw_setColor(1, 1, 1, 1)

    super.draw(self)
end

return HometownNightOverlay