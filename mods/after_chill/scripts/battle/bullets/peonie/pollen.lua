---@class pollen : Bullet
local pollen, super = Class(Bullet)

function pollen:init(x, y, angle)
    super.init(self, x, y, "bullets/pollen")
    self:setOrigin(0.5, 0.5)
    self:setScale(0.1)
    self.target_scale = 1.6
    self.current_scale = 0.1
    self.center_x = x
    self.center_y = y
    self.angle = angle
    self.current_radius = 15
    self.target_radius = 75
    
    self.phase = "travel"
    self.phase_timer = 0
    self.pulse_timer = love.math.random() * 10
end

function pollen:update()
    self.phase_timer = self.phase_timer + DT
    self.pulse_timer = self.pulse_timer + (DT * 4.0)
    local soul = Game.battle.soul

    if self.phase == "travel" then
        if self.current_scale < self.target_scale then
            self.current_scale = MathUtils.approach(self.current_scale, self.target_scale, 3.5 * DT)
        end
        if self.current_radius < self.target_radius then
            self.current_radius = MathUtils.approach(self.current_radius, self.target_radius, 140 * DT)
        end
        local target_angle = MathUtils.angle(self.center_x, self.center_y, soul.x, soul.y)
        self.center_x = self.center_x + math.cos(target_angle) * (110 * DT)
        self.center_y = self.center_y + math.sin(target_angle) * (110 * DT)
        local dist = MathUtils.dist(self.center_x, self.center_y, soul.x, soul.y)
        if dist < 30 then
            self.phase = "lock_warn"
            self.phase_timer = 0
            local flash = self:addFX(ColorMaskFX({1, 1, 1}, 1))
            Game.battle.timer:tween(0.15, flash, {amount = 0}, "linear", function()
                self:removeFX(flash)
            end)
        end

    elseif self.phase == "lock_warn" then
        if self.phase_timer >= 0.2 then
            self.phase = "implode"
            self.phase_timer = 0
        end

    elseif self.phase == "implode" then
        self.current_radius = self.current_radius - (320 * DT)
        self.current_scale = MathUtils.approach(self.current_scale, 0.8, 5 * DT)
        
        if self.current_radius <= 6 then
            self.current_radius = 6
            self.phase = "explode"
            self.phase_timer = 0
            Assets.playSound("bigcut", 0.3)
        end

    elseif self.phase == "explode" then
        self.current_radius = self.current_radius + (550 * DT)
        self.current_scale = self.current_scale + (6 * DT)
        self.alpha = self.alpha - (DT * 2.5)
        if self.alpha <= 0 then
            self:remove()
            return
        end
    end
    local breathing_offset = 0
    if self.phase == "travel" then
        breathing_offset = math.sin(self.pulse_timer) * 3
    end

    local final_radius = self.current_radius + breathing_offset
    self.x = self.center_x + (math.cos(self.angle) * final_radius)
    self.y = self.center_y + (math.sin(self.angle) * final_radius)
    
    self.rotation = self.rotation + (1.2 * DT)
    self:setScale(self.current_scale)
    super.update(self)
end

function pollen:onCollide(soul)
    if self.heal then 
        for _, party in ipairs(Game.battle.party) do
        party:heal(14)
       end
       self:remove()
    else 
        return super.onCollide(self, soul)
    end 
end 

return pollen
