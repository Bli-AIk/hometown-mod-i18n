local arena, super = HookSystem.hookScript("Arena")

function arena:setFire(should, damage)
    if should then 
        self.fiery = true
        self.damage = damage 
        self:setColor({1, 0.45, 0})
        self.fire_hurt_timer = 0
    else 
        self.damage = damage or false 
        self.fiery = should or false 
    end 
end 

function arena:update()
    super.update(self)
    if self.fiery then 
        if self.fire_hurt_timer and self.fire_hurt_timer > 0 then
            self.fire_hurt_timer = self.fire_hurt_timer - DT
        end

        local soul = Game.battle.soul
        if soul then
            local s_left   = soul.x - (soul.width / 2)
            local s_right  = soul.x + (soul.width / 2)
            local s_top    = soul.y - (soul.height / 2)
            local s_bottom = soul.y + (soul.height / 2)
            
            local danger_distance = 1.0
            
            local dist_to_left   = s_left - self:getLeft()
            local dist_to_right  = self:getRight() - s_right
            local dist_to_top    = s_top - self:getTop()
            local dist_to_bottom = self:getBottom() - s_bottom
            
            local close_to_wall = (dist_to_left   <= danger_distance) or
                                  (dist_to_right  <= danger_distance) or
                                  (dist_to_top    <= danger_distance) or
                                  (dist_to_bottom <= danger_distance)

            if close_to_wall then
                if not self.fire_hurt_timer or self.fire_hurt_timer <= 0 then
                    for _, f in ipairs(Game.battle.party) do 
                        if self.damage then
                            f:hurt(12, true, {1, 0.45, 0})
                        end 
                    end 
                    self.fire_hurt_timer = 0.5
                end
            end 
        end 
    end 
end 

return arena
