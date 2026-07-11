local BattleBackground, super = HookSystem.hookScript(BattleBackground)

function BattleBackground:drawBackground()
    Draw.setColor(0, 0, 0, self.alpha)
    love.graphics.rectangle("fill", -10, -10, SCREEN_WIDTH + 20, SCREEN_HEIGHT + 20)
    local background = Assets.getTexture("ui/battle/background")
    Draw.setColor(0.04, 0.06, 0.15, self.alpha / 2)
    Draw.drawWrapped(background, true, true, MathUtils.round(-100 + self.position), MathUtils.round(-100 + self.position))
    Draw.setColor(0.08, 0.12, 0.28, self.alpha)
    Draw.drawWrapped(background, true, true, MathUtils.round(-200 - self.position2), MathUtils.round(-210 - self.position2))
end

return BattleBackground
