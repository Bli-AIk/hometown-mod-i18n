local arena, super = HookSystem.hookScript(Arena)

local fire_shader = love.graphics.newShader([[
    extern float progress; // Manually controlled by Lua (0.0 to 1.0)

    vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
        vec4 tex_color = Texel(tex, texture_coords);
        if (tex_color.a == 0.0) return tex_color;

        // If the pixel is below the fill line dictated by progress
        if (texture_coords.y > (1.0 - progress)) {
            vec3 flat_orange = vec3(1.0, 0.45, 0.0);
            vec3 final_rgb = mix(tex_color.rgb, flat_orange, 0.85);
            return vec4(final_rgb, tex_color.a) * color;
        }

        return tex_color * color;
    }
]])
local function addFireorDrain(self, should_charge, multiplier)
    local soul = Game.battle.soul
    if not soul or self.is_frozen then return end
    self.fire_charge = self.fire_charge or 0
    if should_charge then
        if not soul:getFX("soul_fire") then
            local fx = ShaderFX(fire_shader)
            soul:addFX(fx, "soul_fire")
        end
        self.fire_charge = math.min(1.0, self.fire_charge + (DT * multiplier))
    else
        self.fire_charge = math.max(0.0, self.fire_charge - (DT * multiplier))
        if self.fire_charge <= 0.0 and soul:getFX("soul_fire") then
            soul:removeFX("soul_fire")
        end
    end
    local soul_fx = soul:getFX("soul_fire")
    if soul_fx then
        soul_fx.shader:send("progress", self.fire_charge)
    end
end

function arena:setFire(should, damage)
    if should then 
        self.fiery = true
        self.damage = damage 
        self:setColor({1, 0.45, 0})
        
        self.fire_charge = 0
        self.is_frozen = false
        self.fire_grace_timer = 0
    else 
        self.damage = damage or false 
        self.fiery = should or false 
        
        if Game.battle.soul then
            Game.battle.soul:removeFX("soul_fire")
            Game.battle.soul.can_move = true
        end
    end 
end 

function arena:update()
    super.update(self)
    if self.fiery then 
        if self.fire_grace_timer and self.fire_grace_timer > 0 then
            self.fire_grace_timer = self.fire_grace_timer - DT
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
                addFireorDrain(self, true, 0.4)  
            else
                addFireorDrain(self, false, 1.0) 
            end
            
            self.fire_charge = self.fire_charge or 0
            if self.fire_charge >= 0.72 and not self.is_frozen and (not self.fire_grace_timer or self.fire_grace_timer <= 0) then
                self.is_frozen = true
                
                Assets.playSound("hurt") 
                
                for _, f in ipairs(Game.battle.party) do 
                    if self.damage then
                        f:hurt(35, true, {1, 0.45, 0})
                    end 
                end 
                self.fire_charge = math.max(0.0, self.fire_charge - 0.3)
                self.fire_grace_timer = 0.8
                self.is_frozen = false
                addFireorDrain(self, false, 0.4)
            end
        end
    end
end

return arena
