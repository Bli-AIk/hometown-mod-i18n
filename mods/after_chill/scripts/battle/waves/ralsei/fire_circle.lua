local fire_circle, super = Class(Wave)

function fire_circle:init()
    super.init(self)
    self.time = 12
    self.all_rings = {}
end

function fire_circle:onStart()
    Game.battle.arena:setFire(true, true)
    local ralsei = self:getAttackers()[1]
    if ralsei then
        ralsei:setAnimation("spell")
    end
    self.timer:everyInstant(1.2, function()
        Assets.playSound("bomb")
        self:spawnExpandingRing(ralsei)
    end)
end 

function fire_circle:onArenaEnter()
    super.onArenaEnter(self)
    Game.battle.arena:setFire(true, false)
end

function fire_circle:spawnExpandingRing(ralsei)
    local cx, cy = SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2
    if ralsei then
        cx, cy = ralsei:getRelativePos(ralsei.width / 2 - 20, ralsei.height / 2 - 10)
    end

    local current_ring = {}
    local bullet_count = 8
    local ring_spin_offset = love.math.random() * math.pi

    for i = 1, bullet_count do
        local base_angle = (math.pi * 2 / bullet_count) * i  
        local fb = self:spawnBullet("firesnipe", cx, cy)
        if fb then
            fb.alpha = 0
            fb:fadeTo(1, 0.2)
            fb.destroy_on_hit = false
            fb.remove_offscreen = false
            fb.center_x = cx
            fb.center_y = cy
            fb.angle = base_angle + ring_spin_offset
            fb.radius = 0
            fb.damage = fb:getDamage() - 10 
            fb.state = "EXPAND_RING" 
            table.insert(current_ring, fb)
            table.insert(self.all_rings, fb)
        end
    end
    for _, fb in ipairs(current_ring) do
        self.timer:tween(6.0, fb, {radius = 500}, "linear", function()
            fb:remove()
        end)
    end
end

function fire_circle:update()
    super.update(self)
    TableUtils.filterInPlace(self.all_rings, function(fb)
        return fb.stage ~= nil
    end)
end

return fire_circle
