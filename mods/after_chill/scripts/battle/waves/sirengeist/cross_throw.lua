local cross_throw, super = Class(Wave)
local function getHeadPos(ye)
    local rx, ry = ye:getRelativePos(ye.width / 2, 0)
    return rx + 5, ry 
end 

function cross_throw:onArenaEnter()
    super.onArenaEnter(self)
       Game.battle.arena:setSize(142/2, 142/2)
end 

function cross_throw:onStart()
   self.time = 8
   self.wave_attackers = self:getAttackers()
   self.current_index = 1
   self:send()
end

function cross_throw:send()
    local total_enemies = #self.wave_attackers

    local chosen_enemy = nil
    for attempt = 1, total_enemies do
        local check_enemy = self.wave_attackers[self.current_index]
        self.current_index = self.current_index + 1
        if self.current_index > total_enemies then
            self.current_index = 1
        end
        if check_enemy then
            chosen_enemy = check_enemy
            break
        end
    end
    if chosen_enemy then
        self:throwCross(chosen_enemy)
    end
end 
function cross_throw:throwCross(enemy)
    local bx, by = getHeadPos(enemy)
    local bullet = self:spawnBullet("bullets/cross", bx, by)
    bullet:setScale(3.2)
    bullet.graphics.spin = 0.2
    enemy:setSprite("throw") 
    bullet.alpha = 0
    bullet:fadeTo(1, 0.2, function()
         bullet.physics.direction = MathUtils.angle(bullet.x, bullet.y, Game.battle.soul.x, Game.battle.soul.y)
         bullet.physics.gravity_direction = MathUtils.angle(bullet.x, bullet.y, Game.battle.soul.x, Game.battle.soul.y)
         bullet.physics.speed = 10  
         bullet.physics.gravity = 1
         bullet:setHitbox(1, 1, 8, 8)    
         Assets.playSound("bigcut")
         self.timer:after(0.5, function()
             enemy:setAnimation("idle")
             self:send()
         end)
    end)
end 

function cross_throw:beforeEnd()
     for i, enemy in ipairs(self.wave_attackers) do
        if enemy and enemy.stage then 
            enemy:resetSprite()
        end
    end 
end 

return cross_throw
