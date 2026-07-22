local actor, super = Class(Actor, "shadow")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Shadow"

    -- Width and height for this actor, used to determine its center
    self.width = 19
    self.height = 37

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 25, 19, 14}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = { 1, 0, 0 }

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "enemies/shadow"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "left"

    -- Sound to play when this actor speaks (optional)
    self.voice = "shadow"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {
        [""] = 0.2
    }

    -- Table of sprite animations
    self.animations = { 
        ["ball"] = {"ball", 1/8, true}, 
        ["intro"] = {"intro", 1/15, false}, 
        ["fall"] = {"fall", 0.2, true},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = { 
        ["ready"] = {-8, -6},
        ["fall"] = {-19, -5},
    }
end

return actor
