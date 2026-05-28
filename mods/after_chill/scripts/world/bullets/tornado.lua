local tornado, super = Class(WorldBullet)

function tornado:init(x, y)
    super.init(self, x, y)
    self.destroy_on_hit = false 
    self.remove_offscreen = false 
    self.damage = 23
    self.sprite = Sprite("bullets/tornado")
    self.sprite:setOrigin(0.5, 0.5)
    self:addChild(self.sprite)
    self.collider = Hitbox(self, -16, -16, 32, 32)
    self:setScale(1)
    self.neg = -1
    Game.stage.timer:every(0.2, function()
        self.neg = self.neg * -1
        self.sprite.scale_x = self.neg
    end)
    if Game.world.player then
        self.y = Game.world.player.y + love.math.random(-50, 50)
    end
    local angle = math.pi 
    self.physics.speed = 7
    self.physics.direction = angle
    self.wave_timer = 0
    self.has_hit = false
end 

function tornado:onCollide(soul)
    if not self.has_hit then
        self.has_hit = true
        local push_force = 0.1
        local push_x = math.cos(self.physics.direction) * push_force
        local push_y = math.sin(self.physics.direction) * push_force
        Game.world.player:move(push_x, push_y)
        
        Game.world.timer:after(0.5, function()
            self.has_hit = false
        end)
    end
    return super.onCollide(self, soul)
end 

function tornado:update()
    super.update(self)
    if self.physics.speed > 0 then
        self.wave_timer = self.wave_timer + (10 * DT)
        
        local perpendicular_angle = self.physics.direction + math.pi / 2
        local wobble = math.sin(self.wave_timer) * 1
        
        self.x = self.x + math.cos(perpendicular_angle) * wobble
        self.y = self.y + math.sin(perpendicular_angle) * wobble
    end
    
    if self.x < -100 or self.x > Game.world.map.width * 40 + 100 then
        self:remove()
    end
end 

return tornado
