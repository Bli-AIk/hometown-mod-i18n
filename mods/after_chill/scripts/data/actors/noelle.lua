local actor, super = Class("noelle", true)

function actor:init()
    super.init(self)
    self.portrait_offset = {-20, -10}
    -- Table of sprite animations
    TableUtils.merge(self.animations, {
        ["fall"]         = {"dark", 1/6, true},
        ["float"]        = {"battle_alt/float", 1/8, true},
        ["pray"]         = {"battle_alt/pray", 1/6, true},
    }, false)
end

return actor