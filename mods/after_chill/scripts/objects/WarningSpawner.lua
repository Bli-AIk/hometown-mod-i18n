local WarningSpawner, super = Class(Event)

function WarningSpawner:init(x, y, data)
    super.init(self, x, y, data.width, data.height)
    self.visible = false
    self.lane_count = data.properties["lanes"] or 5
    self.spacing = data.properties["spacing"] or 120
    self.custom_angle = data.properties["angle"] or -30
    self.used_length = data.properties["length"] or 600
    self.spawned_lanes = {}
    self.triggered = false 
end

function WarningSpawner:onEnter(player)
    if self.triggered then return end
    self.triggered = true
    
    self.spawned_lanes = {}
        Game.world.timer:after(0.1, function()
        if not self.triggered then return end     
        local mid_x = self.width / 2
        local mid_y = self.height / 2
        local center_x, center_y = self:getRelativePos(mid_x, mid_y)
        local total_width = (self.lane_count - 1) * self.spacing
        local half_width = total_width / 2     
        for i = 1, self.lane_count do
            local raw_offset = (i - 1) * self.spacing
            local centered_offset_x = raw_offset - half_width
            
            local is_even_lane = (i % 2 == 0)

            local line = Game.world:spawnBullet("warning_line", center_x + centered_offset_x, center_y, 8, self.used_length, is_even_lane, self.custom_angle)
            if line then
                table.insert(self.spawned_lanes, line)
            end
        end 
    end)

end

function WarningSpawner:onExit(player)
    self.triggered = false
    
    for _, line in ipairs(self.spawned_lanes) do
        if line then 
            line:remove()
        end
    end
    
    self.spawned_lanes = {}
    super.onExit(self, player)
end

return WarningSpawner
