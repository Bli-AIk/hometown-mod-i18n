local Basic, super = Class(Wave)

function Basic:init()
    super.init(self)
    self.time = 15
    self.active_bullets = {}
end 

function Basic:onArenaEnter()
    super.onArenaEnter(self)
    Game.battle.arena:setFire(true, false)
end

function Basic:onStart()
    self.timer:everyInstant(1, function()
        Game.battle.arena:setFire(true, true)
        local x = SCREEN_WIDTH + 20
        local y = MathUtils.random(Game.battle.arena.top, Game.battle.arena.bottom) 
        local bullet = self:spawnBullet("ralseiangel", x, y, math.rad(180), 8)
        if bullet then
            bullet.remove_offscreen = false
            bullet.trail_timer = 0 
            table.insert(self.active_bullets, bullet)
        end
    end)
    self.timer:everyInstant(1, function()
        local x = -20
        local y = MathUtils.random(Game.battle.arena.top, Game.battle.arena.bottom)
        
        local bullet = self:spawnBullet("ralseiangel", x, y, math.rad(0), 8)
        if bullet then
            bullet.sprite:setScaleOrigin(0.5, 0.5)
            bullet.produce_snow = false
            bullet.sprite.scale_x = -bullet.sprite.scale_x
            bullet.remove_offscreen = false
            bullet.trail_timer = 0 
            table.insert(self.active_bullets, bullet)
        end
    end)
end

function Basic:update()
    super.update(self)
    TableUtils.filterInPlace(self.active_bullets, function(bullet)
        return bullet.stage ~= nil
    end)
    for _, bullet in ipairs(self.active_bullets) do
        bullet.trail_timer = bullet.trail_timer + DT
        if bullet.trail_timer >= 0.033 then
            if bullet.sprite then
                local after_image = AfterImage(bullet.sprite, 0.2)
                bullet:addChild(after_image)
            end
            bullet.trail_timer = 0
        end
    end
end

return Basic
