local DWExit, super = Class(Event)

function DWExit:init(data)
    super.init(self, data.center_x, data.center_y, data.width, data.height)
    properties = data.properties or {}


    local map = properties["newmap"]

    local t = LightTransition(0, 40, map)

    t:setLayer(WORLD_LAYERS["top"] + 1)

	self:addChild(t)
	
	self.light = t
    self.light.map = map
end

return DWExit