local WarningSpawner, super = Class(Event)

function WarningSpawner:init(x, y, data)
    super.init(self, x, y, data.width, data.height)
    self.visible = false
    self.lane_count = data.properties["lanes"] or 5
    self.spacing = data.properties["spacing"] or 120
    self.spawned_lanes = {}
    self.triggered = false 
end

function WarningSpawner:onEnter(player)
    if self.triggered then return end
    self.triggered = true
    
    self.spawned_lanes = {}
    Game.world.timer:after(0.3, function()
        if not self.triggered then return end
        
        for i = 1, self.lane_count do
            local offset_x = (i - 1) * self.spacing
            local is_even_lane = (i % 2 == 0)
            
            local line = Game.world:spawnBullet("warning_line", self.x + offset_x, self.y, 8, 600, is_even_lane)
            if line then
                table.insert(self.spawned_lanes, line)
            end
        end
    end)
end

function WarningSpawner:onExit(player)
    self.triggered = false
    
    for _, line in ipairs(self.spawned_lanes) do
        if line.parent then
            if line.active_triangles then
                for _, triangle in ipairs(line.active_triangles) do
                    if triangle.parent then triangle:remove() end
                end
            end
            line:remove()
        end
    end
    
    self.spawned_lanes = {}
    super.onExit(self, player)
end

return WarningSpawner
