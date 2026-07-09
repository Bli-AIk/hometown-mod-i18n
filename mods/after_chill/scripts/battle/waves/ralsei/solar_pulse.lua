local solar_pulse, super = Class(Wave)

function solar_pulse:init()
    super.init(self)
    self.time = 14
    self.pulse_timer = 0
    self.core_flame = nil
    self.start_w = 0
    self.start_h = 0
end

function solar_pulse:onArenaEnter()
    super.onArenaEnter(self)
    Game.battle.arena:setFire(true, false)
    self.start_w = Game.battle.arena.width
    self.start_h = Game.battle.arena.height
    self.timer:tween(0.5, Game.battle.arena, {width = 240, height = 240}, "out-cubic")
end

function solar_pulse:onStart()
    Game.battle.arena:setFire(true, true)
    local ralsei = self:getAttackers()[1]
    local cx, cy = Game.battle.arena:getCenter()
    self.timer:after(0.5, function()
        self.core_flame = self:spawnBullet("effects/firespell/flame", cx, cy)
        self.core_flame:setScale(1.5)
        self.core_flame.destroy_on_hit = false
        self.core_flame.graphics.spin = 0.1
        self.timer:everyInstant(1.3, function()
            ralsei:setAnimation("spell", function()
            self:executeCorePulseEffect()
            Assets.playSound("spell_pacify", 0.6, 0.8)
            self:spawnExpandingSolarRing(cx, cy, 8)
            end)
        end)
    end)
end

function solar_pulse:executeCorePulseEffect()
    if not self.core_flame or not self.core_flame.stage then return end
    self.timer:tween(0.4, self.core_flame, {scale_x = 2, scale_y = 2}, "out-sine", function()
    self.timer:tween(0.4, self.core_flame, {scale_x = 1.5, scale_y = 1.5}, "out-sine")
    end)
end


function solar_pulse:spawnExpandingSolarRing(center_x, center_y, bullet_count)
    local ring_twist = love.math.random() * math.pi
    
    for i = 1, bullet_count do
        local angle = ((math.pi * 2) / bullet_count) * i + ring_twist
        local shard = self:spawnBullet("solar_ring_bullet", center_x, center_y)
        if shard then
            shard.layer = self.core_flame.layer - 1
            shard.physics.direction = angle
            shard.physics.speed = 3.8
        end
    end
end

return solar_pulse
