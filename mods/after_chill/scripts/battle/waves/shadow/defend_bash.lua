local defend_bash, super = Class(Wave)

function defend_bash:init()
    super.init(self)
    self:setArenaPosition(320, 230)
    self.time = 19
    self.bullets = {}
    self.cycles = 0 
    self.max_cycles = 9
end

function defend_bash:onStart()
    local arena = Game.battle.arena
    local shadow = Game.battle:getEnemyBattler("shadow")
    self.timer:tween(0.5, shadow, {alpha = 0})
    self.timer:after(0.5, function()
        self.timer:tween(0.5, shadow, {alpha = 1}, "linear", function()
             shadow:setLayer(BATTLE_LAYERS["above_ui"])
             self.cycles = self.cycles + 1
            self:defend(shadow)
             self.timer:every(2, function()
                self.cycles = self.cycles + 1
                if not (self.cycles >= self.max_cycles) then 
                self:hitArena()
                end 
             end)
        end)
    end)
end

function defend_bash:defend(shadow)
    shadow:setAnimation("battle/defend_ready", function()
        self:hitArena()
    end)
end 

function defend_bash:hitArena()
    local x, y = self:calculateRandom()
    local arena = Game.battle.arena
    local shadow = Game.battle:getEnemyBattler("shadow")
    shadow:slideTo(shadow.x, y, 0.4, "linear", function()
        shadow:setLayer(arena.layer - 1)
        Assets.playSound("scytheburst")
        shadow:slideTo(x, shadow.y, 0.2, "linear", function()
             Assets.playSound("impact")
             arena:shake(4, 4)
             local cx, cy = shadow:getRelativePos(shadow.width/2, shadow.height/2, Game.battle)
             local total_bullets = 8
             for i = 1, total_bullets do
                 local bullet = self:spawnBullet("effects/shadow_shard", cx, cy)
                 table.insert(self.bullets, bullet)
                 bullet:setOrigin(0.5, 0.5)
                 bullet.physics.speed_x = love.math.random(-6, -2)
                 bullet.physics.speed_y = love.math.random(-5, 1)
                 bullet.physics.gravity = 0.2
                 bullet.remove_offscreen = true
                 bullet.spin_speed = love.math.random(-10, 10) / 100
                 bullet.graphics.spin = love.math.random(-10, 10) / 100
             end
             shadow:slideTo(516, shadow.y, 1, "out-back")
        end)
    end)
end

function defend_bash:calculateRandom()
    local arena = Game.battle.arena    
    local shadow = Game.battle:getEnemyBattler("shadow")
    local x = arena:getRight()  
    local y = shadow.y 
    local raw_y = love.math.random(Game.battle.soul.y, Game.battle.soul.y + love.math.random(-20, 20))
    local rand_y = MathUtils.clamp(raw_y, 214, 295)
    return x, rand_y 
end 

function defend_bash:beforeEnd()
    self.timer:remove()
    for _, bullet in ipairs(self.bullets) do
        bullet:remove()
    end
    local shadow = Game.battle:getEnemyBattler("shadow")
    Game.battle.timer:tween(0.5, shadow, {alpha = 0}, "linear", function()
       shadow:setLayer(-100)
       shadow:resetSprite()
       shadow:setPosition(516, 292)
       Game.battle.timer:tween(0.5, shadow, {alpha = 1})
    end)
end 

return defend_bash
