---@class IceSpellEffect : Sprite
---@overload fun(...) : IceSpellEffect
local FireSpellEffect, super = Class(Sprite)

function FireSpellEffect:init(x, y, hexagon, flame)
    local spell = "effects/icespell/snowflake"
    if flame then
        spell = "effects/firespell/smallflame"
    end
    super.init(self, hexagon and "effects/icespell/hexagon" or spell, x, y)

    self:setOrigin(0.5, 0.5)
    self:setScale(1.5)

    self.rotation_speed = 4

    self.physics.direction = 0
    self.physics.speed = 0

    self.timer = 0
    self.flame = flame
end

function FireSpellEffect:update()
    
    self.physics.direction =  self.physics.direction + math.rad((self.flame and -1 or 1) * self.rotation_speed * 3) * DTMULT
    if self.flame then
        self.rotation = self.physics.direction
    else
        self.rotation = self.rotation + math.rad(self.rotation_speed * 2) * DTMULT
    end

    self.timer = self.timer + DTMULT
    if self.timer >= 10 then
        self.alpha = self.alpha - 0.1 * DTMULT
    end

    if self.alpha < 0 then
        self:remove()
    end

    super.update(self)
end

return FireSpellEffect