local z_rainstorm, super = Class(Wave)

function z_rainstorm:init()
    super.init(self)
    self.time = 14
    self.start_w = 0
    self.start_h = 0
    self.base_w = 142
    self.base_h = 142
    self.my_clock = 0
end

function z_rainstorm:onArenaEnter()
    super.onArenaEnter(self)
    Game.battle.arena:setFire(true, false)
end

function z_rainstorm:onStart()
    Game.battle.arena:setFire(true, true)
    local ralsei = self:getAttackers()[1]
        self.timer:everyInstant(0.5, function()
            local soul = Game.battle and Game.battle.soul
            if not soul then return end
            ralsei:setAnimation("spell")
            Assets.playSound("spell_pacify", 0.3, 1.4)
            for i = 1, 2 do
                local rx = love.math.random(Game.battle.arena:getLeft(), Game.battle.arena:getRight())
                local ry = 0 
                local z = self:spawnBullet("pacify_z_rain", rx, ry)
                if z then
                    local base_angle = MathUtils.angle(rx, ry, soul.x, soul.y)
                    local angle_offset = math.rad(love.math.random(-12, 12))            
                    z.physics.speed = love.math.random(6.5, 8.5)
                    z.tiredness = 16 
                    z.damage = 18 
                    z.physics.direction = base_angle + angle_offset
                end
            end
        end)
end

function z_rainstorm:update()
    super.update(self)
    if self.base_w and self.base_h and Game.battle and Game.battle.arena then
        self.my_clock = self.my_clock + DTMULT     
        
        local pulse_speed = 0.08 
        local pulse_amplitude = 25 
        local wave_multiplier = math.sin(self.my_clock * pulse_speed)       
        local new_w = self.base_w + (wave_multiplier * pulse_amplitude)
        local new_h = self.base_h + (wave_multiplier * pulse_amplitude)           
        Game.battle.arena:setSize(new_w, new_h)
    end
end

return z_rainstorm
