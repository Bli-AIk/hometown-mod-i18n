local Fireball, super = Class(Bullet)

function Fireball:init(x, y)
    super.init(self, x, y, "bullets/fire")

    self.destroy_on_hit = false
    self.tp = 2
    self.state = "ROTATE" 
    self.center_x = x
    self.center_y = y
    self.angle = 0
    self.radius = 60
    self:setScale(1.4)
end

function Fireball:update()
    if self.state == "ROTATE" then
        self.angle = self.angle + (2.5 * DT)
        self.x = self.center_x + math.cos(self.angle) * self.radius
        self.y = self.center_y + math.sin(self.angle) * self.radius

    elseif self.state == "BLAST" then
        self.remove_offscreen = true
        
        if self.x < -40 or self.x > SCREEN_WIDTH + 40 or self.y < -40 or self.y > SCREEN_HEIGHT + 40 then
            self.state = "DONE"
        end
    end

    super.update(self) -- Process native physics tables variables cleanly
end

function Fireball:fireAtSoul()
    if not Game.battle.soul then return end
    
    self.state = "BLAST"
    local angle_to_soul = Utils.angle(self.x, self.y, Game.battle.soul.x, Game.battle.soul.y)
    self.physics.direction = angle_to_soul
    self.rotation = angle_to_soul -- Snap sprite rotation forward towards target
    self.physics.speed = 11
    self.graphics.spin = math.rad(4) 
    
    Assets.playSound("bigcut")
end

return Fireball
