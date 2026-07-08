local fireshock, super = Class(Wave)

function fireshock:init()
    super.init(self)
    self.time = 3 
end 

function fireshock:onStart()
    Game.battle.soul.can_move = false 
    Game.battle.soul:setPosition(Game.battle.arena:getCenter())
    local ralsei = self:getAttackers()[1]
    if ralsei then
        ralsei:setAnimation("battle/fireball", function()
            self:fireshock()
        end)
    end 
end 

function fireshock:fireshock()
    local x, y = Game.battle.arena:getCenter()
    local function createParticle(px, py, sprite_path)
        local sprite = Sprite(sprite_path or "effects/firespell/flame", px, py)
        sprite:setOrigin(0.5, 0.5)
        sprite:setScale(2)
        sprite.layer = BATTLE_LAYERS["above_battlers"]
        self:addChild(sprite)
        return sprite
    end
    self.timer:script(function(wait)
        Assets.playSound("firespell")
        local p1 = createParticle(x - 25, y - 20)
        wait(3/30)
        local p2 = createParticle(x + 25, y - 20)
        wait(3/30)
        local p3 = createParticle(x, y + 20)
        wait(3/30)
        local particles = {p1, p2, p3}
        for _, particle in ipairs(particles) do
            if particle and particle.parent then
                for i = 0, 5 do
                    local effect = FireSpellEffect(particle.x, particle.y, false, true)
                    effect:setScale(2)
                    effect.physics.direction = math.rad(60 * i)
                    effect.physics.speed = 8
                    effect.physics.friction = 0.2
                    self:addChild(effect)
                end
            end
        end
        for i = 0, 11 do
            local t1 = createParticle(x, y, "effects/firespell/twinkle/twinkle")
            t1.physics.speed = 8
            t1.physics.friction = 0.4
            t1:setScale(1)
            t1.physics.direction = math.rad(i * 30)
            t1:play(0.15, false, function(s) s:remove() end)       
            local t2 = createParticle(x, y, "effects/firespell/twinkle/twinkle")
            t2.physics.speed = 10
            t2.physics.friction = 0.34
            t2:setScale(1)
            t2.physics.direction = math.rad(i * 30 + 15)
            t2:play(0.2, false, function(s) s:remove() end)
        end
        local explosion = createParticle(x, y, "effects/firespell/explosion/spr_omegaflowery_explosion_a")
        explosion:setScale(2)
        explosion:play(0.1, false, function(s) 
            s:remove() 
        end)
        for i = -3, 2 do
            local fire = FireRain(x, y)
            fire.physics.speed = 10
            if fire.setFrame then fire:setFrame(math.random(1, 4)) end
            fire.physics.gravity = 0.4
            fire.physics.direction = math.rad(-90 + (i * 30) + math.random(10, 20))
            fire.physics.speed_x = fire.physics.speed_x * 1.2
            fire.marker = y - math.random(-20, 10) * 5 + math.abs(i) * 5
            self:addChild(fire)
        end
        wait(1/30)
        for _, particle in ipairs(particles) do
            if particle and particle.parent then 
                particle:remove() 
            end
        end
        Game.battle.arena:setFire(true)
    end)
end

return fireshock
