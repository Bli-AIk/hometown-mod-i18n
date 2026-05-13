local actor, super = Class("noelle", true)

function actor:init()
    super.init(self)

    -- Table of sprite animations
    TableUtils.merge(self.animations, {
        ["fall"]         = {"dark", 1/6, true},
    }, false)
end

return actor