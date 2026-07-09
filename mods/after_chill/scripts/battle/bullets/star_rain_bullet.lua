local star_rain_bullet, super = Class(Bullet)

function star_rain_bullet:init(x, y)
    super.init(self, x, y, "bullets/star")
    self.trail_timer = 0
    self.graphics.spin = 0.15
end

function star_rain_bullet:update()
    super.update(self)
    if Game.battle.arena then 
    if self.alpha >= 1 and self.physics.speed_y > 0 then
        self.trail_timer = self.trail_timer + DT
        if self.trail_timer >= 0.06 then
            local afterimage = AfterImage(self, 0.6)
            afterimage.alpha = 0.5
            afterimage:setColor(1, 0.85, 0.2)
            Game.battle:addChild(afterimage)   
            self.trail_timer = 0
        end
    end
    if self.y <= Game.battle.arena:getBottom() and self.y > 230 then
        self:remove()
    end
end 
end

function star_rain_bullet:onRemove()
    Assets.playSound("snd_glassbreak", 0.5, 1.2)
    for i = 1, 6 do
        local p = Sprite("bullets/star", self.x, self.y)
        p:setOrigin(0.5, 0)
        p:setScale(0.2 + love.math.random(0.1, 0.3))
        local fx = p:addFX(ColorMaskFX({1, 0, 0}, 1))
        p.physics.speed_x = love.math.random(-4, 4)
        p.physics.speed_y = love.math.random(-8, -2)
        p.physics.gravity = 0.5 
        p:fadeOutAndRemove(0.4)
        self.wave:addChild(p)
    end
    super.onRemove(self)
end

return star_rain_bullet
