local defend_bash, super = Class(Wave)

function defend_bash:init()
    super.init(self)
    self:setArenaPosition(320, 230)
end

function defend_bash:onStart()
    local arena = Game.battle.arena
    local shadow = Game.battle:getEnemyBattler("shadow")
    self.timer:tween(0.5, shadow, {alpha = 0})
    self.timer:after(0.5, function()
        self.timer:tween(0.5, shadow, {alpha = 1}, "linear", function()
             shadow:setLayer(BATTLE_LAYERS["above_ui"])
             self:defend(shadow)
        end)
    end)
end

function defend_bash:update()
    super.update(self)
end

function defend_bash:defend(shadow)
    shadow:setAnimation("battle/defend_ready", function()
        self:hitArena(shadow)
    end)
end 

function defend_bash:hitArena()
    local x, y = self:calculateRandom()
    local arena = Game.battle.arena
    Assets.playSound("scytheburst")
    local shadow = Game.battle:getEnemyBattler("shadow")
    shadow:slideTo(shadow.x, y, 0.4, "linear", function()
        shadow:setLayer(arena.layer - 1)
        shadow:slideTo(x, shadow.y, 0.5, "linear", function()
             Assets.playSound("impact")
             arena:shake(4, 4)
             self.collided_x = shadow.x 
             self.collided_y = shadow.y  
             shadow:slideTo(516, shadow.y, 1, "out-back")
        end)
    end)
end


function defend_bash:calculateRandom()
    local arena = Game.battle.arena    
    local shadow = Game.battle:getEnemyBattler("shadow")
    local x = arena:getRight()  
    local y = shadow.y 
    local rand_y = love.math.random(250, 300)
    return x, rand_y 
end 

function defend_bash:beforeEnd()
    local shadow = Game.battle:getEnemyBattler("shadow")
    shadow:setPosition(516, 292)
    Game.battle.timer:tween(0.5, shadow, {alpha = 0}, "linear", function()
       shadow:setLayer(-100)
       shadow:resetSprite()
       Game.battle.timer:tween(0.5, shadow, {alpha = 1})
    end)
end 

return defend_bash
