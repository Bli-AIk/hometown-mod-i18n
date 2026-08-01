local star_bomb_bullet, super = Class(Bullet)

function star_bomb_bullet:init(x, y, target_x, target_y, side)
    super.init(self, x, y, "bullets/star")
    self:setOrigin(0.5, 0.5)
    self.damage = 0 
    self.can_graze = 0
    self.target_x = target_x
    self.target_y = target_y
    self.side = side 
    self.destroy_on_hit = false 
    self.trail_timer = 0
    self.remove_offscreen = false
    self.graphics.spin = 0.2
end

function star_bomb_bullet:setupMovement(target_x, target_y)
    if self.wave and self.wave.timer then
        self.wave.timer:tween(0.8, self, {x = target_x, y = target_y, rotation = math.pi * 2}, "out-expo", function()
            self:explode()
        end)
    end
end

function star_bomb_bullet:update()
    if not Game.battle then return end
    self.trail_timer = self.trail_timer + DT
    if self.trail_timer >= 0.05 then
        local afterimage = AfterImage(self, 0.4)
        afterimage:setColor(1, 0.6, 0)
        Game.battle:addChild(afterimage)
        self.trail_timer = 0
    end
    super.update(self)
end

function star_bomb_bullet:explode()
    if not Game.battle.soul or not self.wave then 
        self:remove()
        return 
    end
    Assets.playSound("bomb", 0.6)
    for i = 1, 6 do
        local p = Sprite("bullets/star", self.x, self.y)
        p:setOrigin(0.5, 0.5)
        p:setScale(love.math.random(0.2, 0.5))
        p:addFX(ColorMaskFX({1, 0.4, 0}, 1))
        p.physics.speed_x = love.math.random(-4, 4)
        p.physics.speed_y = love.math.random(-6, 2)
        p.physics.gravity = 0.4
        p:fadeOutAndRemove(0.4)   
        self.wave:addChild(p)
    end

    local soul = Game.battle.soul
    local angle_to_soul = MatgUtils.angle(self.x, self.y, soul.x, soul.y)

    for i = 1, 3 do
        local fb = self.wave:spawnBullet("firesnipe", self.x, self.y)
        fb:addFX(ColorMaskFX({0.4, 0.6, 1.0}, 0.4))
        fb.physics.speed = love.math.random(6, 10) 
        fb.physics.direction = angle_to_soul + (i - 2) * 0.1
        table.insert(self.wave.bullet_table, fb)
    end
    
    self:remove()
end

return star_bomb_bullet
