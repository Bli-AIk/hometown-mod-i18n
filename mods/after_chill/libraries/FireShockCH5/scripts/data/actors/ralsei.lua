local actor, super = Class("ralsei", true)

function actor:init()
    super.init(self)
    TableUtils.merge(self.animations, {
        ["battle/fireball"] = {"battle/fireball", 1/9, false},
    }, false)

    TableUtils.merge(self.offsets, {
        ["battle/fireball"]  = {-8, -1},
    }, false)
end

return actor