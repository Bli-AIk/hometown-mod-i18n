local actor, super = Class("kris", true)

function actor:init()
    super.init(self)
    self.portrait_offset = {-20, -10}
    -- Table of sprite animations
    TableUtils.merge(self.animations, {
        ["sweep"]        = {"sweep", 1/4, true}, 
        ["swing"]        = {"swing/swing", 1/12, false}, 
    }, false)

    TableUtils.merge(self.offsets, {
        ["sweep"] = {-6, 7}, 
        ["swing"] = {-35, 11}
    }, false)
end

return actor