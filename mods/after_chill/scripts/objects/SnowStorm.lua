local SnowStorm, super = Class(Object)

function SnowStorm:init(x, y, shape)
    super.init(self, x, y, shape)
end

function SnowStorm:update()
    --target x
    local tx = Mathutils.random(0, 640)
    --target y
    local ty = Mathutils.random(0, 480)
end

return SnowStorm