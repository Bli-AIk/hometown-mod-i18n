local petal, super = Class(Wave) 

function petal:init()
    super.init(self)
    self.time = 12
    self.siner = 0
    self.enemy = nil 
    self.nullified = false 
end 

function petal:onStart()
    for _, wave in ipairs(Game.battle.waves) do
        if wave.id == "peonie/flowerspin" then 
            self.nullified = true 
            local arena = Game.battle.arena
            self.arena_start_x = arena.x
            self.arena_start_y = arena.y
            break 
        end 
    end  
    if not self.nullified then 
        local arena = Game.battle.arena
        self.arena_start_x = arena.x
        self.arena_start_y = arena.y
        local num_pollen = 6
        local attackers = self:getAttackers()        
        self.timer:everyInstant(1.8, function()
            Assets.playSound("ghostappear", 2)
            local attackers = self:getAttackers()        
            if #attackers == 0 then return end
            self.enemy = TableUtils.pick(attackers)
            local sx, sy = self.enemy:getRelativePos(self.enemy.width/2, self.enemy.height/2, Game.battle)
            for i = 1, num_pollen do
                local base_angle = ((i - 1) / num_pollen) * (math.pi * 2)
                local bullet = self:spawnBullet("peonie/pollen", sx, sy, base_angle)
                if self.enemy:canSpare() and i == love.math.random(2, 4) then 
                    bullet.heal = true 
                    bullet.alpha = 0.7
                    bullet:addFX(ColorMaskFX(COLORS.lime))
                end 
            end
        end)
    end 
end 

function petal:update()
    if Game.battle.arena and not self.nullified then 
        self.siner = self.siner + DT      
        local offset = math.sin(self.siner * 1.5) * 60
        Game.battle.arena:setPosition(self.arena_start_x + offset, self.arena_start_y)    
        self.arena_rotation = math.sin(self.siner * 2.5) * math.rad(5)
        local arena = Game.battle.arena
        arena.rotation = self.arena_rotation
    elseif self.nullified and Game.battle.arena then 
        self.siner = self.siner + DT      
        local offset = math.sin(self.siner * 1.5) * 20
        Game.battle.arena:setPosition(self.arena_start_x, self.arena_start_y + offset)    
        self.arena_rotation = math.sin(self.siner * 4) * math.rad(5)
        Game.battle.arena.rotation = self.arena_rotation
    end 
    super.update(self)
end

return petal
