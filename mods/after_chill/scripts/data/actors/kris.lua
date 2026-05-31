local actor, super = Class("kris", true)

function actor:init()
    super.init(self)
    self.portrait_offset = {-20, -10}
    -- Table of sprite animations
    TableUtils.merge(self.animations, {
        ["sweep"]        = {"battle/sweep", 1/4, true}
    }, false)
end

return actor