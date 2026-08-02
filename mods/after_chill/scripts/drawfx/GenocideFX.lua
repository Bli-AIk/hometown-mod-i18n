---@class GenocideFX: ShaderFX
---@field shader love.Shader
local GenocideFX, super = Class(ShaderFX)

function GenocideFX:init(priority)
    -- Hardcode heartbeat to false so the engine never tries to read the music track
    super.init(self, "hsv_transform", {}, nil, priority)

    -- Using the exact, professional ranges you liked from the original file
    self.hue_start = 0;
    self.sat_start = 0.5;       -- Normal saturation baseline
    self.val_start = 1;         -- Normal full brightness baseline
    
    self.hue_target = 0;
    self.sat_target = 0.05;     -- Smoothly drops down into an eerie grayed-out state
    self.val_target = 0.85;     -- Smoothly dims down to a clean twilight brightness
    
    self.hue = self.hue_start;
    self.sat = self.sat_start;
    self.val = self.val_start;
    self.wave_time = 4;         -- Increased to 4 seconds for a slower, more dramatic cinematic pulse
    self.heartbeat_mode = false -- Permanently disabled to kill the crash

    if (self.wave_time == 0) then
        self.hue = self.hue_target;
        self.sat = self.sat_target;
        self.val = self.val_target;
    end
end

function GenocideFX:update()
    super.update(self)
    if (self.wave_time > 0) then
        self.hue = Mod.scr_wave(self.hue_start, self.hue_target, self.wave_time, 0);
        self.sat = Mod.scr_wave(self.sat_start, self.sat_target, self.wave_time, 0);
        self.val = Mod.scr_wave(self.val_start, self.val_target, self.wave_time, 0);
    end
end

function GenocideFX:draw(texture)
    self.shader:send("_hsv", {self.hue, self.sat, self.val})
    super.draw(self, texture)
end

return GenocideFX
