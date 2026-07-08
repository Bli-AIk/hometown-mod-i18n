local Basic, super = Class(Wave)


function Basic:init()
    super.init(self)
    self.time = 15
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
        bullet.remove_offscreen = false
        self.timer:every(1/30, function()
                -- Cancel timer if the bullet is removed
                if not bullet then
                    return false
                end

                -- Spawn a new afterimage with 0.4 starting alpha
                local after_image = AfterImage(bullet.sprite, 0.2)
                bullet:addChild(after_image)
            end)

    end)
    
        self.timer:everyInstant(1, function()
        local x = -20
        local y = MathUtils.random(Game.battle.arena.top, Game.battle.arena.bottom)
        
        local bullet = self:spawnBullet("ralseiangel", x, y, math.rad(0), 8)
        bullet.sprite:setScaleOrigin(0.5, 0.5)
        bullet.produce_snow = false
        bullet.sprite.scale_x = -bullet.sprite.scale_x
        bullet.remove_offscreen = false
        self.timer:every(1/30, function()
                -- Cancel timer if the bullet is removed
                if not bullet then
                    return false
                end

                -- Spawn a new afterimage with 0.4 starting alpha
                local after_image = AfterImage(bullet.sprite, 0.2)
                bullet:addChild(after_image)
            end)

    end)
    
end

return Basic
