local star_rain, super = Class(Wave)

function star_rain:onStart()
    self.time = 12
    local ralsei = self:getAttackers()[1]
    self.timer:everyInstant(0.4, function()
        self:spawnStar(ralsei)
    end)
end

function star_rain:spawnStar(ralsei)
    local arena = Game.battle.arena
    local rx = love.math.random(arena.left + 10, arena.right - 10)
    local ry = arena.top - 40
    ralsei:setAnimation("spell")
    Assets.playSound("spell_cure_slight_smaller")
    self.timer:after(0.2, function()
    self:fadein(rx, ry)
    end)
end

function star_rain:fadein(x, y)
    local bullet = self:spawnBullet("star_rain_bullet", x, y)
    bullet.alpha = 0
    if love.math.random(1, 3) == 2 then 
                local fb = bullet
                fb:addFX(ColorMaskFX(COLORS.lime))
                fb.onCollide = function(bs) 
                bs:remove()
                for _, follower in ipairs(Game.battle.party) do 
                follower:heal(bs:getDamage()/2)
                end 
            end 
        end
    bullet:fadeTo(1, 0.5, function()
        local fx = bullet:addFX(ColorMaskFX({1, 1, 0.9}, 1))
        self.timer:after(0.1, function()
            Assets.playSound("stardrop")
            bullet.physics.speed_y = 13 
            bullet:removeFX(fx)
        end)
    end)
end

function star_rain:onEnd()
    super.onEnd(self)
    for _, bullet in ipairs(self.bullets) do 
        if bullet then 
            bullet:remove()
        end 
    end 
end 

return star_rain
