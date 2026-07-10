---@class kris_lw : Actor
local actor, super = Class("kris_lw", true)

function actor:init()
    super.init(self)

    self.animations = Utils.merge(self.animations, {
        ["make_fountain/grab_knife"] = {"make_fountain/grab_knife", 1/3, false},
        ["make_fountain/target"] = {"make_fountain/target", 1/15, false},
        ["make_fountain/make"] = {"make_fountain/make", 1/15, false, next="make_fountain/make_loop"},
        ["make_fountain/make_loop"] = {"make_fountain/make_loop", 1/15, true},
        ["make_fountain/stand_up"] = {"make_fountain/stand_up", 1/7.5, false, next="make_fountain/walk_scare/left"},
    })

    self.offsets = Utils.merge(self.offsets, {
        ["make_fountain/walk_scare/left"] = {-2, 3},

        ["make_fountain/grab_knife"] = {-6 - 2, -22 + 3},
        ["make_fountain/target"] = {-6 - 2, -22 + 3},
        ["make_fountain/make"] = {-6 - 2, -22 + 3},
        ["make_fountain/make_loop"] = {-6 - 2, -22 + 3},
        ["make_fountain/make_stop"] = {-6 - 2, -22 + 3},
        ["make_fountain/jump_off"] = {-6 - 2, -22 + 3},
        ["make_fountain/jump_off_landed"] = {-6 - 2, -22 + 3},
        ["make_fountain/stand_up"] = {-6 - 2, -22 + 3},
    })
end

return actor