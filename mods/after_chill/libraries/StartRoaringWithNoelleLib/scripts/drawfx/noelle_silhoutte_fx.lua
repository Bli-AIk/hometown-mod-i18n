local NoelleSilhouetteFX, super = Class(FXBase)

function NoelleSilhouetteFX:init(noelle, priority)
    super.init(self, priority or 10)

    self.noelle = noelle

    self.mask_fx = MaskFX(function()
  
        love.graphics.setColor(1, 1, 1, 1)
        self.noelle:drawSelf(true)
    end, false)

    self.mask_fx.inverted = false
end

function NoelleSilhouetteFX:draw(texture)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(texture)

    self.mask_fx:draw(texture)


    love.graphics.setColor(1, 1, 1, 0.85)

    for _, o in ipairs({
        {-1, 0}, {1, 0}, {0, -1}, {0, 1}
    }) do
        love.graphics.push()
        love.graphics.translate(o[1], o[2])
        love.graphics.draw(texture)
        love.graphics.pop()
    end
end

return NoelleSilhouetteFX
