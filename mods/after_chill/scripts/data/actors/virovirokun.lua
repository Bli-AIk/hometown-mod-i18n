local actor, super = Class(Actor, "virovirokun")

function actor:init()
    super.init(self)

    self.name = "Virovirokun"

    self.width = 32
    self.height = 32

    --self.hitbox = {0, 1, 37, 29}

    self.flip = "right"

    self.path = "enemies/virovirokun"
    self.default = "idle"

    self.animations = {
        ["idle"] = {"idle", 0.25, true},
        --["walk"] = {"walk", 0.15, true},
        ["spared"] = {"spared", 0, false},
        ["hurt"] = {"hurt", 0, false}
    }

    self.offsets = {
        ["idle"] = {0, 0},
        --["walk"] = {0, 0},
        ["spared"] = {0, 0},
        ["hurt"] = {0, 0},
    }
end

return actor