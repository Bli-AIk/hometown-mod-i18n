---@class BGPaletteFX : FXBase
---@field base_pal number[][]
---@field live_pal number[][]
local BGPaletteFX, super = Class(FXBase)

BGPaletteFX.MAX_PALETTE_ENTRIES = 384

local lg = love.graphics

function BGPaletteFX:init(imagedata, line, transformed, priority)
    super.init(self, priority or 0)

    self.shader = Assets.newShader("bg_palette")
    self:setPalette(imagedata, line)
end

function BGPaletteFX:setPalette(imagedata, line)
    local path

    if type(imagedata) == "string" then
        path = imagedata
        imagedata = Assets.getTextureData(path)
        if not imagedata then
            Kristal.Console:warn("Missing palette, expected to find at "..path)
        end
    end

    if type(imagedata) == "userdata" then
        local height = imagedata:getHeight()

        if height > line then
            local width = imagedata:getWidth()

            local base = {}
            local live = {}

            for x = 1, width do
                local r,g,b,a = imagedata:getPixel(x - 1, 0)
                base[x] = {r,g,b,a}

                r,g,b,a = imagedata:getPixel(x - 1, line)
                live[x] = {r,g,b,a}
            end

            self.base_pal = base
            self.live_pal = live
        else
            Kristal.Console:warn(
                "Palette image "..(path and (path.." ") or "<unknown>") ..
                " doesn't have enough entries (expected at least "..line..
                ", got "..(height-1)..")"
            )
        end

    elseif type(imagedata) == "table" and type(line) == "table" then
        self.base_pal = imagedata
        self.live_pal = line
    end

    if self.base_pal and self.live_pal then
        local base = self.base_pal
        local live = self.live_pal

        local first_base = base[1]
        local first_live = live[1]

        local len = #base

        while len < self.MAX_PALETTE_ENTRIES do
            len = len + 1
            base[len] = first_base
            live[len] = first_live
        end

        self.shader:send("base_palette", unpack(base))
        self.shader:send("live_palette", unpack(live))
	self.shader:send("palette_size", #self.base_pal)
    end
end

function BGPaletteFX:isActive()
    return super.isActive(self) and self.base_pal and self.live_pal
end

function BGPaletteFX:draw(texture)
    local last_shader = lg.getShader()

    lg.setShader(self.shader)
    Draw.drawCanvas(texture)
    lg.setShader(last_shader)
end

return BGPaletteFX