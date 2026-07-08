local Xture, super = Class(Bullet)

function Xture:init(x, y, dir, speed)
    -- Last argument = sprite path
    x, y = Game.battle.soul:getRelativePos(Game.battle.soul.width/2, Game.battle.soul.height/2, Game.battle)
    super.init(self, x-15, y-15, "empty")
    Hitbox(self, 5, 5, 20, 20)

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir

    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed

    self.destroy_on_hit = false
    can_hurt = false

end

function Xture:onWaveSpawn(wave)
can_hurt = false

local x, y = Game.battle.soul:getRelativePos(Game.battle.soul.width/2, Game.battle.soul.height/2, Game.battle)

    local function createParticle(x, y)
        local sprite = Sprite("effects/icespell/snowflake", x, y)
        sprite:setOrigin(0.5, 0.5)
        sprite:setScale(1.5)
        sprite.layer = BATTLE_LAYERS["top"]+10
        Game.battle:addChild(sprite)
        return sprite
    end

    local particles = {}
    Game.battle.timer:script(function(wait)
        wait(1/30)
        Assets.playSound("icespell")
        particles[1] = createParticle(x-25, y-20)
        wait(3/30)
        particles[2] = createParticle(x+25, y-20)
        wait(3/30)
        particles[3] = createParticle(x, y+20)
        wait(3/30)
        can_hurt = true
        Game.battle:addChild(IceSpellBurst(x, y))
        for _,particle in ipairs(particles) do
            for i = 0, 5 do
                local effect = IceSpellEffect(particle.x, particle.y)
                effect:setScale(0.75)
                effect.physics.direction = math.rad(60 * i)
                effect.physics.speed = 8
                effect.physics.friction = 0.2
                effect.layer = BATTLE_LAYERS["top"] + 15
                Game.battle:addChild(effect)
            end
        end
        wait(1/30)
        for _,particle in ipairs(particles) do
            particle:remove()
            self:remove()
        end
    end)

end

function Xture:onCollide(soul)
    if can_hurt == true then
        if soul.inv_timer == 0 then
            self:onDamage(soul)
        end
    
        if self.destroy_on_hit then
            self:remove()
        end
    end
end

function Xture:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

return Xture