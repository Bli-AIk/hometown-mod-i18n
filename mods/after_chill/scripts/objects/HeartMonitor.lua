---@class HeartMonitor : Object
local HeartMonitor, super = Class(Object)

---@param x number The starting X position
---@param y number The starting Y position
---@param range number The total horizontal length (pixels)
---@param speed number How fast the line draws (pixels per second)
---@param spike_start_x number The X offset where the first spike starts
---@param spike_height number How far up/down the spike goes (negative is up)
---@param spike_width number How wide each spike peak is
---@param spike_count number How many spikes to draw
---@param spike_interval number The distance between the start of each spike
---@param fade_speed number How fast it fades out (0 to disable)

---@class HeartMonitor : Object
local HeartMonitor, super = Class(Object)

function HeartMonitor:init(x, y, range, speed, spike_start_x, spike_height, spike_width, spike_count, spike_interval, fade_speed)
    super.init(self, x, y)
    
    self.points = {}
    self.range = range or 400
    self.base_speed = speed or 150
    self.current_speed = self.base_speed
    
    self.spike_start_x = spike_start_x or 0
    
    -- MODIFIED: Store spike_height as a table or turn a single number into a table
    if type(spike_height) == "table" then
        self.spike_height = spike_height
    else
        self.spike_height = {spike_height or 0}
    end
    
    self.spike_width = spike_width or 0
    self.spike_count = spike_count or 0
    self.spike_interval = spike_interval or 0
    
    self.fade_speed = fade_speed or 1.5
    
    self.current_x = 0
    self.active = true
    self.alpha = 1
    self.layer = 1000
end

function HeartMonitor:update()
    if not self.active then return end

    local last_spike_end = self.spike_start_x + (self.spike_count * self.spike_interval)
    if self.current_x > last_spike_end then
        self.current_speed = self.base_speed * 4.0 
    else
        self.current_speed = self.base_speed
    end

    self.current_x = self.current_x + (DT * self.current_speed)
    local next_y = 0

    for i = 0, self.spike_count - 1 do
        local start_point = self.spike_start_x + (i * self.spike_interval)
        local end_point = start_point + self.spike_width
        
        if self.current_x >= start_point and self.current_x <= end_point then
            local mid_point = start_point + (self.spike_width / 2)
            
            -- MODIFIED: Use specific height for this spike index, or fall back to the first one
            local current_spike_height = self.spike_height[i + 1] or self.spike_height[1]
            
            if self.current_x <= mid_point then
                local progress = (self.current_x - start_point) / (self.spike_width / 2)
                next_y = progress * current_spike_height
            else
                local progress = (end_point - self.current_x) / (self.spike_width / 2)
                next_y = progress * current_spike_height
            end
            break
        end
    end

    if self.current_x < self.range then
        table.insert(self.points, {self.current_x, next_y})
    else
        self.current_x = self.range
        if self.fade_speed > 0 then
            self.alpha = math.max(0, self.alpha - (DT * self.fade_speed))
        else
            self.active = false 
        end
    end

    if self.alpha <= 0 then
        self:remove()
    end
end

function HeartMonitor:draw()
    if #self.points < 2 or self.alpha <= 0 then return end
    
    -- Set line properties
    love.graphics.setLineWidth(2)
    -- Using a dark charcoal/black to match your background design
    love.graphics.setColor(0.15, 0.15, 0.15, self.alpha) 
    
    -- Unpack coordinates cleanly into flat 1D sequence array [x1, y1, x2, y2...]
    local draw_coords = {}
    for _, p in ipairs(self.points) do
        table.insert(draw_coords, p[1])
        table.insert(draw_coords, p[2])
    end
    
    if #draw_coords >= 4 then 
        love.graphics.line(draw_coords) 
    end
    love.graphics.setColor(1, 1, 1, 1)
end

return HeartMonitor
