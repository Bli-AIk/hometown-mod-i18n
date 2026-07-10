local spell, super = Class(Spell, "fire_shock")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "FireShock"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    if not Kristal.getLibConfig("fireshockch5", "ralsei_defaultanimation") then
        self.cast_anim = "battle/fireball"
    end

    -- Battle description
    self.effect = "Damage\nw/ FIRE"
    -- Menu description
    self.description = "Deals magical FIRE damage to\none enemy."

    -- TP cost
    self.cost = 25

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {"fire", "damage"}
end

function spell:getTPCost(chara)
    local cost = super.getTPCost(self, chara)
    if chara and chara:checkWeapon("thornring") then
        cost = MathUtils.round(cost / 2)
    end
    return cost
end

function spell:onCast(user, target)
    user.chara:addFlag("fireshocks_used", 1)

    local function createParticle(x, y, order, sprite)
        local sprite = Sprite(sprite or "effects/firespell/flame", x, y)
        sprite:setOrigin(0.5, 0.5)
        sprite:setScale(2)
        sprite.layer = BATTLE_LAYERS["above_battlers"]  - (order or 0)
        Game.battle:addChild(sprite)
        return sprite
    end

    local x, y = target:getRelativePos(target.width/2, target.height/2, Game.battle)

    local function deleteAnimation(animation, number)
        --shitty callbacks happen when sprite starts? Idk how to remove these sprites from existance
    end

    local particles = {}
    local twinkles = {}
    Game.battle.timer:script(function(wait)
        wait(1/30)
        if Kristal.getLibConfig("fireshockch5", "ogsound") then
            Assets.playSound("firespell_original")
        else
            Assets.playSound("firespell")
        end
        
        particles[1] = createParticle(x-25, y-20, 1)
        wait(3/30)
        particles[2] = createParticle(x+25, y-20, 2)
        wait(3/30)
        particles[3] = createParticle(x, y+20, 3)
        wait(3/30)
        Game.battle:addChild(IceSpellBurst(x, y))
        for _,particle in ipairs(particles) do
            for i = 0, 5 do
                local effect = FireSpellEffect(particle.x, particle.y, false, true)
                effect:setScale(2)
                effect.physics.direction = math.rad(60 * i)
                effect.physics.speed = 8
                effect.physics.friction = 0.2
                effect.layer = BATTLE_LAYERS["above_battlers"] - 1
                Game.battle:addChild(effect)
            end
        end
        if Kristal.getLibConfig("fireshockch5", "sparklyrings") then
            for i = 0, 11 do
                twinkles[i+1] = createParticle(x, y, 4, "effects/firespell/twinkle/twinkle")
                twinkles[i+1].physics.speed = 8
                twinkles[i+1].physics.friction = 0.4
                twinkles[i+1]:setScale(1)
                twinkles[i+1].physics.direction = math.rad(i * 30)
                twinkles[i+1]:play(0.15, false)
            end
            for i = 0, 11 do
                twinkles[i+1] = createParticle(x, y, 4, "effects/firespell/twinkle/twinkle")
                twinkles[i+1].physics.speed = 10
                twinkles[i+1].physics.friction = 0.34
                twinkles[i+1]:setScale(1)
                twinkles[i+1].physics.direction = math.rad(i * 30 + 15)
                twinkles[i+1]:play(0.2, false)
            end
        end
        if Kristal.getLibConfig("fireshockch5", "hugeexplosion") then
            local explosion = createParticle(x, y, 6, "effects/firespell/explosion/spr_omegaflowery_explosion_a")
            explosion:setScale(2)
            explosion:play(0.1, false, deleteAnimation(explosion, 60))
        end
        if Kristal.getLibConfig("fireshockch5", "firerain") then
            for i = -3, 2 do
                local fire = FireRain(x, y)
                fire.layer = BATTLE_LAYERS["above_battlers"] - 5
                fire.physics.speed = 10
                fire:setFrame(math.random(1, 4))
                fire.physics.gravity = 0.4
                fire.physics.direction = math.rad(-90 + (i * 30) + math.random(10, 20))
                fire.physics.speed_x = fire.physics.speed_x * 1.2
                fire.marker = y - math.random(-100/5, 50/5)*5 + math.abs(i)*5
                Game.battle:addChild(fire)
            end
        end
        wait(1/30)
        for _,particle in ipairs(particles) do
            particle:remove()
        end
        wait(4/30)

        local damage = self:getDamage(user, target)
        target:hurt(damage, user)
        --target:hurt(damage, user, function() target:freeze() end)

        Game.battle:finishActionBy(user)
    end)

    return false
end

function spell:getDamage(user, target)
    local min_magic = MathUtils.clamp(user.chara:getStat("magic") - 10, 1, 999)

    return math.ceil((min_magic * 30) + 90 + MathUtils.random(10))
end

return spell
