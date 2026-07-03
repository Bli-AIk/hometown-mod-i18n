---@class HealSparkle : Sprite
---@overload fun(...) : HealSparkle
local FireRain, super = Class(Sprite)

function FireRain:init(x, y)
    super.init(self, "effects/firespell/firerain/spr_fire_rain", x, y)

    self:play(4 / 30, true)

    self:setOrigin(0.5, 0.5)
    self:setScale(2)
    self.timer = 0
    self.alpha = math.random(5,7)
end

function FireRain:update()
    if self.marker and (self.y >= self.marker) and (self.timer > 15) then
        self.physics.speed = 0
        self.physics.gravity = 0
    end

    self.timer = self.timer + 1
    if self.alpha < 0 then
        self:remove()
    end
    self.alpha = self.alpha - 0.05
    super.update(self)
end

return FireRain
